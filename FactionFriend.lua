------------------------------------------------------
-- Addon loading & shared infrastructure
------------------------------------------------------
local addonName, T = ...
_G[addonName] = T

local DB = _G[addonName.."_DB"]

T.Title = C_AddOns.GetAddOnMetadata(addonName, "Title")
T.Version = C_AddOns.GetAddOnMetadata(addonName, "Version")

-- event handling
T.EventFrame = CreateFrame("Frame")
T.EventFrame:SetScript("OnEvent", function(self, event, ...)
	local handler = T.EventHandlers[event]
	assert(handler, "Missing event handler for registered event "..event)
	handler(T.EventFrame, ...)
end)
T.EventHandlers = setmetatable({}, {__newindex = function(table, key, value)
	assert(type(value) == 'function', "Members of this table must be functions")
	rawset(table, key, value)
	T.EventFrame:RegisterEvent(key)
end })
local Events = T.EventHandlers

-- saved variables
_G[addonName .. "_Settings"] = {}
_G[addonName .. "_Recents"] = {}

-- FormatToPattern cache
T.Patterns = setmetatable({}, {__index = function(table, key)
	-- TODO does FormatToPattern correctly handle reordered format string tokens?
	return GFWUtils.FormatToPattern(_G[key])
end})


------------------------------------------------------
-- Constants
------------------------------------------------------

local GUILD_FACTION_ID = 1168

------------------------------------------------------
-- Utilities
------------------------------------------------------

-- infinite loop protection; 366 known factions on wowhead as of patch 11.1
T.MAX_FACTIONS = 600

-- TODO: cache some of these all at once instead of memoized?

T.FactionIndexForID = setmetatable({}, {__index = function(table, key)
	for index = 1, T.MAX_FACTIONS do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if not factionData then break end
		if factionData.factionID == key then
			return index
		end
	end
end})

T.FactionIDForName = setmetatable({}, {__index = function(table, key)
	for index = 1, T.MAX_FACTIONS do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if not factionData then break end
		if factionData.name == key then
			return factionData.factionID
		end
	end
end})

local MAX_RECENTS = 8
function T:AddToRecents(factionID)
	-- remove it if it's already in the list
	for index, id in pairs(T.Recents) do
		if id == factionID then
			-- remove shuffles down later indices
			tremove(T.Recents, index)
			break
		end
	end
	
	-- (re)insert it at the end
	tinsert(T.Recents, factionID)
	
	-- cap the list size by keeping the last MAX_RECENTS elements
	if #T.Recents > MAX_RECENTS then
		-- rebuilding table breaks references, reconnect them
		_G[addonName .. "_Recents"] = { unpack(T.Recents, #T.Recents - MAX_RECENTS + 1) }
		T.Recents = _G[addonName .. "_Recents"]
	end
end

EventRegistry:RegisterCallback("SetItemRef", function(ownerID, link)
	local type, addon, subtype, id = strsplit(":", link)
	if type == "addon" and addon == addonName and subtype == "faction" then
		T:ShowReputationPane(tonumber(id), forceAll)
	end
end)

function T:FactionLink(factionID, factionData, friendshipData)
	if not factionData then
		factionData = C_Reputation.GetFactionDataByID(factionID)
	end
	if not friendshipData then
		friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)
	end
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	
	local color
	if isFriendship then
		color = RGBTableToColorCode(FACTION_BAR_COLORS[5])
	elseif C_Reputation.IsMajorFaction(factionID) then
		color = RGBTableToColorCode(BLUE_FONT_COLOR)
		
	else
		color = RGBTableToColorCode(FACTION_BAR_COLORS[factionData.reaction])
	end
	
	return format("%s|Haddon:%s:faction:%d|h[%s]|h|r", color, addonName, factionID, factionData.name)
end

function T:TrySetWatchedFaction(factionID, overrideInactive)

	local function setWatchedFaction(factionID)
		C_Reputation.SetWatchedFactionByID(factionID)
		self:AddToRecents(factionID)
	end
	
	local watchedFaction = C_Reputation.GetWatchedFactionData()
	if watchedFaction and watchedFaction.factionID == factionID then
		-- print("no switch: already watching factionID", factionID)
		return
	end
	
	if overrideInactive then
		setWatchedFaction(factionID)
	else
		
		local index = self.FactionIndexForID[factionID]
		if not index then
			-- print("no switch: index not found for factionID", factionID)
			return
		end
	
		if C_Reputation.IsFactionActive(index) then
			setWatchedFaction(factionID)
		end
	end
end

function T:ShowFactionToolip(factionID, anchorFrame, anchor, showHyperlinkInstructions)
	-- TODO factor out the rest because it'll be the same as other places we show tooltip for the same faction?
	local factionData = C_Reputation.GetFactionDataByID(factionID)
	local friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	
	if anchor then
		GameTooltip:SetOwner(anchorFrame, "ANCHOR_TOPLEFT")
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, anchorFrame)
	end
	GameTooltip_SetTitle(GameTooltip, factionData.name, HIGHLIGHT_FONT_COLOR)
	
	if C_Reputation.IsAccountWideReputation(factionID) then
		GameTooltip_AddColoredLine(GameTooltip, REPUTATION_TOOLTIP_ACCOUNT_WIDE_LABEL, ACCOUNT_WIDE_FONT_COLOR, false)
	end
		
	local standingText, color
	if isFriendship then
		local wrapText = true
		GameTooltip:AddLine(friendshipData.text, nil, nil, nil, wrapText)
		local reactionText = friendshipData.reaction
		if friendshipData.nextThreshold then
			local current = friendshipData.standing - friendshipData.reactionThreshold
			local max = friendshipData.nextThreshold - friendshipData.reactionThreshold
			reactionText = reactionText.." ("..current.." / "..max..")"
		end
		GameTooltip_AddHighlightLine(GameTooltip, reactionText, wrapText)
		
	elseif C_Reputation.IsMajorFaction(factionID) then
		local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
		
		local current = majorFactionData.renownReputationEarned
		local max = majorFactionData.renownLevelThreshold
		
		local renownLevel = RENOWN_LEVEL_LABEL:format(majorFactionData.renownLevel)
		local text = FFF_STANDING_VALUES:format(renownLevel, current, max)
					
		GameTooltip_AddColoredLine(GameTooltip, text, BLUE_FONT_COLOR)

	else		
		local standingText = GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player"))
		local color = FACTION_BAR_COLORS[factionData.reaction]
		
		local current = factionData.currentStanding - factionData.currentReactionThreshold
		local max = factionData.nextReactionThreshold - factionData.currentReactionThreshold
		
		local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
		if not isCapped then
			standingText = FFF_STANDING_VALUES:format(standingText, current, max)
		end
		GameTooltip_AddColoredLine(GameTooltip, standingText, color)
	end
	
	-- more lines from potential gains report
	T:TooltipAddFactionReport(GameTooltip, factionID)
	
	if (showHyperlinkInstructions) then
		GameTooltip_AddBlankLineToTooltip(GameTooltip)
		if InCombatLockdown() then
			GameTooltip_AddInstructionLine(GameTooltip, FFF_TOOLTIP_DONT_CLICK)
		else
			GameTooltip_AddInstructionLine(GameTooltip, FFF_TOOLTIP_CLICK_FOR_DETAILS)
		end
	end
	
	GameTooltip:Show()

end

function T:GetCollapsedFactionHeaders()
	local collapsed = {}
	for i = 1, T.MAX_FACTIONS do
		local data = C_Reputation.GetFactionDataByIndex(i)
		if not data then break end
		if data.isCollapsed and data.factionID ~= 0 then
			collapsed[data.factionID] = true
		end
	end
	return collapsed
end

function T:SetCollapsedFactionHeaders(collapsed)
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if collapsed[data.factionID] then
			C_Reputation.CollapseFactionHeader(index)
		end
	end	
end

function T:ExpandAllFactionHeaders(includeSubheaders, includeInactive)
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if data.isHeader and not data.isChild then
			if data.name ~= FACTION_INACTIVE or includeInactive then
				C_Reputation.ExpandFactionHeader(index)
			end
		elseif data.isHeader and data.isChild then
			if includeSubheaders then
				C_Reputation.ExpandFactionHeader(index)
			end
		end
	end
end

function T:CollapseAllFactionHeaders(includeSubheaders)
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if data.isHeader and not data.isChild then
			C_Reputation.CollapseFactionHeader(index)
		elseif data.isHeader and data.isChild then
			if includeSubheaders then
				C_Reputation.CollapseFactionHeader(index)
			end
		end
	end
end

function T:FactionAtMaximum(factionData) 
	local id = factionData.factionID
	local friendshipData = C_GossipInfo.GetFriendshipReputation(id)
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	if isFriendship then
		return friendshipData.nextThreshold == nil
	elseif C_Reputation.IsMajorFaction(id) then
		return C_MajorFactions.HasMaximumRenown(factionID)
	else
		return factionData.reaction == MAX_REPUTATION_REACTION and not C_Reputation.IsFactionParagon(id)
	end
end

function T:CleanUpCompletedFactions()
	-- remember current expand/collapse state
	local collapsed = T:GetCollapsedFactionHeaders()
	
	-- expand all so we can see the whole list
	local includeSubheaders = true
	T:ExpandAllFactionHeaders(includeSubheaders)
	
	-- iterate visible faction list backwards 
	-- because moving changes positions after
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if T:FactionAtMaximum(data) and data.factionID ~= GUILD_FACTION_ID then
			-- print("moving", data.name, "to inactive")
			C_Reputation.SetFactionActive(index, false)
		end
	end
	
	-- restore expand/collapse state
	T:SetCollapsedFactionHeaders(collapsed)
end

------------------------------------------------------
-- GFW_HoverTips integration
------------------------------------------------------

function T.ShowAddonTooltip(frame, link)
	-- "addon":addonName:type:payload
	local _, _, type, factionID = strsplit(":", link)
	factionID = tonumber(factionID)
	
	T:ShowFactionToolip(factionID, frame, "ANCHOR_TOPLEFT", true)
end

------------------------------------------------------
-- Events
------------------------------------------------------

function Events:ADDON_LOADED(addon, ...)
	if addon == addonName then
		
		-- conveniences for generated SavedVariables names
		-- works only after SavedVariables have been loaded
		T.Settings = _G[addonName .. "_Settings"]
		T.Recents = _G[addonName .. "_Recents"]
		
		ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_FACTION_CHANGE", T.CombatMessageFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", T.SystemMessageFilter)

		for i, container in pairs(StatusTrackingBarManager.barContainers) do
			local bar = container.bars[1]
			bar:HookScript("OnEnter", function(frame)
				-- TODO potential gains in tooltip
				-- TODO in the paragon tooltip for paragon
				if frame.factionID and not C_Reputation.IsFactionParagon(frame.factionID) then
					T:ShowFactionToolip(frame.factionID, frame)
				end
			end)
			bar:HookScript("OnLeave", GameTooltip_Hide)
		end

		T:SetupSettings()
		
		self:UnregisterEvent("ADDON_LOADED")
	end
end

------------------------------------------------------
-- Item tooltip 
------------------------------------------------------


function T:SetupReverseCache()
	DB.TurninsByItem = {}	
	for faction, quests in pairs(DB.TurninsByQuest) do
		local myExcludedFactions = DB.ExcludedFactions[UnitFactionGroup("player")]
		if (myExcludedFactions ~= nil and not myExcludedFactions[faction]) then
			for quest, questInfo in pairs(quests) do
				if (not questInfo.otherFactionRequired) then
					for itemID in pairs(questInfo.items) do
						if not DB.TurninsByItem[itemID] then
							DB.TurninsByItem[itemID] = {}
						end
						DB.TurninsByItem[itemID][faction] = true
					end
				end
			end
		end
	end
end

function T.OnTooltipSetItem(tooltip, data)
	local name, link = TooltipUtil.GetDisplayedItem(tooltip)
	if not link then return end
	if not T.Settings.Tooltip then return end

	local type, info = LinkUtil.ExtractLink(link)
	if type == "item" then 
		local id = strsplit(":", info)
		local itemID = tonumber(id)
		T:TooltipAddItemInfo(tooltip, itemID)
	end
	-- TODO also handle currency?
	
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, T.OnTooltipSetItem)

function T:TooltipAddItemInfo(tooltip, itemID)
	if not DB.TurninsByItem then 
		T:SetupReverseCache()
	end
	local itemInfo = DB.TurninsByItem[itemID]
	if not itemInfo then return end

	local firstLine = true
	for factionID in pairs(itemInfo) do
		
		-- TODO major faction renown
		
		local factionData = C_Reputation.GetFactionDataByID(factionID)
		local color = FACTION_BAR_COLORS[factionData.reaction]
		local standingText = GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player"))
		
		if firstLine then
			GameTooltip_AddBlankLineToTooltip(GameTooltip)
			GameTooltip_AddNormalLine(tooltip, FFF_FACTION_TURNIN)
			firstLine = false
		end
		GameTooltip_AddColoredDoubleLine(tooltip, factionData.name, standingText, HIGHLIGHT_FONT_COLOR, color)
	end

end

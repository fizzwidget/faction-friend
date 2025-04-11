------------------------------------------------------
-- Addon loading & shared infrastructure
------------------------------------------------------
local addonName, T = ...
_G[addonName] = T

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

FFF_PointsPerStanding = {
	[1] = 36000,	-- Hated
	[2] = 3000,		-- Hostile
	[3] = 3000,		-- Unfriendly
	[4] = 3000,		-- Neutral
	[5] = 6000,		-- Friendly
	[6] = 12000,	-- Honored
	[7] = 21000,	-- Revered
	[8] = 999,
}
FFF_AbsMinForStanding = {
	[1] = 0 - FFF_PointsPerStanding[3] - FFF_PointsPerStanding[2] - FFF_PointsPerStanding[1],
	[2] = 0 - FFF_PointsPerStanding[3] - FFF_PointsPerStanding[2],
	[3] = 0 - FFF_PointsPerStanding[3],
	[4] = 0,
	[5] = FFF_PointsPerStanding[4],
	[6] = FFF_PointsPerStanding[4] + FFF_PointsPerStanding[5],
	[7] = FFF_PointsPerStanding[4] + FFF_PointsPerStanding[5] + FFF_PointsPerStanding[6],
	[8] = FFF_PointsPerStanding[4] + FFF_PointsPerStanding[5] + FFF_PointsPerStanding[6] + FFF_PointsPerStanding[7],
	[9] = FFF_PointsPerStanding[4] + FFF_PointsPerStanding[5] + FFF_PointsPerStanding[6] + FFF_PointsPerStanding[7] + FFF_PointsPerStanding[8],
}

local GUILD_FACTION_ID = 1168

------------------------------------------------------
-- Utilities
------------------------------------------------------

-- infinite loop protection; 366 known factions on wowhead as of patch 11.1
local MAX_FACTIONS = 600

-- TODO: cache some of these all at once instead of memoized?

T.FactionIndexForID = setmetatable({}, {__index = function(table, key)
	for index = 1, MAX_FACTIONS do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if not factionData then break; end
		if factionData.factionID == key then
			return index
		end
	end
end})

T.FactionIDForName = setmetatable({}, {__index = function(table, key)
	for index = 1, MAX_FACTIONS do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if not factionData then break; end
		if factionData.name == key then
			return factionData.factionID
		end
	end
end})

T.BodyguardFactionID = FFF_Bodyguards

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
		T:ShowReputationPane(tonumber(id))
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

function T:ShowReputationPane(factionID)
	-- TODO: refactor for similarity with popup menu
	
	-- force all filtering off
	-- (can't know if factionID will be hidden by filters)
	C_Reputation.SetLegacyReputationsShown(true)
	C_Reputation.SetReputationSortType(0)
	
	-- remember collapsed headers
	local collapsed = {}
	for i = 1, MAX_FACTIONS do
		local data = C_Reputation.GetFactionDataByIndex(i)
		if not data then break; end
		if data.isCollapsed then
			collapsed[data.factionID] = true
		end
	end
		
	C_Reputation.ExpandAllFactionHeaders()
	
	-- iterate again to find headers containing factionID
	local headerID, subHeaderID
	for index = 1, C_Reputation.GetNumFactions() do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if data.isHeader and not data.isChild then
			headerID = data.factionID
			subHeaderID = nil
		elseif data.isHeader and data.isChild then
			subHeaderID = data.factionID
		end
		if factionID == data.factionID then
			if factionID == subHeaderID then
				-- found factionID has rep and children
				-- don't override collapse state
				subHeaderID = nil
			end
			break
		end
	end
	
	-- TODO: finding under sub headers doesn't work when header starts collapsed
	
	-- override collapsed state for parents of factionID
	local parentNames = {}
	if subHeaderID then
		tinsert(parentNames, C_Reputation.GetFactionDataByID(subHeaderID).name)
		collapsed[subHeaderID] = nil
	end
	tinsert(parentNames, C_Reputation.GetFactionDataByID(headerID).name)
	collapsed[headerID] = nil
	print(
		C_Reputation.GetFactionDataByID(factionID).name,
		"parents:",
		strjoin(", ", unpack(parentNames))
	)
	
	-- restore collapsed state
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if collapsed[data.factionID] then
			C_Reputation.CollapseFactionHeader(index)
		end
	end
	
	-- select the faction and scroll to it
	C_Reputation.SetSelectedFaction(T.FactionIndexForID[factionID])
	
	-- update rep frame & show it if we can
	if not ReputationFrame:IsVisible() and InCombatLockdown() then
		UIErrorsFrame:AddMessage(ERR_CANT_DO_THAT_RIGHT_NOW, RED_FONT_COLOR:GetRGBA())
		return
	elseif ReputationFrame:IsVisible() then
		ReputationFrame:Update()
	else
		ToggleCharacter("ReputationFrame")
	end
	-- scroll faction to visible
	ReputationFrame.ScrollBox:ScrollToElementDataByPredicate(function(elementData) return elementData.factionID == factionID; end)

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
	
	GameTooltip_AddBlankLineToTooltip(GameTooltip)
	
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
	
	-- TODO more lines from potential gains report
	
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

_G[addonName.."_DB"] = {}
local DB = _G[addonName.."_DB"]
DB.ByQuest = FFF_ItemInfo -- TODO move some of this?

function T:SetupReverseCache()
	DB.ByItem = {}	
	for faction, quests in pairs(FFF_ItemInfo) do
		local myExcludedFactions = FFF_ExcludedFactions[UnitFactionGroup("player")];
		if (myExcludedFactions ~= nil and not myExcludedFactions[faction]) then
			for quest, questInfo in pairs(quests) do
				if (not questInfo.otherFactionRequired) then
					for itemID in pairs(questInfo.items) do
						if not DB.ByItem[itemID] then
							DB.ByItem[itemID] = {}
						end
						DB.ByItem[itemID][faction] = true
					end
				end
			end
		end
	end
end

function T.OnTooltipSetItem(tooltip, data)
	local name, link = TooltipUtil.GetDisplayedItem(tooltip)
	if not link then return; end
	if not T.Settings.Tooltip then return; end

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
	if not DB.ByItem then 
		T:SetupReverseCache()
	end
	local itemInfo = DB.ByItem[itemID]
	if not itemInfo then return; end

	local firstLine = true
	for factionID in pairs(itemInfo) do
			
		local factionData = C_Reputation.GetFactionDataByID(factionID)
		local color = FACTION_BAR_COLORS[factionData.reaction]
		local factionText = FFF_FACTION_STANDING:format(factionData.name, GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player")))
		
		if firstLine then
			GameTooltip_AddColoredDoubleLine(tooltip, FFF_FACTION_TURNIN, factionText, color, color)
			firstLine = false
		else
			GameTooltip_AddColoredDoubleLine(tooltip, " ", factionText, color, color)
		end
	end

end


------------------------------------------------------
-- Message filter for reputation / standing change
------------------------------------------------------

function T:ParseFactionMessage(message, patternList)
	for _, pattern in pairs(patternList) do
		local regex = T.Patterns[pattern]
		local match1, match2 = strmatch(message, regex)
		if match1 then
			-- for the patterns we use:
			-- faction amount gain: match1 is factionName, match1 is amount or nil
			-- faction standing change: match1 is new standing, match2 is factionName or nil
			return match1, match2, pattern
		end
	end
end

function T:FactionAmountChangeFromMessage(message)
	
	local factionName, amount, pattern

	-- patterns from format strings in BlizzardInterfaceResources/GlobalStrings/[locale].lua
	local decreasePatterns = {
		"FACTION_STANDING_DECREASED",
		"FACTION_STANDING_DECREASED_ACCOUNT_WIDE",
		"FACTION_STANDING_DECREASED_GENERIC", -- no amount
		"FACTION_STANDING_DECREASED_GENERIC_ACCOUNT_WIDE", -- no amount
	}
	local increasePatterns = {
		"FACTION_STANDING_INCREASED",
		"FACTION_STANDING_INCREASED_ACCOUNT_WIDE",
		"FACTION_STANDING_INCREASED_ACH_BONUS",
		"FACTION_STANDING_INCREASED_ACH_BONUS_ACCOUNT_WIDE",
		"FACTION_STANDING_INCREASED_BONUS",
		"FACTION_STANDING_INCREASED_DOUBLE_BONUS",
		"FACTION_STANDING_INCREASED_GENERIC", -- no amount
		"FACTION_STANDING_INCREASED_GENERIC_ACCOUNT_WIDE", -- no amount
	}
	 
	factionName, amount, pattern = self:ParseFactionMessage(message, decreasePatterns)
	if (factionName) then
		if amount then
			amount = tonumber(amount) * -1 
		else
			amount = 0
		end
		return factionName, amount, pattern
	end

	factionName, amount, pattern = self:ParseFactionMessage(message, increasePatterns)
	if (factionName) then
		if amount then
			amount = tonumber(amount)
		else
			amount = 0
		end
		return factionName, amount, pattern
	end
end

T.QueuedFactionGains = {}
T.QueuedFactionGainsCheckTimer = nil
function T:QueuedFactionGainsCheck(timer)
	if #T.QueuedFactionGains == 0 then
		T.QueuedFactionGainsCheckTimer:Cancel()
		return
	end
	
	sort(T.QueuedFactionGains, function(a, b) return a.amount > b.amount end)
	
	local highestGainFactionID = T.QueuedFactionGains[1].id
	T:TrySetWatchedFaction(highestGainFactionID)
	wipe(T.QueuedFactionGains)
end

function T:CombatMessageFilter(event, message, ...)	
	local factionName, amount, pattern = T:FactionAmountChangeFromMessage(message)
	local factionID = T.FactionIDForName[factionName]
		
	-- add to recents
	T:AddToRecents(factionID)
	
	-- check name of guild faction
	-- message might have either actual guild name or a generic token
	if not factionID and (factionName == GUILD or factionName == GUILD_REPUTATION) then
		factionID = GUILD_FACTION_ID
		factionName = GetGuildInfo("player")
	end
	
	-- switch watched faction only for gains
	if amount > 0 and T:ShouldSetWatchedFaction(factionID) then
		-- accumulate recent changes, switch bar only for the "best"
		-- e.g. 5 everlook, 5 ratchet, 10 gadgetzan, 5 booty bay -> switch to gadgetzan
		tinsert(T.QueuedFactionGains, { id = factionID, amount = amount })
		if T.QueuedFactionGainsCheckTimer then
			T.QueuedFactionGainsCheckTimer:Cancel()
		end
		T.QueuedFactionGainsCheckTimer = C_Timer.NewTimer(0.5, T.QueuedFactionGainsCheck)
	end
	
	local factionData = C_Reputation.GetFactionDataByID(factionID)
	local friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0

	-- move to inactive if exalted / max rank
		-- unless paragon faction
			-- unless setting to do that anyway?
	
	-- output modified message according to settings
	if not T.Settings.ModifyChat then
		return false
	end
		
	local link = T:FactionLink(factionID, factionData, friendshipData)
	
	local message
	if amount > 0 then
		local addendum = T:RepeatGainsMessage(factionID, amount, factionData, friendshipData)
		message = format(_G[pattern], link, amount) .. " " .. addendum
	else
		message = format(_G[pattern], link)
	end
	
	return false, message, ...
end

function T:FactionStandingChangeFromMessage(message)
	local newStanding, factionName, pattern

	local factionPatterns = {
		"FACTION_STANDING_CHANGED",
		"FACTION_STANDING_CHANGED_ACCOUNT_WIDE",
	}
	
	local friendshipPatterns = {
		"FRIENDSHIP_STANDING_CHANGED",
		"FRIENDSHIP_STANDING_CHANGED_ACCOUNT_WIDE",
	}
	local guildPatterns = {
		"FACTION_STANDING_CHANGED_GUILD", -- no factionName
		"FACTION_STANDING_CHANGED_GUILDNAME",
	}
	
	local isGuild, isFriendship
	
	newStanding, factionName, pattern = self:ParseFactionMessage(message, factionPatterns)
	if factionName then
		return newStanding, factionName, pattern
	end
	
	-- these reverse standing and factionName
	factionName, newStanding, pattern = self:ParseFactionMessage(message, friendshipPatterns)
	if factionName then
		isFriendship = true
		return newStanding, factionName, pattern, isFriendship, isGuild
	end
	
	newStanding, factionName, pattern = self:ParseFactionMessage(message, guildPatterns)
	if factionName then
		isGuild = true
		return newStanding, factionName, pattern, isFriendship, isGuild
	end

end

function T:SystemMessageFilter(event, message, ...)
	local newStanding, factionName, pattern, isFriendship, isGuild = T:FactionStandingChangeFromMessage(message)
	if not newStanding then
		-- lots of CHAT_MSG_SYSTEM we're not interested in
		return false
	end

	local factionID = T.FactionIDForName[factionName]
	if not factionID and isGuild then
		factionID = GUILD_FACTION_ID
		factionName = GetGuildInfo("player")
	end
			
	-- add to recents
	T:AddToRecents(factionID)
		
	-- (don't switch watched faction; we do that only for gains)
	
	-- move to inactive if exalted / max rank
	-- unless paragon faction
		-- unless setting to do that anyway?

	-- TODO queued message stuff from original version?

	-- output modified message according to settings
	if not T.Settings.ModifyChat then
		return false
	end
	
		
	local factionData = C_Reputation.GetFactionDataByID(factionID)
	local friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)

	local link = T:FactionLink(factionID, factionData, friendshipData)
	
	local message
	if isFriendship then
		message = format(_G[pattern], link, newStanding)
	else
		message = format(_G[pattern], newStanding, link)		
	end
	
	return false, message, ...

end

function T:ShouldSetWatchedFaction(factionID)
	if factionID == GUILD_FACTION_ID then
		return self.Settings.IncludeGuild
	elseif self.BodyguardFactionID[factionID] then
		return self.Settings.IncludeBodyguards
	end
	return true
end

function T:RepeatGainsMessage(factionID, amount, factionData, friendshipData)
	local maxValue, currentValue
	local nextStatusName
	
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	local isMaxRank = friendshipData.nextThreshold == nil
	if isFriendship then
		if isMaxRank then
			return FFF_AT_MAXIMUM
		else
			maxValue = friendshipData.nextThreshold
			currentValue = friendshipData.standing
			nextStatusName = FFF_NEXT_RANK -- can't get next name for friendships
		end
	else
		-- TODO also branch for major faction (renown)?
		
		local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
		if C_Reputation.IsFactionParagon(factionID) then
			local currentStanding, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)

			maxValue = threshold

			-- TODO is this condition applicable?
			-- if ( not hasRewardPending and currentValue and threshold ) then
			currentValue = mod(currentStanding, threshold)
			-- show overflow if reward is pending
			if hasRewardPending then
				currentValue = currentValue + threshold
			end
			nextStatusName = FFF_PARAGON_REWARD
		elseif isCapped then
			return FFF_AT_MAXIMUM
		else
			maxValue = factionData.nextReactionThreshold
			currentValue = factionData.currentStanding
			
			local nextStanding = factionData.reaction + 1
			nextStatusName = GetText("FACTION_STANDING_LABEL"..nextStanding, UnitSex("player"))
		end
	end
	
	local repToNext = maxValue - currentValue;
	local gainsToNext = repToNext / amount;
	local message = format(FFF_REPEAT_TURNINS, gainsToNext, nextStatusName)
	-- TODO color nextStatusName?
	
	return message
end

------------------------------------------------------
-- Potential gains from turnins
------------------------------------------------------

function T:FactionPotential(factionID, withReport)

	local function reactionInRange(reaction, qInfo)
		local atOrAboveMin = reaction >= (qInfo.minStanding or 1)
		local atOrBelowMax = reaction <= (qInfo.maxStanding or MAX_REPUTATION_REACTION)
		return atOrAboveMin and atOrBelowMax
	end

	local factionData = C_Reputation.GetFactionDataByID(factionID)
	
	local factionQuests = DB.ByQuest[factionID]
	if (factionQuests == nil) then return 0; end
	
	local totalPotential = 0
	local reportLines = {}

	local itemsAccounted = {}
	local itemsCreated = {}
	for quest, qInfo in GFWTable.PairsByKeys(factionInfo, function(a,b) return a > b end) do
		-- is our rep in range for this quest?
		local meetsRequirements = reactionInRange(factionData.reaction, qInfo)
		
		-- if quest requires another faction too,
		-- is our rep with them in range?
		if meetsRequirements and qInfo.otherFactionRequired then
			local otherFactionData = C_Reputation.GetFactionDataByID(qInfo.otherFactionRequired.faction)
			meetsRequirements = meetsRequirements and reactionInRange(otherFactionData.reaction, qInfo.otherFactionRequired)
		end
		
		local potentialValue = T:QuestPotential(qInfo, factionData)
	end


end

function T:QuestPotential(qInfo, factionData)
	local potentialValue = 0
	local reportItemLines = {}
	
	-- first, figure out how many turnins' worth we have of each item the quest requres
	local turninCounts = {}
	for itemID, qtyPerTurnin in pairs(qInfo.items) do
		local countIncludingBank = FFF_GetItemCount(itemID, true);
		local created = itemsCreated[itemID] or 0;
		local alreadyCounted = itemsAccountedFor[itemID] or 0;
		local turnins = math.floor((countIncludingBank + created - alreadyCounted) / qtyPerTurnin);
--				print(quest, countIncludingBank, created, alreadyCounted)
		tinsert(turninCounts, turnins);
	end

end

function T:ItemCount(itemID, includeBank)
	if (type(itemID) == "string") then
		-- currency
		local currencyID = strmatch(itemID, "currency:(%d+)")
		currencyID = tonumber(currencyID)
		local count = C_CurrencyInfo.GetCurrencyInfo(currencyID).quantity
		return count
	end
	
	if (FFF_FakeItemCount and FFF_FakeItemCount[itemID]) then
		-- useful for debugging
		return FFF_FakeItemCount[itemID]
	end
	return C_Item.GetItemCount(itemID, includeBank)

end

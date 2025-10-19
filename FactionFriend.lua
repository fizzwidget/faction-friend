------------------------------------------------------
-- Addon loading & shared infrastructure
------------------------------------------------------
local addonName, T = ...
_G[addonName] = T

local DB = _G[addonName.."_DB"]
local L = _G[addonName.."_Locale"].Text

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

------------------------------------------------------
-- Constants
------------------------------------------------------

T.GUILD_FACTION_ID = 1168

-- infinite loop protection for when iterating past GetNumFactions() to find collapsed/hidden
-- 366 known factions on wowhead as of patch 11.1
T.MAX_FACTIONS = 600

------------------------------------------------------
-- Utilities
------------------------------------------------------

function T:PairsByKeys(table, comparator)
	if not comparator then
		-- descending by default seems odd, but it's what we use most in this mod
		comparator = function(a, b) return a > b end
	end
	local keys = {}
	for key in pairs(table) do
		tinsert(keys, key) 
	end
	sort(keys, comparator)
	local i = 0 -- iterator variable
	local iterator = function()
		i = i + 1
		if keys[i] == nil then return nil
		else return keys[i], table[keys[i]]
		end
	end
	return iterator
end

function T:FactionIndexForID(factionID)
	for index = 1, T.MAX_FACTIONS do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if not factionData then break end
		if factionData.factionID == factionID then
			return index
		end
	end
end

local MAX_RECENTS = 8
function T.AddToRecents(factionID)
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

function T:StandingText(factionID, includePoints, factionData, friendshipData)
	if not factionData then
		factionData = C_Reputation.GetFactionDataByID(factionID)
	end
	if not friendshipData then
		friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
	end
		
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	if isFriendship then
		local reactionText = friendshipData.reaction
		
		if includePoints and friendshipData.nextThreshold then -- not maxed
			local current = friendshipData.standing - friendshipData.reactionThreshold
			local max = friendshipData.nextThreshold - friendshipData.reactionThreshold
			reactionText = L.RankWithValues:format(reactionText, current, max)
		end

		-- friendship is always green 
		-- because don't know how many levels above / below
		local color = FACTION_BAR_COLORS[5]
		return reactionText, color
		
	elseif C_Reputation.IsMajorFaction(factionID) then
		local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)		
		local renownText = RENOWN_LEVEL_LABEL:format(majorFactionData.renownLevel)
		
		if includePoints then
			-- no need to check if maxed out because max renown isn't a separate standing?
			local current = majorFactionData.renownReputationEarned
			local max = majorFactionData.renownLevelThreshold
			renownText = L.RankWithValues:format(renownText, current, max)
		end
					
		return renownText, BLUE_FONT_COLOR

	else		
		local standingText = GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player"))
		local color = FACTION_BAR_COLORS[factionData.reaction]
		
		if includePoints then
			local current = factionData.currentStanding - factionData.currentReactionThreshold
			local max = factionData.nextReactionThreshold - factionData.currentReactionThreshold
			
			local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
			if not isCapped then
				standingText = L.RankWithValues:format(standingText, current, max)
			end
		end

		return standingText, color
	end
	
end

function T:FactionAtMaximum(factionID, factionData, friendshipData)
	if not factionData then
		factionData = C_Reputation.GetFactionDataByID(factionID)
	end
	if not friendshipData then
		friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
	end
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
	if isFriendship then
		return friendshipData.nextThreshold == nil
	elseif C_Reputation.IsMajorFaction(factionID) then
		return C_MajorFactions.HasMaximumRenown(factionID)
	elseif factionData.reaction == MAX_REPUTATION_REACTION then
		return true
	end
end

function T:PrecacheItems()
	-- call GetItemInfo ahead of time, so client caches info and can provide links/etc later
	-- anything "created" in DB can appear in reports without player having seen the item
	for _, quests in pairs(DB.TurninsByQuest) do
		for quest, questInfo in pairs(quests) do
			for itemID, _ in pairs(questInfo.creates or {}) do
				-- print("caching", itemID, "for", quest)
				C_Item.GetItemInfo(itemID)
			end
		end
	end
end

------------------------------------------------------
-- Links and tooltips
------------------------------------------------------

EventRegistry:RegisterCallback("SetItemRef", function(ownerID, link)
	local type, addon, subtype, id = strsplit(":", link)
	if type == "addon" and addon == addonName and subtype == "faction" then
		T:ShowReputationPane(tonumber(id), true)
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

function T:ShowFactionToolip(factionID, anchorFrame, anchor, showHyperlinkInstructions)
	
	if anchor then
		GameTooltip:SetOwner(anchorFrame, "ANCHOR_TOPLEFT")
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, anchorFrame)
	end
	
	T.TooltipAddFactionInfo(GameTooltip, factionID)
	
	if showHyperlinkInstructions then
		GameTooltip_AddBlankLineToTooltip(GameTooltip)
		if InCombatLockdown() then
			GameTooltip_AddInstructionLine(GameTooltip, L.NoClickInCombat)
		else
			GameTooltip_AddInstructionLine(GameTooltip, L.ClickForDetails)
		end
	end
	
	GameTooltip:Show()

end

function T.TooltipAddFactionInfo(tooltip, factionID, factionData, friendshipData)
	if not factionData then
		factionData = C_Reputation.GetFactionDataByID(factionID)
	end
	if not friendshipData then
		friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
	end
	local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0

	GameTooltip_SetTitle(tooltip, factionData.name, HIGHLIGHT_FONT_COLOR)
	
	if C_Reputation.IsAccountWideReputation(factionID) then
		GameTooltip_AddColoredLine(tooltip, REPUTATION_TOOLTIP_ACCOUNT_WIDE_LABEL, ACCOUNT_WIDE_FONT_COLOR, false)
	end
		
	if isFriendship then
		local wrapText = true
		tooltip:AddLine(friendshipData.text, nil, nil, nil, wrapText)
	end
	
	local standingText, color = T:StandingText(factionID, true, factionData, friendshipData)
	GameTooltip_AddColoredLine(tooltip, standingText, color)
	
	-- more lines from potential gains report
	T:TooltipAddFactionReport(tooltip, factionID, factionData, friendshipData)

end


------------------------------------------------------
-- Faction list model management
------------------------------------------------------

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

function T:SetCollapsedFactionHeaders(collapsed, expandInactive)
	for index = C_Reputation.GetNumFactions(), 1, -1 do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if collapsed[data.factionID] or data.name == FACTION_INACTIVE and not expandInactive then
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

------------------------------------------------------
-- Clean up completed factions
------------------------------------------------------

function T:FactionsForCleanup()
	local factionIDs = {}
	for index = 1, T.MAX_FACTIONS do
		local data = C_Reputation.GetFactionDataByIndex(index)
		if not data then break end
		if data.canSetInactive and data.factionID ~= T.GUILD_FACTION_ID and T:FactionAtMaximum(data.factionID, data) and C_Reputation.IsFactionActive(index) then
			if T.Settings.CleanUpParagon or not C_Reputation.IsFactionParagon(data.factionID) then
				tinsert(factionIDs, data.factionID)
			end
		end
	end
	return factionIDs
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
		if data.canSetInactive and data.factionID ~= T.GUILD_FACTION_ID and T:FactionAtMaximum(data.factionID, data) then
			if T.Settings.CleanUpParagon or not C_Reputation.IsFactionParagon(data.factionID) then
				-- print("moving", data.name, "to inactive")
				C_Reputation.SetFactionActive(index, false)
			end
		end
	end
	
	-- restore expand/collapse state
	T:SetCollapsedFactionHeaders(collapsed)
end

function T:CleanUpFactionIfCompleted(factionID, factionData, friendshipData)
	-- cleaning up guild causes issues, don't
	if factionData.canSetInactive and factionID ~= T.GUILD_FACTION_ID and T:FactionAtMaximum(factionID, factionData) and (T.Settings.CleanUpParagon or not C_Reputation.IsFactionParagon(factionID)) then
		
		-- remember current expand/collapse state
		-- and expand all so we can see the whole list
		-- faction to clean may be under a collapsed header
		local collapsed = T:GetCollapsedFactionHeaders()
		local includeSubheaders = true
		T:ExpandAllFactionHeaders(includeSubheaders)
		
		-- iterate visible faction list forward 
		-- because we stop when we find the one
		for index = 1, C_Reputation.GetNumFactions() do
			local data = C_Reputation.GetFactionDataByIndex(index)
			if data.factionID == factionID and data.canSetInactive then
				-- print("moving", data.name, "to inactive")
				C_Reputation.SetFactionActive(index, false)
			end
		end
		
		-- restore expand/collapse state
		T:SetCollapsedFactionHeaders(collapsed)
	end
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
-- Watched faction management
------------------------------------------------------

function T:TrySetWatchedFaction(factionID, overrideInactive)
	if not T.Settings.RepGained then return end
	
	local watchedFaction = C_Reputation.GetWatchedFactionData()
	if watchedFaction and watchedFaction.factionID == factionID then
		-- print("no switch: already watching factionID", factionID)
		return
	end
	
	if overrideInactive then
		C_Reputation.SetWatchedFactionByID(factionID)
	else
		
		local index = T:FactionIndexForID(factionID)
		if not index then
			-- print("no switch: index not found for factionID", factionID)
			return
		end
	
		if C_Reputation.IsFactionActive(index) then
			C_Reputation.SetWatchedFactionByID(factionID)
		end
	end
end

function T.SetWatchedFactionByID(factionID)
	T.AddToRecents(factionID)
	T:ReputationStatusBarUpdate()
end

function T.SetWatchedFactionByIndex(index)
	local factionData = C_Reputation.GetFactionDataByIndex(index)
	if factionData then
		T.AddToRecents(factionData.factionID)
	end
	T:ReputationStatusBarUpdate()
end

------------------------------------------------------
-- Reputation watch bar shading / interaction
------------------------------------------------------

function T:SetupWatchBarOverlays()
	T.BarOverlays = {}
	for i, container in pairs(StatusTrackingBarManager.barContainers) do
		local barFrame = container.bars[1]
	
		local overlay = CreateFrame("Button", "FFF_BarOverlay"..i, barFrame)
		overlay:SetAllPoints()
		overlay:RegisterForClicks("RightButtonUp")
		overlay:EnableMouseMotion(false)
		overlay:SetScript("OnClick", T.ShowFactionMenu)
		T.BarOverlays[i] = overlay
		
		barFrame:HookScript("OnEnter", function(frame)
			if frame.factionID and not C_Reputation.IsFactionParagon(frame.factionID) then
				T:ShowFactionToolip(frame.factionID, frame)
			end
		end)
		barFrame:HookScript("OnLeave", GameTooltip_Hide)
	
		local bar = overlay.potentialBar
		if not bar then
			bar = CreateFrame("StatusBar", nil, overlay)
			bar:SetAllPoints()
			bar:SetFrameLevel(0)
			bar:EnableMouse(false)
			bar:EnableMouseMotion(false)
			overlay.potentialBar = bar
			
			if not T.Settings.ShowPotential then
				bar:Hide()
			end
		end
		hooksecurefunc(barFrame, "Update", T.ReputationStatusBarUpdate)
	end

end

function T.ReputationStatusBarUpdate()
	if not T.Settings.ShowPotential then
		for _, overlay in pairs(T.BarOverlays) do
			overlay.potentialBar:Hide()
		end
		return 
	end

	local factionData = C_Reputation.GetWatchedFactionData()
	if not factionData or factionData.factionID == 0 then
		return nil
	end
	
	local factionID = factionData.factionID
	local potential = T:FactionPotential(factionID, false, factionData)
	for _, overlay in pairs(T.BarOverlays) do
		local bar = overlay.potentialBar
		if potential > 0 then
			bar:Show()
			local baseBar = overlay:GetParent().StatusBar
			local asset = baseBar:GetStatusBarTexture():GetAtlas()
			if asset then
				bar:SetStatusBarTexture(asset)
			end
			bar:SetStatusBarColor(0.5, 0.5, 0.5, 1)
			bar:SetMinMaxValues(baseBar:GetMinMaxValues())
			bar:SetValue(baseBar:GetValue() + potential)
		else
			bar:Hide()
		end
	end
end

function T.ReputationWatchBarShowParagonTooltip(frame)

	-- hide the "rewards" label 
	local lastFontString = _G["EmbeddedItemTooltipTextLeft"..EmbeddedItemTooltip:NumLines()]
	if lastFontString:GetText() == REWARDS then
		lastFontString:SetText("")
	end
	local factionData = C_Reputation.GetFactionDataByID(frame.factionID)
	T:TooltipAddFactionReport(EmbeddedItemTooltip, frame.factionID, factionData, nil, true)

	-- put the "rewards" label below our added text
	GameTooltip_AddBlankLineToTooltip(EmbeddedItemTooltip)
	GameTooltip_AddNormalLine(EmbeddedItemTooltip, REWARDS)

	EmbeddedItemTooltip:Show()
end

function T.ReputationWatchBarPrepareParagonTooltip(frame)
	if not C_Reputation.IsFactionParagon(frame.factionID) then
		-- this hook is only for paragon; other factions don't show their own tooltips
		return
	end
	hooksecurefunc(frame, "UpdateTooltip", T.ReputationWatchBarShowParagonTooltip)
end

hooksecurefunc("ReputationParagonWatchBar_OnEnter", T.ReputationWatchBarPrepareParagonTooltip)

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
		
		hooksecurefunc(C_Reputation, "SetWatchedFactionByID", T.SetWatchedFactionByID)
		hooksecurefunc(C_Reputation, "SetWatchedFactionByIndex", T.SetWatchedFactionByIndex)

		T:SetupWatchBarOverlays()
		T.SettingsUI:Initialize()
		
		T:PrecacheItems()
		
		self:UnregisterEvent("ADDON_LOADED")
	end
end

function Events:BAG_UPDATE(slot)
	if not T.Settings.ShowPotential then return end
	T.ReputationStatusBarUpdate()
end

function Events:UNIT_INVENTORY_CHANGED(unit)
	if unit ~= "player" or not T.Settings.ShowPotential then return end
	T.ReputationStatusBarUpdate()
end

------------------------------------------------------
-- Item tooltip 
------------------------------------------------------

function T:SetupReverseCache()
	if DB.TurninsByItem then return end

	local factions = {}
	for _, factionID in pairs(DB.ID[UnitFactionGroup("player")]) do
		factions[factionID] = 1
	end
	for _, factionID in pairs(DB.ID.Neutral) do
		factions[factionID] = 1
	end
	DB.TurninsByItem = {}	
	for factionID, quests in pairs(DB.TurninsByQuest) do
		if factions[factionID] then
			for quest, questInfo in pairs(quests) do
				if not questInfo.otherFactionRequired then
					for itemID in pairs(questInfo.items) do
						if not DB.TurninsByItem[itemID] then
							DB.TurninsByItem[itemID] = {}
						end
						DB.TurninsByItem[itemID][factionID] = true
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
				
		local factionData = C_Reputation.GetFactionDataByID(factionID)
		local standingText, color = T:StandingText(factionID, false, factionData)
		
		if firstLine then
			GameTooltip_AddBlankLineToTooltip(GameTooltip)
			GameTooltip_AddNormalLine(tooltip, L.TurninForFaction)
			firstLine = false
		end
		GameTooltip_AddColoredDoubleLine(tooltip, factionData.name, standingText, HIGHLIGHT_FONT_COLOR, color)
	end

end

------------------------------------------------------
-- Highlight turnin items 
------------------------------------------------------

function T.UpdateItemButton(frame, itemInfo)
	T:SetupReverseCache()
	
	local color = BLUE_FONT_COLOR
	if itemInfo and DB.TurninsByItem[itemInfo.itemID] then
		frame.IconQuestTexture:SetTexture(TEXTURE_ITEM_QUEST_BANG)
		frame.IconQuestTexture:SetDesaturated(true)		
		frame.IconQuestTexture:SetVertexColor(color:GetRGBA())
		frame.IconQuestTexture:Show()
	else
		frame.IconQuestTexture:SetDesaturated(false)		
		frame.IconQuestTexture:SetVertexColor(1,1,1,1)
		frame.IconQuestTexture:Hide()
	end	
end

function T.ContainerItemButtonUpdateQuestItem(frame, isQuestItem, questID, isActive)
	if not T.Settings.HighlightItems then return end
	
	if questID then 
		-- base UI already highlighted as regular quest item
		return
	end
	local slotID, bagID = frame:GetSlotAndBagID()
	local itemInfo = C_Container.GetContainerItemInfo(bagID, slotID)
	T.UpdateItemButton(frame, itemInfo)
end

hooksecurefunc(ContainerFrameItemButtonMixin, "UpdateQuestItem", T.ContainerItemButtonUpdateQuestItem)

function T.BankPanelItemButtonRefresh(frame)
	if not T.Settings.HighlightItems then return end

	local questItemInfo = frame.questItemInfo
	if questItemInfo.questID then 
		-- base UI already highlighted as regular quest item
		return
	end
	
	local itemInfo = frame.itemInfo
	T.UpdateItemButton(frame, itemInfo)
end
	
hooksecurefunc(BankPanelItemButtonMixin, "Refresh", T.BankPanelItemButtonRefresh)

function T.LootFrameElementInit(frame)
	if not T.Settings.HighlightItems then return end
	
	local slotIndex = frame:GetSlotIndex()
	local texture, item, quantity, currencyID, itemQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(slotIndex)
	if questID then 
		-- base UI already highlighted as regular quest item
		return
	end
	
	local link = GetLootSlotLink(slotIndex)
	local itemInfo
	if link then
		itemInfo = {itemID = GetItemInfoFromHyperlink(link)}
	end
	T.UpdateItemButton(frame, itemInfo)
end
	
hooksecurefunc(LootFrameElementMixin, "Init", T.LootFrameElementInit)

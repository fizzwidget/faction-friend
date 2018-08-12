------------------------------------------------------
-- FactionFriend.lua
------------------------------------------------------
local addonName, addonTable = ...; 

FFF_LastBarSwitchTime = 0;
FFF_LastRepGainTime = 0;
FFF_RecentFactions = {};
FFF_QueuedMessageFrames = {};

FFF_MAX_RECENTS = 10;
FFF_MAX_FACTIONS = 300;	-- infinite loop protection

-- TODO: do something about fancy colors for friendship levels?
FFF_FACTION_BAR_COLORS = {
	[1] = {r = 1, g = 0.1, b = 0.05},	-- Hated
	[2] = {r = 0.8, g = 0.3, b = 0.22},	-- Hostile		}
	[3] = {r = 0.75, g = 0.27, b = 0},	-- Unfriendly	} same as default
	[4] = {r = 0.9, g = 0.7, b = 0},	-- Neutral		}
	[5] = {r = 0, g = 0.6, b = 0.1},	-- Friendly		}
	[6] = {r = 0, g = 0.6, b = 0.4},	-- Honored
	[7] = {r = 0, g = 0.7, b = 0.6},	-- Revered
	[8] = {r = 0, g = 0.7, b = 0.8},	-- Exalted
};

function FFF_HookTooltip(frame)
	if (frame:GetScript("OnTooltipSetItem")) then
		frame:HookScript("OnTooltipSetItem", FFF_OnTooltipSetItem);
	else
		frame:SetScript("OnTooltipSetItem", FFF_OnTooltipSetItem);
	end
end

function FFF_OnTooltipSetItem(self)
	
	local name, link = self:GetItem();
	if (not link) then return; end
	if (FFF_Config.Tooltip and link) then
		local _, _, itemID  = string.find(link, "item:(%d+)");
		itemID = tonumber(itemID);
		
		if (FFF_ReverseCache == nil) then
			FFF_SetupReverseCache();
		end
		
		local itemInfo = FFF_ReverseCache[itemID];
		if (itemInfo) then
			if (type(itemInfo) == "table") then
				FFF_AddTooltipLine(self, FFF_FACTION_TURNIN..":", itemInfo[1]);
				for i = 2, #itemInfo do
					FFF_AddTooltipLine(self, " ", itemInfo[i]);
				end
			else
				FFF_AddTooltipLine(self, FFF_FACTION_TURNIN, itemInfo, 1);
			end
		end
		
		local tabardFactionID = FFF_TabardFactions[itemID];
		if (tabardFactionID) then
			local _, _, standing, min, max, value = GetFactionInfoByID(tabardFactionID);
			if (standing) then
				local displayValue = value - min;
				local displayMax = max - min;
			
				-- fudge the color a bit for better text-in-tooltip readability
				local baseColor = FACTION_BAR_COLORS[standing];
				local color = {};
				for key, value in pairs(baseColor) do 
					color[key] = math.min(1, value * 1.25);
				end
			
				local text = format("%s (%d/%d)", FFF_LabelForStanding(standing), displayValue, displayMax);
				local c = HIGHLIGHT_FONT_COLOR;
				self:AddDoubleLine(REPUTATION..":", text, c.r, c.g, c.b, color.r, color.g, color.b);
			end
		end

	end
	
end

function FFF_AddTooltipLine(tooltip, leftText, factionID, isOnlyLine)
	local factionText, _, standingID = GetFactionInfoByID(factionID);
	if (FFF_Notes[itemID] and FFF_Notes[itemID][faction]) then
		factionText = factionText.." ("..FFF_Notes[itemID][faction]..")";
	end
	if (standingID == nil) then
		-- we don't know about the faction yet
		-- since we don't keep track of starting reputation per faction, we'll just use the Neutral yellow color
		standingID = 4;	
	end
	
	-- fudge the color a bit for better text-in-tooltip readability
	local baseColor = FACTION_BAR_COLORS[standingID];
	local color = {};
	for key, value in pairs(baseColor) do 
		color[key] = math.min(1, value * 1.25);
	end
	
	if (isOnlyLine) then
		tooltip:AddLine(leftText.." "..factionText, color.r, color.g, color.b);
	else
		local c = HIGHLIGHT_FONT_COLOR;
		tooltip:AddDoubleLine(leftText, factionText, c.r, c.g, c.b, color.r, color.g, color.b);
	end
end

function FFF_OnLoad(self)

	hooksecurefunc("ReputationFrame_SetRowType", FFF_ReputationFrame_SetRowType);
	hooksecurefunc("SetWatchedFactionIndex", FFF_SetWatchedFactionIndex);
	hooksecurefunc("CloseDropDownMenus", FFF_HideMenus);
	ReputationFrame:HookScript("OnHide", GameTooltip_Hide);
	
	FFF_HookTooltip(GameTooltip);
	FFF_HookTooltip(ItemRefTooltip);

	FFF_RecentFactions = {};
	
	FFF_FactionNamesByID = {};
	setmetatable(FFF_FactionNamesByID, {__index = function(tbl,key) return (GetFactionInfoByID(key)); end});
	
	FFF_FactionIDsByName = {};
	setmetatable(FFF_FactionIDsByName, {__index = function(tbl,key)
		for _, factionID in pairs(FFF_FactionIDs) do
			if ((FFF_FactionNamesByID[factionID]) == key) then
				return factionID;
			end
		end
	end});
	
	self:RegisterEvent("UPDATE_FACTION");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");
	self:RegisterEvent("PLAYER_CONTROL_GAINED");
	self:RegisterEvent("ZONE_CHANGED");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");

	ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_FACTION_CHANGE", FFF_CombatMessageFactionFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", FFF_SystemMessageFactionFilter)
	
	-- Register Slash Commands
	SLASH_FFF1 = "/factionfriend";
	SLASH_FFF2 = "/ff";
	SlashCmdList["FFF"] = function(msg)
		GFW_FactionFriend:ShowConfig();
	end
		
end

function FFF_OnEvent(self, event, arg1, arg2)
	if ( event == "PLAYER_ENTERING_WORLD" --[[or (event == "ADDON_LOADED" and arg1 == addonName)]]) then
		self:RegisterEvent("BAG_UPDATE");
		self:RegisterEvent("UNIT_INVENTORY_CHANGED");
		
		if (FFF_Config.ReputationColors) then
			FACTION_BAR_COLORS = FFF_FACTION_BAR_COLORS;
		end
		FFF_ReputationWatchBar_Update();
		
		--self:RegisterEvent("QUEST_LOG_UPDATE");
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		--self:UnregisterEvent("QUEST_LOG_UPDATE");
		self:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		self:UnregisterEvent("BAG_UPDATE");
	elseif( event == "PLAYER_CONTROL_GAINED" ) then
		if (FFF_OnTaxi) then
			FFF_OnTaxi = nil;
			FFF_CheckZone();
		end
	elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" ) then
		if (UnitOnTaxi("player")) then
			FFF_OnTaxi = 1;
			return;
		end
		FFF_CheckZone();
--	elseif( event == "QUEST_LOG_UPDATE" ) then
--		FFF_BeginQuestScan();
	elseif ( event == "BAG_UPDATE") then
		FFF_ReputationWatchBar_Update();
	elseif ( event == "UNIT_INVENTORY_CHANGED") then
		if (arg1 == "player") then
			FFF_ReputationWatchBar_Update();
			if (FFF_Config.Tabard) then
				local itemID = GetInventoryItemID("player", GetInventorySlotInfo("TabardSlot"));
				if (itemID ~= FFF_LastTabardID) then
					-- looks like we've changed tabards
					FFF_LastTabardID = itemID;
					local tabardFactionID = FFF_TabardFactions[itemID];
					if (tabardFactionID) then
						-- it's a faction tabard, let's switch
						local watchedFaction, _, _, _, _, watchedFactionID = GetWatchedFactionInfo();
						if (tabardFactionID ~= watchedFactionID) then
							FFF_SetWatchedFaction(tabardFactionID);
							FFF_WatchForTabard = nil;
							return;
						end
					end
				end
			end
		end
	end
end

function FFF_CombatMessageFactionFilter(frame, event, message, ...)

	factionName, amount = FFF_FactionInfoFromMessage(message);
	
	local origFactionName = factionName;
	if (factionName == GUILD_REPUTATION or factionName == GUILD) then
		factionName = GetGuildInfo("player");
		if (factionName == nil) then return false; end	-- not in a guild, so nothing futher to do w/ guild faction
	end

	FFF_AddToRecentFactions(factionName);
	if ((amount > 0) and (GetTime() - FFF_LastRepGainTime > 5) and ((origFactionName ~= GUILD_REPUTATION) or (not FFF_Config.NoGuildAutoswitch)) and ((not FFF_FactionIsBodyguard(factionName)) or (not FFF_Config.NoBodyguardAutoswitch))) then
		if (not FFF_Config.Zones) then
			FFF_SetWatchedFactionConditional(factionName);
		else
			local currentZone = GetRealZoneText();
			local zoneFaction = FFF_ZoneFactions[UnitFactionGroup("player")][currentZone] or FFF_ZoneFactions.Neutral[currentZone];
			if (not zoneFaction or FFF_FactionNamesByID[zoneFaction] == factionName) then
				FFF_SetWatchedFactionConditional(factionName);
			end
		end
	end

	FFF_LastRepGainTime = GetTime();
	local index, _, _, standing, min, max, value = FFF_GetFactionInfoByName(factionName);
	if (FFF_Config.MoveExaltedInactive and standing == 8 and not C_Reputation.IsFactionParagon(factionID)) then
		SetFactionInactive(index);
	end

	if (FFF_Config.CountRepeatGains) then
		if (not standing) then
			-- we don't know about this faction yet
			-- (for a new faction, the gain/loss message often comes before the initial-state message)
			-- queue up the info so we can reprint the message after we get the initial state
			FFF_QueuedMessageFaction = factionName;
			FFF_QueuedMessageOriginal = message;
			FFF_QueuedMessageAmount = amount;
			if (not FFF_QueuedMessageFrames[frame]) then
				FFF_QueuedMessageFrames[frame] = true;
			end
			return true;
		else
			return false, FFF_GetReputationMessage(factionName, message, amount), ...;
		end
	end
	return false;
	
end

function FFF_SystemMessageFactionFilter(frame, event, message, ...)

	-- look for the (e.g.) "You are now Honored with Gadgetzan" message
	if (FFF_FACTION_STANDING_CHANGED == nil) then
		FFF_FACTION_STANDING_CHANGED = GFWUtils.FormatToPattern(FACTION_STANDING_CHANGED);
	end
	local _, _, standingText, factionName = string.find(message, FFF_FACTION_STANDING_CHANGED);
	if (factionName == GUILD_REPUTATION or factionName == GUILD) then
		factionName = GetGuildInfo("player");
	end
	if (FFF_Config.MoveExaltedInactive and (standingText == FACTION_STANDING_LABEL8 or standingText == FACTION_STANDING_LABEL8_FEMALE) and not C_Reputation.IsFactionParagon(factionID)) then
		local index = FFF_GetFactionInfoByName(factionName);
		SetFactionInactive(index);
	end
	if (factionName and factionName == FFF_QueuedMessageFaction) then
		-- we may have previously noted a gain for this faction but were unable to do anything about it
		-- because the gain message came in before we knew the faction existed
		-- now we know the faction exists and can display the queued message
		extraMessage = FFF_GetReputationMessage(FFF_QueuedMessageFaction, FFF_QueuedMessageOriginal, FFF_QueuedMessageAmount);
		for queuedFrame in pairs(FFF_QueuedMessageFrames) do 
			queuedFrame:AddMessage(extraMessage);
		end
		FFF_QueuedMessageFrames = {};
		
		if (FFF_QueuedMessageAmount > 0) then
			if (not FFF_Config.Zones) then
				FFF_SetWatchedFactionConditional(factionName);
			else
				if (not zoneFaction or zoneFaction == factionName) then
					FFF_SetWatchedFactionConditional(factionName);
				end
			end
		end
		FFF_QueuedMessageFaction = nil;
		FFF_QueuedMessageOriginal = nil;
		FFF_QueuedMessageAmount = nil;
	end
	return false;
	
end

function FFF_FactionInfoFromMessage(message)
	-- decreased faction: just add to recents
	if (FFF_FACTION_STANDING_DECREASED == nil) then
		FFF_FACTION_STANDING_DECREASED = GFWUtils.FormatToPattern(FACTION_STANDING_DECREASED);
	end
	local _, _, factionName, amount = string.find(message, FFF_FACTION_STANDING_DECREASED);
	if (factionName) then
		FFF_AddToRecentFactions(factionName);
		return factionName, -amount;
	end
	
	-- four strings to check for increased faction
	if (FFF_FACTION_STANDING_INCREASED_DOUBLE_BONUS == nil) then
		FFF_FACTION_STANDING_INCREASED_DOUBLE_BONUS = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED_DOUBLE_BONUS);
	end
	local _, _, factionName, amount, rafBonus, acctBonus = string.find(message, FFF_FACTION_STANDING_INCREASED_DOUBLE_BONUS);
	if (factionName == nil) then
		if (FFF_FACTION_STANDING_INCREASED_ACH_BONUS == nil) then
			FFF_FACTION_STANDING_INCREASED_ACH_BONUS = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED_ACH_BONUS);
		end
		_, _, factionName, amount, acctBonus = string.find(message, FFF_FACTION_STANDING_INCREASED_ACH_BONUS);
	end
	if (factionName == nil) then
		if (FFF_FACTION_STANDING_INCREASED == nil) then
			FFF_FACTION_STANDING_INCREASED = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED);
		end
		_, _, factionName, amount = string.find(message, FFF_FACTION_STANDING_INCREASED);
	end
	if (factionName == nil) then
		if (FFF_FACTION_STANDING_INCREASED_BONUS == nil) then
			FFF_FACTION_STANDING_INCREASED_BONUS = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED_BONUS);
		end
		_, _, factionName, amount = string.find(message, FFF_FACTION_STANDING_INCREASED_BONUS);
	end
	if (factionName == nil) then
		if (FFF_FACTION_STANDING_INCREASED_GENERIC == nil) then
			FFF_FACTION_STANDING_INCREASED_GENERIC = GFWUtils.FormatToPattern(FACTION_STANDING_INCREASED_GENERIC);
		end
		_, _, factionName = string.find(message, FFF_FACTION_STANDING_INCREASED_GENERIC);
		if (factionName) then
			amount = 1; --A dummy value so something can be returned
		end
	end
	
	return factionName, tonumber(amount);
end

function FFF_GetReputationMessage(factionName, originalMessage, amount)
	local _, _, _, standing, min, max, value, _, _, _, _, _, _, _, factionID = FFF_GetFactionInfoByName(factionName);
	
	-- check if this is a friendship faction 
	local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
	if (friendID ~= nil) then
		if ( nextFriendThreshold ) then
			min, max, value = friendThreshold, nextFriendThreshold, friendRep;
		else
			-- max rank, make it look like a full bar
			min, max, value = 0, 1, 1;
		end
	end
	
	local repeatMessage = "";
	if (tonumber(amount) > 0) then
		-- only show the gains-to-next for gains, not losses
		local nextStanding = standing + 1;
		local repToNext = max - value;
		local gainsToNext = repToNext / amount;

		local nextStandingName, nextColor;
		if (nextStanding < 9) then
			if (friendID ~= nil) then
				-- we don't know the name of the next rank for friendships
				nextStandingName = FFF_NEXT_RANK;
			else
				nextStandingName = FFF_LabelForStanding(nextStanding);
			end
			nextColor = GFWUtils.ColorToCode(FACTION_BAR_COLORS[nextStanding]);
			nextStandingName = nextColor..nextStandingName;
			repeatMessage = " "..format(FFF_REPEAT_TURNINS, gainsToNext, nextStandingName);
		elseif (C_Reputation.IsFactionParagon(factionID)) then
			repeatMessage = " "..PARAGON_REPUTATION_TOOLTIP_TEXT:format(factionName);
			-- TODO calculate repeats till reward
		else -- exalted but not paragon
			nextStandingName = FFF_MAXIMUM;
			nextColor = GFWUtils.ColorToCode(FACTION_BAR_COLORS[8]);
			nextStandingName = nextColor..nextStandingName;
			repeatMessage = " "..format(FFF_REPEAT_TURNINS, gainsToNext, nextStandingName);
		end
	end
	
	return GFWUtils.ColorText(originalMessage..repeatMessage, FACTION_BAR_COLORS[standing]);
end

function FFF_SetupReverseCache()
	FFF_ReverseCache = {};
	FFF_Notes = {};
	for faction, quests in pairs(FFF_ItemInfo) do
		local myExcludedFactions = FFF_ExcludedFactions[UnitFactionGroup("player")];
		if (myExcludedFactions ~= nil and not myExcludedFactions[faction]) then
			for quest, questInfo in pairs(quests) do
				if (not questInfo.otherFactionRequired) then
					for itemID in pairs(questInfo.items) do
						if (FFF_ReverseCache[itemID]) then
							if (type(FFF_ReverseCache[itemID]) == "table") then
								if (GFWTable.KeyOf(FFF_ReverseCache[itemID], faction) == nil) then
									table.insert(FFF_ReverseCache[itemID], faction);
								end
							elseif (FFF_ReverseCache[itemID] ~= faction) then
								local oldValue = FFF_ReverseCache[itemID];
								FFF_ReverseCache[itemID] = {};
								table.insert(FFF_ReverseCache[itemID], oldValue);
								table.insert(FFF_ReverseCache[itemID], faction);
							end
						else
							FFF_ReverseCache[itemID] = faction;
						end
						if (questInfo.note) then
							if (FFF_Notes[itemID] == nil) then
								FFF_Notes[itemID] = {};
							end
							FFF_Notes[itemID][faction] = questInfo.note;
						end
					end
				end
			end
		end
	end
end

function FFF_GetFactionInfoByName(factionName)
	local name;
	local factionIndex = 1;
	local lastFactionName;
	repeat
		lastFactionName = name;
		factionInfo = {GetFactionInfo(factionIndex)};
		name = factionInfo[1];
		if (name == factionName) then
			return factionIndex, unpack(factionInfo, 1, 20);	-- currently known to return 14 values, use 20 to be safe
		end
		factionIndex = factionIndex + 1;
	until (name == lastFactionName or factionIndex > FFF_MAX_FACTIONS); 
	-- check repeats because when we run out of real factions we just get "other" ad infinitum
end

function FFF_MoveExaltedFactionsInactive()
	ExpandAllFactionHeaders();
	-- loop backwards because factions move around when marked inactive
	for index = GetNumFactions(), 1, -1 do
		if (not IsFactionInactive(index)) then
			local name, _, standingID, _, _, _, _, _, isHeader, _, _, _, _, factionID = GetFactionInfo(index);
			if (not isHeader and standingID == 8 and not C_Reputation.IsFactionParagon(factionID)) then
				SetFactionInactive(index);	
			end
		end
	end
end

function FFF_GetFactionIndex(faction)
	if (not faction) then return; end
	local name, factionID;
	local factionIndex = 1;
	repeat
		name, _, _, _, _, _, _, _, _, _, _, _, _, factionID = GetFactionInfo(factionIndex);
		if (name == faction or factionID == faction) then
			return factionIndex;
		end
		factionIndex = factionIndex + 1;
	until (not name or factionIndex > FFF_MAX_FACTIONS);
end

function FFF_CheckZone()
	if (not FFF_Config.Zones) then return; end
	
	local currentZone = GetRealZoneText();
	local zoneFaction = FFF_ZoneFactions[UnitFactionGroup("player")][currentZone] or FFF_ZoneFactions.Neutral[currentZone];
	if (zoneFaction) then
		FFF_SetWatchedFactionConditional(FFF_FactionNamesByID[zoneFaction]);
	end
end

function FFF_SetWatchedFactionIndex(index)
	-- hook so we can update our recent factions list if you set the watched faction thru another UI
	local name = GetFactionInfo(index);
	if (name) then
		FFF_AddToRecentFactions(name);
	end
end

function FFF_SetWatchedFactionConditional(factionName)
	local watchedFaction = GetWatchedFactionInfo();
	if (watchedFaction ~= factionName and GetTime() - FFF_LastBarSwitchTime > 5) then
		FFF_SetWatchedFaction(factionName);
	end
end

function FFF_SetWatchedFaction(faction, overrideInactive)
	local index = FFF_GetFactionIndex(faction);
	if (index and (overrideInactive or not IsFactionInactive(index))) then
		SetWatchedFactionIndex(index);
		FFF_LastBarSwitchTime = GetTime();
	end
end

function FFF_AddToRecentFactions(factionName)
	local newRecentFactions = {factionName};
	for index = 1, #FFF_RecentFactions do
		if (#newRecentFactions >= FFF_MAX_RECENTS) then
			break;
		end
		if (FFF_RecentFactions[index] ~= factionName) then
			table.insert(newRecentFactions, FFF_RecentFactions[index]);
		end
	end
	FFF_RecentFactions = newRecentFactions;
end

function FFF_SanitizeRecentFactions()
	local newRecentFactions = {};
	for index = 1, #FFF_RecentFactions do
		local factionName = FFF_RecentFactions[index]
		local factionIndex, _,_,_,_,_,_,_,_, isHeader, _, hasRep = FFF_GetFactionInfoByName(factionName);
		if (factionIndex and not (isHeader and not hasRep)) then
			table.insert(newRecentFactions, factionName);
		end
	end
	FFF_RecentFactions = newRecentFactions;
	FFF_RecentFactionsChecked = true;
end

FFF_FakeItemCount = {
--	[46114] = 100,
}
function FFF_GetItemCount(itemID, includeBank)
	if (type(itemID) == "string") then
		-- currency
		local _, _, currencyID = string.find(itemID, "currency:(%d+)");
		currencyID = tonumber(currencyID);
		local _, count = GetCurrencyInfo(currencyID);
		return count;
	end
	
	if (FFF_FakeItemCount and FFF_FakeItemCount[itemID]) then
		-- useful for debugging
		return FFF_FakeItemCount[itemID];
	end
	return GetItemCount(itemID, includeBank);
end

function FFF_ItemLink(itemID)
	if (type(itemID) == "string") then
		-- currency
		local _, _, currencyID = string.find(itemID, "currency:(%d+)");
		currencyID = tonumber(currencyID);
		local name, countIncludingBank = GetCurrencyInfo(currencyID);
		return NORMAL_FONT_COLOR_CODE .. name .. FONT_COLOR_CODE_CLOSE;
	end
	
	local _, link = GetItemInfo(itemID);
	if (link) then return link; end
	
	-- if we don't have a link, load our localized name and color it green
	-- (all items we might use this for are uncommon)
	local name = FFF_SpecialItems[itemID];
	if (name) then
		local _, _, _, colorCode = GetItemQualityColor(2);
		return "|c"..colorCode .. name .. FONT_COLOR_CODE_CLOSE;
	end
end

FFF_PointsPerStanding = {
	[1] = 36000,	-- Hated
	[2] = 3000,		-- Hostile
	[3] = 3000,		-- Unfriendly
	[4] = 3000,		-- Neutral
	[5] = 6000,		-- Friendly
	[6] = 12000,	-- Honored
	[7] = 21000,	-- Revered
	[8] = 999,
};
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
};

function FFF_StandingForValue(value)
	value = math.min(value, FFF_AbsMinForStanding[9] - 1);	-- cap at max Exalted
	value = math.max(value, FFF_AbsMinForStanding[1]);	-- and min Hated
	for standingID = 1, 8 do
		if (value >= FFF_AbsMinForStanding[standingID] and value < FFF_AbsMinForStanding[standingID+1]) then
			local pointsInto = value - FFF_AbsMinForStanding[standingID];
			return standingID, pointsInto, FFF_PointsPerStanding[standingID];
		end
	end
end

function FFF_LabelForStanding(standing)
	local standingName;
	if (UnitSex("player") == 3) then
		standingName = _G["FACTION_STANDING_LABEL"..standing.."_FEMALE"];
	end
	if (not standingName) then
		standingName = _G["FACTION_STANDING_LABEL"..standing];
	end
	return standingName;
end

function FFF_GetWatchedFactionPotential(withReport)
	return FFF_GetFactionPotential(nil, withReport);
end

function FFF_FactionIsBodyguard(faction)
	local _, _, _, _, _, _, _, _, _, _, _, _, _, _, factionID = FFF_GetFactionInfoByName(faction);
	for index, value in pairs(FFF_Bodyguards) do
		if (value == factionID) then 
			return true;
		end
	end
	return false;
end

function FFF_GetReputationGainMultiplier()
	FFF_ReputationMultiplier = 1;
	local _, race = UnitRace("player");
	if (race == "Human") then
		FFF_ReputationMultiplier = FFF_ReputationMultiplier + 0.1;
	end
end

function FFF_GetFactionPotential(faction, withReport)
	local _, factionName, standing, min, max, value;
	local factionID, hasBonusRepGain;
	if (faction == nil) then
		factionName, standing, min, max, value, factionID = GetWatchedFactionInfo();
		_, _, _, _, _, _, _, _, _, _, _, _, _, _, hasBonusRepGain = GetFactionInfoByID(factionID);
	elseif (type(faction) == "string") then
		_, factionName, _, standing, min, max, value, _, _, _, _, _, _, _, factionID, hasBonusRepGain = FFF_GetFactionInfoByName(faction);
		if (standing == nil) then return 0; end
	elseif (type(faction) == "number") then
		factionName, _, standing, min, max, value, _, _, _, _, _, _, _, factionID, hasBonusRepGain = GetFactionInfo(faction);
		if (standing == nil) then return 0; end
	else
		error("bad argument #1 to 'FFF_GetFactionPotential' (expected number, string, or nil, got "..type(faction)..")", 2);
	end	
		
	local factionInfo = FFF_ItemInfo[factionID];
	if (factionInfo == nil) then return 0; end
	
	local totalPotential = 0;
	local reportLines;
	if (withReport) then
		reportLines = {};
	end
	
	FFF_GetReputationGainMultiplier();
	local itemsAccountedFor = {};
	local itemsCreated = {};
	for quest, qInfo in GFWTable.PairsByKeys(factionInfo, function(a,b) return a > b end) do
		local meetsRequirements;
		
		meetsRequirements = (standing >= (qInfo.minStanding or 1));
		meetsRequirements = meetsRequirements and (standing <= (qInfo.maxStanding or 8));

		if (meetsRequirements and qInfo.otherFactionRequired) then
			local _, _, standingID = GetFactionInfoByID(qInfo.otherFactionRequired.faction);
			if (standingID) then
				meetsRequirements = meetsRequirements and (standingID >= (qInfo.otherFactionRequired.minStanding or 1));
				meetsRequirements = meetsRequirements and (standingID <= (qInfo.otherFactionRequired.maxStanding or 8));
			end
		end
		
		if (meetsRequirements) then
			local potentialValue = 0;
			
			-- first, figure out how many turnins' worth we have of each item the quest requres
			local turninCounts = {};
			local reportItemLines = {};
			for itemID, qtyPerTurnin in pairs(qInfo.items) do
				local countIncludingBank = FFF_GetItemCount(itemID, true);
				local created = itemsCreated[itemID] or 0;
				local alreadyCounted = itemsAccountedFor[itemID] or 0;
				local turnins = math.floor((countIncludingBank + created - alreadyCounted) / qtyPerTurnin);
--				print(quest, countIncludingBank, created, alreadyCounted)
				table.insert(turninCounts, turnins);
			end
			
			-- if a quest requires multiple item, the number of turnins we can actually make
			-- is decided by whichever item we have the fewest turnins' worth of
			local numTurnins;
			if (table.getn(turninCounts) == 1) then
				numTurnins = turninCounts[1];
			elseif (table.getn(turninCounts) > 1) then
				numTurnins = math.min(unpack(turninCounts));
			else
				numTurnins = 0;
			end
			
			-- Now we can figure how much rep we stand to gain from this quest
			-- and how many turnins we'll do to get there (adjusted for how much we can actually gain)
			-- TODO: option to count gains thru exalted?
			local maxStanding = qInfo.maxStanding or 7;	-- no point going past exalted 
			local maxValue = qInfo.maxValue or FFF_PointsPerStanding[maxStanding];
			-- print(quest,numTurnins,qInfo.value)
			potentialValue, numTurnins = FFF_GetAdjustedPotentialValue(numTurnins, qInfo.value, qInfo, standing, value, hasBonusRepGain);
			if (qInfo.buyValue) then
				-- only track gain from currency purchases if no other turnins available
				-- TODO: option?
				-- TODO: better reporting
				if (totalPotential == 0) then
					-- if this "turnin" buys another item which is also a rep turnin,
					-- adjust the number we'll buy based on how much that turnin gives
					local buyPotentialValue, buyTurnins = FFF_GetAdjustedPotentialValue(numTurnins, qInfo.buyValue, qInfo, standing, value, hasBonusRepGain);
					numTurnins = math.min(numTurnins, buyTurnins);
				else
					numTurnins = 0;
					potentialValue = 0;
				end
			end
			-- print(quest,numTurnins,potentialValue, totalPotential)

			-- some turnins create items which can be used for later "turnins"
			local createdItemLink;
			if (qInfo.creates) then
				for createdID, qtyCreated in pairs(qInfo.creates) do
					if (not createdItemLink) then
						createdItemLink = FFF_ItemLink(createdID);	
						-- hack: grab first one 'cause it's always the only one in our dataset
					end
					itemsCreated[createdID] = (itemsCreated[createdID] or 0) + (qtyCreated * numTurnins);
				end
				if (not createdItemLink) then
					-- have something other than nil if we fail to load link
					createdItemLink = format(FFF_UNKNOWN_ITEM, createdID);
				end
			end

			-- now that we know how many we're actually using of each item for this quest,
			-- account for it so they don't get used again for another quest,
			-- and include it in the report/tooltip
			for itemID, qtyPerTurnin in pairs(qInfo.items) do
				itemsAccountedFor[itemID] = numTurnins * qtyPerTurnin;
				
				local itemLink = FFF_ItemLink(itemID)
				if (not itemLink) then
					-- make sure client caches it
					-- we do this even when not reporting so that it's cached by the time we are
					-- (it's pretty well guaranteed that we'll get called without report first)
					FFF_CacheTooltip:SetHyperlink("item:"..itemID);
					itemLink = string.format(FFF_UNKNOWN_ITEM, itemID);
				end
				if (withReport and numTurnins > 0) then
					local itemsForTurnin = itemsAccountedFor[itemID];
					local lineItem = string.format(FFF_REPORT_LINE_ITEM, itemsForTurnin, itemLink);
					local inBags = FFF_GetItemCount(itemID, false);
					local inBank = FFF_GetItemCount(itemID, true) - inBags;

					local lineItemAdditions = {};
					if (inBank > 0 and inBags < itemsForTurnin) then
						table.insert(lineItemAdditions, string.format(FFF_COUNT_IN_BANK, math.min(inBank, itemsForTurnin)));
					end
					local created = itemsCreated[itemID];
--					print(quest, itemsForTurnin, created)
					if (qInfo.purchased) then
						-- this represents a purchase 
						if (created and inBank == 0 and created == itemsForTurnin) then
							table.insert(lineItemAdditions, FFF_ALL_PURCHASED);
						elseif (created and created > 0 and inBags + inBank < itemsForTurnin) then
							table.insert(lineItemAdditions, string.format(FFF_COUNT_PURCHASED, math.min(created, itemsForTurnin)));
						end
					else
						if (created and inBank == 0 and created == itemsForTurnin) then
							table.insert(lineItemAdditions, FFF_ALL_CREATED);
						elseif (created and created > 0 and inBags + inBank < itemsForTurnin) then
							table.insert(lineItemAdditions, string.format(FFF_COUNT_CREATED, math.min(created, itemsForTurnin)));
						end
					end
					if (#lineItemAdditions > 0) then
						lineItem = lineItem ..GRAY_FONT_COLOR_CODE.. " (".. table.concat(lineItemAdditions, ", ") .. ")" .. FONT_COLOR_CODE_CLOSE;
					end
					table.insert(reportItemLines, lineItem);
				end
			end
			
			-- Finally, throw what we've figured out into the report/tooltip
			if (withReport) then
				local reportLineHeader;
				if (potentialValue > 0) then
					reportLineHeader = string.format(FFF_REPORT_NUM_POINTS, potentialValue);
					if (numTurnins > 1 and not qInfo.useItem) then
						reportLineHeader = reportLineHeader  ..GRAY_FONT_COLOR_CODE..string.format(FFF_REPORT_NUM_TURNINS, numTurnins)..FONT_COLOR_CODE_CLOSE;
					end
					reportLineHeader = reportLineHeader ..":";
					table.insert(reportLines, {[reportLineHeader] = reportItemLines});
				elseif (potentialValue == 0 and numTurnins > 0) then
					-- this represents a purchase
					reportLineHeader = string.format(FFF_REPORT_PURCHASE, numTurnins, createdItemLink);
					reportLineHeader = reportLineHeader ..":";
					table.insert(reportLines, {[reportLineHeader] = reportItemLines});
				end
			end
			
			totalPotential = totalPotential + potentialValue;
		end
	end
	return totalPotential, reportLines, factionName, standing, value, factionID;

end

function FFF_GetAdjustedPotentialValue(numTurnins, turninValue, qInfo, currentStanding, currentValue, hasBonusRepGain)
	local multiplier = FFF_ReputationMultiplier;
	if (hasBonusRepGain) then
		multiplier = multiplier * 2;
	end
	-- figure out how much rep we can gain from what we have for the turnin
	-- but adjust how many turnins to make if it'll max us out
	-- (whether in terms of how far the turnin goes or to max exalted)
	local potentialValue = numTurnins * turninValue * multiplier;
	local potentialStanding = currentStanding;
	local potentialTotal = currentValue + potentialValue;
	if (potentialTotal > FFF_PointsPerStanding[currentStanding]) then
		potentialStanding = FFF_StandingForValue(potentialTotal);
	end
	-- if current standing is below exalted, count only the turnins needed to reach exalted
	-- if current standing is exalted, count turnins needed to max out at 999/1000
	local absMaxStanding = math.max(7, currentStanding);
	local turninMaxStanding = qInfo.maxStanding or absMaxStanding;
	if (turninValue > 0 and potentialStanding >= turninMaxStanding) then
		local maxValue = qInfo.maxValue or FFF_PointsPerStanding[turninMaxStanding];
		local absMaxValue = FFF_AbsMinForStanding[turninMaxStanding] + maxValue;
		if (currentValue >= absMaxValue) then
			potentialValue = 0;
		end
		local maxPotential = math.max(absMaxValue - currentValue, 0);
		potentialValue = math.min(potentialValue, maxPotential);
		-- force numTurnins to integer, recalc potentialValue based on that
		-- because we can't do a fractional number of turnins...
		numTurnins = math.ceil(potentialValue / (turninValue * multiplier));
		if (turninValue == qInfo.buyValue and potentialStanding > turninMaxStanding) then
			-- when calculating how many to buy, count the ones we already own
			-- before adjusting to fit within maximum
			for createdID, qtyCreated in pairs(qInfo.creates) do
				local alreadyOwned = FFF_GetItemCount(createdID);
				numTurnins = numTurnins - alreadyOwned;
				break;	-- there should only be one created item in this case
			end
		end
		potentialValue = numTurnins * turninValue * multiplier;
	end
	return potentialValue, numTurnins;
end

function FFF_GetReputationWatchBar()
	for _, bar in pairs(StatusTrackingBarManager.bars) do
		if bar.priority == 1 then -- this seems really fragile
			return bar
		end
	end
end

function FFF_ReputationWatchBar_Update(newLevel)
	
	local bar = FFF_GetReputationWatchBar()
	if bar == nil then
		return
	end
	local statusBar = bar.StatusBar
		
	if FFF_ReputationExtraFillBar == nil then
		FFF_ReputationExtraFillBar = CreateFrame("StatusBar", "FFF_ReputationExtraFillBar", bar, "FFF_ReputationExtraFillBarTemplate")
		FFF_ReputationExtraFillBar:SetAllPoints()
		FFF_ReputationExtraFillBar:SetFrameLevel(max(statusBar:GetFrameLevel() - 1, 0));
		
		FFF_ReputationTick = CreateFrame("Button", "FFF_ReputationTick", bar, "FFF_ReputationTickTemplate")
		FFF_ReputationTick:SetPoint("CENTER", bar, "CENTER", 0, 0)
		
		-- first time seeing ReputationBar means time to hook it
		bar:HookScript("OnEnter", FFF_ReputationWatchBar_OnEnter)
		bar:HookScript("OnLeave", FFF_ReputationWatchBar_OnLeave)
		bar:HookScript("OnMouseDown", FFF_ReputationWatchBar_OnClick)
	end
	
	
	local name, standing, min, max, value, factionID = GetWatchedFactionInfo();
	if (not name) then return; end
	
	local standingText;
	local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
	if (friendID ~= nil) then
		standingText = friendTextLevel;
		if ( nextFriendThreshold ) then
			min, max, value = friendThreshold, nextFriendThreshold, friendRep;
		else
			-- max rank, make it look like a full bar
			min, max, value = 0, 1, 1;
		end
	elseif (C_Reputation.IsFactionParagon(factionID)) then
		local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID);
		min, max, value = 0, threshold, currentValue;
		standingText = FFF_LabelForStanding(standing);
	else
		standingText = FFF_LabelForStanding(standing);	
	end
	
	bar.OverlayFrame.Text:SetText(name..": "..standingText.." "..value-min.." / "..max-min);
	
	if (name ~= FFF_RecentFactions[1]) then
		FFF_AddToRecentFactions(name);
	end
	
	local potential = FFF_GetWatchedFactionPotential();
	local totalValue = value + potential;
	local tickSet = ((totalValue - min) / (max - min)) * statusBar:GetWidth();
	local tickSet = math.max(tickSet, 0);
	local tickSet = math.min(tickSet, statusBar:GetWidth());
	FFF_ReputationTick:ClearAllPoints();
	if (potential == 0 or not FFF_Config or not FFF_Config.ShowPotential) then
	    FFF_ReputationTick:Hide();
	    FFF_ReputationExtraFillBarTexture:Hide();
	else
		if (totalValue > max) then 
			FFF_ReputationTick:Hide();
		else
		    FFF_ReputationTick:Show();
		end
	    FFF_ReputationTick:SetPoint("CENTER", bar, "LEFT", tickSet, 0);
	    FFF_ReputationExtraFillBarTexture:Show();
	    FFF_ReputationExtraFillBarTexture:SetPoint("TOPRIGHT", bar, "TOPLEFT", tickSet, 0);
	    local color = FACTION_BAR_COLORS[standing];
		FFF_ReputationTickHighlight:SetVertexColor(color.r, color.g, color.b);
		if (totalValue > max) then 
			-- TODO: something better about friendships here?
			local potentialStanding = FFF_StandingForValue(totalValue);
			color = FACTION_BAR_COLORS[potentialStanding];
		    FFF_ReputationExtraFillBarTexture:SetVertexColor(color.r, color.g, color.b, 0.25);
		else
		    FFF_ReputationExtraFillBarTexture:SetVertexColor(color.r, color.g, color.b, 0.15);
		end
	end
end

function FFF_ReputationTick_Tooltip()
	local x,y;
	x,y = FFF_ReputationTick:GetCenter();
	local _, _, _, _, _, factionID = GetWatchedFactionInfo();
	if ( FFF_ReputationTick:IsVisible() ) then
		FFF_ReputationTick:LockHighlight();
		if (C_Reputation.IsFactionParagon(factionID)) then 
			GameTooltip:SetOwner(ReputationParagonTooltip, "ANCHOR_TOPRIGHT");
		elseif ( x >= ( GetScreenWidth() / 2 ) ) then
			GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_RIGHT");
		end
	else
		if (C_Reputation.IsFactionParagon(factionID)) then 
			GameTooltip:SetOwner(ReputationParagonTooltip, "ANCHOR_TOPRIGHT");
		else
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		end
	end
	FFF_FactionReportTooltip();
end

function FFF_FactionReportTooltip(faction)

	local potential, reportLines, factionName, standing, value, factionID = FFF_GetFactionPotential(faction, true);
	if (not standing or not factionName) then return; end
	
	-- no need to show just name if paragon and no report; default UI shows that and more
	if (potential == 0 and C_Reputation.IsFactionParagon(factionID)) then return; end
	
	local potentialText = string.format(FFF_REPUTATION_TICK_TOOLTIP, potential);
	
	-- check if this is a friendship faction
	local standingText;
	local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
	if (friendID ~= nil) then
		value = friendRep;
		local currentRank, maxRank = GetFriendshipReputationRanks(factionID);
		standingText = format("%s (%s %d/%d)", friendTextLevel, RANK, currentRank, maxRank);
	else
		standingText = FFF_LabelForStanding(standing);
	end
	
	-- First line: name of faction and label for current standing
	-- e.g. "The Aldor: Friendly"
	local color = FACTION_BAR_COLORS[standing];
	GameTooltip:SetText(factionName..": "..standingText, color.r, color.g, color.b);

	if (potential == 0) then return; end

	-- Report lines summarizing faction available from turnins
	-- e.g. "500 points (2 turnins): 20x[Mark of Sargeras] (13 in bank)"
	GameTooltip:AddLine(potentialText);
	for _, reportLine in pairs(reportLines) do
		for reportHeader, itemLines in pairs(reportLine) do
			local r, g, b = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			GameTooltip:AddDoubleLine(reportHeader, itemLines[1], r, g, b, r, g, b);
			if (table.getn(itemLines) > 1) then
				for i = 2, table.getn(itemLines) do
					GameTooltip:AddDoubleLine(" ", itemLines[i], r, g, b, r, g, b);
				end
			end
		end
	end
	
	-- Last line (preceded by blank): standing after turnins
	-- e.g. "After turnins: Honored (100/12000)"
	local potentialTotal = potential + value;
	local potentialStanding, pointsInto, localMax = FFF_StandingForValue(potentialTotal);
	GameTooltip:AddLine(" ");
	local summary;
	if (friendID ~= nil) then
		local currentRank, maxRank = GetFriendshipReputationRanks(factionID);
		if (potentialTotal > nextFriendThreshold and currentRank < maxRank) then
			summary = format("%s %d/%d", RANK, currentRank + 1, maxRank);
		else
			pointsInto = potentialTotal - friendThreshold;
			summary = string.format(FFF_AFTER_TURNINS_INFO, friendTextLevel, pointsInto, nextFriendThreshold);
		end
	elseif (C_Reputation.IsFactionParagon(factionID)) then
		local currentValue, threshold = C_Reputation.GetFactionParagonInfo(factionID);
		pointsInto = potential + currentValue;
		summary = string.format(FFF_AFTER_TURNINS_INFO, FFF_LabelForStanding(8), pointsInto, threshold);
	else
		local potentialStandingName = FFF_LabelForStanding(potentialStanding);
		summary = string.format(FFF_AFTER_TURNINS_INFO, potentialStandingName, pointsInto, localMax);
	end
	local c1 = HIGHLIGHT_FONT_COLOR;
	local c2 = FACTION_BAR_COLORS[potentialStanding];
	GameTooltip:AddDoubleLine(FFF_AFTER_TURNINS_LABEL, summary, c1.r, c1.g, c1.b, c2.r, c2.g, c2.b);
	
	GameTooltip:Show();
	
end

function FFF_ReputationWatchBar_OnEnter()
	if (not FFF_Config.ShowPotential) then return; end
	FFF_ReputationTick_Tooltip();
	FFF_ShowingTooltip = true;
end

function FFF_ReputationWatchBar_OnLeave()
	FFF_ReputationTick:UnlockHighlight();
	if (FFF_ShowingTooltip) then
		GameTooltip:Hide();
		FFF_ShowingTooltip = false;
	end
end

function FFF_BuildFactionTree()

	-- first, expand all headers so that we can see the real hierarchy
	-- but remember collapsed state so we can preserve the player's reputation UI
	FFF_CollapsedHeaders = {};
	for factionIndex = 1, GetNumFactions() do
		local name, _, _, _, _, _, _, _, isHeader, isCollapsed = GetFactionInfo(factionIndex);
		if (isHeader and isCollapsed) then
			table.insert(FFF_CollapsedHeaders, name);
			ExpandFactionHeader(factionIndex);
		end
	end
	
	local factionTree = {};
	local numActiveFactions = 0;
	local name, _, standingID, _, _, _, _, _, isHeader, _, hasRep, isWatched, isChild, factionID;
	local factionIndex, treeIndex = 1, 1;
	local currentMainHeader, currentSubHeader, childIndex;
	repeat
		name, _, standingID, barMin, barMax, value, _, _, isHeader, _, hasRep, isWatched, isChild, factionID = GetFactionInfo(factionIndex);
		local standingText;
		local hasPotential = (FFF_GetFactionPotential(factionIndex) > 0);
		
		-- check if this is a friendship faction 
		local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
		if (friendID ~= nil) then
			standingText = friendTextLevel;
			if ( nextFriendThreshold ) then
				barMin, barMax, barValue = friendThreshold, nextFriendThreshold, friendRep;
			else
				-- max rank, make it look like a full bar
				barMin, barMax, barValue = 0, 1, 1;
			end
		else
			standingText = FFF_LabelForStanding(standingID);
		end

		if (isHeader and name == FACTION_INACTIVE) then
			break;
		end
		if (name) then
			numActiveFactions = numActiveFactions + 1;
			if (isHeader and not isChild) then
				-- top level headers
				factionTree[treeIndex] = {name=name, children={}};
				currentMainHeader = factionTree[treeIndex].children;
				treeIndex = treeIndex + 1;
				childIndex = 1;
			elseif (isHeader and isChild and currentMainHeader) then
				-- 2nd level headers
				currentMainHeader[childIndex] = {name=name, children={}, standingID=standingID, standingText=standingText, barMin=barMin, barMax=barMax, value=value, isWatched=isWatched, hasRep=hasRep, hasPotential=hasPotential};
				currentSubHeader = currentMainHeader[childIndex].children;
				childIndex = childIndex + 1;
				grandchildIndex = 1;
			elseif (isChild and currentSubHeader) then
				-- 3rd level items (children of 2nd level headers)
				currentSubHeader[grandchildIndex] = {name=name, standingID=standingID, standingText=standingText, barMin=barMin, barMax=barMax, value=value, isWatched=isWatched, hasPotential=hasPotential};
				grandchildIndex = grandchildIndex + 1;
			elseif (currentMainHeader) then
				-- 2nd level items (children of top level headers)
				currentMainHeader[childIndex] = {name=name, standingID=standingID, standingText=standingText, barMin=barMin, barMax=barMax, value=value, isWatched=isWatched, hasPotential=hasPotential};
				childIndex = childIndex + 1;
			end
		end		
		factionIndex = factionIndex + 1;
	until (not name or factionIndex > FFF_MAX_FACTIONS);
	
	-- TODO: restore collapsed headers

	return factionTree, numActiveFactions;
end

-- for debug only
function FFF_PrintFactionTree()
	local tree = FFF_BuildFactionTree();
	local output = "";
	for _, header in pairs(tree) do
		--print(header.name);
		output = output .. header.name .. "\n";
		for _, item in pairs(header.children) do
			if (item.children) then
				-- it's a subheader
				--print(" ", item.name, item.standingID, item.isWatched, item.hasRep);
				output = output .. " " .. (item.name or "-") .." ".. (item.standingID or "-") .." ".. (item.isWatched or "-") .." ".. (item.hasRep or "-") .. "\n";
				for _, subItem in pairs(item.children) do
					--print(" ", " ", subItem.name,":", subItem.standingID, subItem.isWatched);
					output = output .."  ".. (subItem.name or "-") ..":" .. (subItem.standingID or "-") .." ".. (subItem.isWatched or "-") .. "\n";
				end
			else
				-- it's a faction
				--print(" ", item.name,":", item.standingID, item.isWatched);
				output = output .. " " .. (item.name or "-") ..":" .. (item.standingID or "-") .." ".. (item.isWatched or "-") .. "\n";
			end
		end
	end	
	return output;			
end

------------------------------------------------------
-- reputation frame additions 
------------------------------------------------------

function FFF_ReputationFrame_SetRowType(factionRow, isChild, isHeader, hasRep)
	local factionRowName = factionRow:GetName()

	local factionIcon = _G[factionRowName.."Icon"];
	if (not factionIcon) then
		factionIcon = CreateFrame("Button", factionRowName.."Icon", factionRow, "FFF_FactionButtonTemplate");
		factionIcon:SetPoint("LEFT", factionRow, "RIGHT",2,0);
		factionRow:HookScript("OnEnter", FFF_FactionButtonTooltip);
	end

	factionIcon.index = factionRow.index;

	local potential = FFF_GetFactionPotential(factionRow.index);
	if ( ((hasRep) or (not isHeader)) and (potential > 0) ) then
		factionIcon:Show();
	else
		factionIcon:Hide();
	end
end

function FFF_FactionButtonTooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	FFF_FactionReportTooltip(self.index);
end

------------------------------------------------------
-- quest log reputation scanning (unused)
------------------------------------------------------

--[[
function FFF_OnUpdate(self, elapsed)
	if (FFF_QuestScanIndex) then
		FFF_GetQuestReputation();
	end
end

function FFF_BeginQuestScan()
	FFF_QuestReputation = {};
	FFF_QuestReputationIncomplete = {};

	if (GetNumQuestLogEntries() == 0) then
		return;	-- no quests!
	end
	
	FFF_QuestScanIndex = 0;
	FFF_SavedQuestSelection = GetQuestLogSelection();
	FFF_ScanQuestReputation();
end

function FFF_ScanQuestReputation()
	local numEntries, numQuests = GetNumQuestLogEntries();
	local maxEntries = math.max(numEntries, numEntries + numQuests);
	repeat
		-- not doing for loop to GetNumQuestLogEntries() because
		-- stuff under collapsed headers gets indices higher than that
		FFF_QuestScanIndex = FFF_QuestScanIndex + 1;
		local questTitle, _, _, _, isHeader, _, isComplete = GetQuestLogTitle(FFF_QuestScanIndex);
	until ((questTitle == nil and FFF_QuestScanIndex > maxEntries) or (questTitle and not isHeader));
	if (questTitle == nil and FFF_QuestScanIndex > maxEntries) then
		FFF_FinishQuestScan();
		return;
	end
	SelectQuestLogEntry(FFF_QuestScanIndex);
end

function FFF_GetQuestReputation()
	-- muck with "complete" status the way builtin quest watch UI does
	local questTitle, _, _, _, isHeader, _, isComplete = GetQuestLogTitle(FFF_QuestScanIndex);
	local requiredMoney = GetQuestLogRequiredMoney(FFF_QuestScanIndex);			
	local numObjectives = GetNumQuestLeaderBoards(FFF_QuestScanIndex);
	local playerMoney = GetMoney();
	if ( isComplete and isComplete < 0 ) then
		isComplete = false;	-- failed quest
	elseif ( numObjectives == 0 and playerMoney >= requiredMoney ) then
		isComplete = true;	-- no objectives means "complete" (a la breadcrumb quest)
	end
	
	-- save info for the quest
	local numReputations = GetNumQuestLogRewardFactions();
	print(questTitle)
	--local factionID, amount, factionName, isHeader, hasRep;
	for i = 1, numReputations do		
		local factionID, amount = GetQuestLogRewardFactionInfo(i);
		local factionName, _, _, _, _, _, _, _, isHeader, _, hasRep = GetFactionInfoByID(factionID);
		if ( factionName and ( not isHeader or hasRep ) ) then
			amount = floor(amount / 100);
			print(factionName, amount)
			if (isComplete) then
				if (FFF_QuestReputation[questTitle] == nil) then
					FFF_QuestReputation[questTitle] = {};
				end
				FFF_QuestReputation[questTitle][factionName] = amount;
			else
				if (FFF_QuestReputationIncomplete[questTitle] == nil) then
					FFF_QuestReputationIncomplete[questTitle] = {};
				end
				FFF_QuestReputationIncomplete[questTitle][factionName] = amount;
			end
		end
	end
	
	-- get ready for the next quest (or finish)
	FFF_QuestScanIndex = FFF_QuestScanIndex + 1;
	local nextQuest = GetQuestLogTitle(FFF_QuestScanIndex);
	if (not nextQuest) then
		FFF_FinishQuestScan();
	else
		FFF_ScanQuestReputation();
	end
end

function FFF_FinishQuestScan()
	FFF_QuestScanIndex = nil;
	SelectQuestLogEntry(FFF_SavedQuestSelection);
	
	-- filter out "spillover" reputation past friendly
	--for questTitle, gains in pairs(FFF_QuestReputation) do
	--	local filteredGains = {};
	--	for factionID, amount in pairs(gains) do
	--		filteredGains[factionID] = FFF_RealFactionGainForQuest(factionID, amount, gains);
	--	end
	--	-- save the filtered table
	--	FFF_QuestReputation[questTitle] = filteredGains;
	--end
	--for questTitle, gains in pairs(FFF_QuestReputationIncomplete) do
	--	local filteredGains = {};
	--	for factionID, amount in pairs(gains) do
	--		filteredGains[factionID] = FFF_RealFactionGainForQuest(factionID, amount, gains);
	--	end
	--	-- save the filtered table
	--	FFF_QuestReputationIncomplete[questTitle] = filteredGains;
	--end
end	

function FFF_RealFactionGainForQuest(factionID, amount, allGains)
	--DevTools_Dump({factionID=factionID,amount=amount,allGains=allGains})
	local groupID = FFF_FactionGroups[factionID];
	if (groupID) then
		for _, otherFactionID in pairs(FFF_GroupFactions[groupID]) do
			if (otherFactionID ~= factionID) then
				local otherAmount = allGains[otherFactionID] or 0;
				if (amount < otherAmount) then
					-- this is "spillover" rep, it doesn't apply past friendly
					local _, _, _, standing, barMin, barMax, value = GetFactionInfoByID(factionID);
					if (standing > 5) then
						-- above friendly: no spillover rep
						return 0;
					elseif (standing == 5) then
						-- at friendly: no spillover rep past 5999/6000
						local _, pointsInto, localMax = FFF_StandingForValue(value);
						return math.min(localMax - pointsInto, value);
					end
				end
			end
		end
	end
	return amount;
end
]]
------------------------------------------------------
-- ReputationWatchBar menu 
------------------------------------------------------

FFF_MENU_BORDER_HEIGHT = 15;
FFF_MENU_BUTTON_HEIGHT = 16;
FFF_MENU_BUTTON_MIN_WIDTH = 150;
FFF_MENU_BUTTON_TEXT_PADDING = 32;
FFF_MENU_BUTTON_BANG_WIDTH = 16;
FFF_MENU_BUTTON_CHECK_WIDTH = 25;
FFF_MAX_SIMPLE_MENU_COUNT = 35;

function FFF_ReputationWatchBar_OnClick(self, button)
	if (button == "RightButton" and not (FFF_Config.CombatDisableMenu and InCombatLockdown())) then
		FFF_ShowMenu(1);
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end
end

function FFF_SetupMenuButton(menuFrame, level, index, data, isTitle, func, isHeader)
	local buttonName = "FFF_Menu"..level.."Button"..index;
	local button = _G[buttonName];
	if (not button) then
		button = CreateFrame("Button", buttonName, menuFrame, "FFF_MenuButtonTemplate");
		button:SetID(index);
	end

	-- save attributes for reuse
	local name = data;
	if (type(data) == "table") then
		name = data.name;
		button.factionName = data.name;
		button.standing = data.standingID;
		button.standingText = data.standingText;
		button.watched = data.isWatched;
		button.percent = (data.value - data.barMin) / (data.barMax - data.barMin);
		button.hasPotential = data.hasPotential;
	elseif (name and not (func or isTitle or isHeader)) then
		if (name == GUILD_REPUTATION) then
			name = GetGuildInfo("player");
		end
		local _, _, _, standingID, barMin, barMax, value, _, _, isHeader, _, hasRep, isWatched, isChild, factionID = FFF_GetFactionInfoByName(name);
		
		-- check if this is a friendship faction 
		local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID);
		if (friendID ~= nil) then
			button.standingText = friendTextLevel;
			if ( nextFriendThreshold ) then
				barMin, barMax, barValue = friendThreshold, nextFriendThreshold, friendRep;
			else
				-- max rank, make it look like a full bar
				barMin, barMax, barValue = 0, 1, 1;
			end
		else
			button.standingText = FFF_LabelForStanding(standingID);
		end
		
		if (not value) then return nil, 0; end
		button.factionName = name;
		button.standing = standingID;
		button.watched = isWatched;
		if (barMax - barMin == 0) then
			button.percent = 0;
		else
			button.percent = (value - barMin) / (barMax - barMin);
		end
		button.hasPotential = (FFF_GetFactionPotential(name) > 0);
	elseif (func) then
		button.func = func;
		button.standing = nil;
	end
	
	-- position
	local yPos = -((index - 1) * FFF_MENU_BUTTON_HEIGHT) - FFF_MENU_BORDER_HEIGHT;
	local xPos = FFF_MENU_BORDER_HEIGHT;	-- it's border width too
	button:SetPoint("TOPLEFT", menuFrame, "TOPLEFT", xPos, yPos);
		
	-- name
	button:SetText(name);
	local normalText = _G[buttonName.."NormalText"];
	local width = normalText:GetWidth();
	
	-- other display attributes
	local levelText = _G[buttonName.."Level"];
	levelText:SetText("");
	local check = _G[buttonName.."Check"];
	if (check) then check:Hide(); end
	local arrow = _G[buttonName.."ExpandArrow"];
	if (arrow) then arrow:Hide(); end
	local invisibleButton = _G[buttonName.."InvisibleButton"];
	if (isTitle or not name) then
		normalText:SetPoint("LEFT",0,0);
		button:SetDisabledFontObject(GameFontNormalSmallLeft);
		button:Disable();
		invisibleButton:Show();
		levelText:SetText("");
	else
		button:SetDisabledFontObject(GameFontHighlightSmallLeft);
		button:Enable();
		invisibleButton:Hide();
		if (isHeader and level == 1 and arrow) then
			arrow:Show();
			width = width + FFF_MENU_BUTTON_CHECK_WIDTH;
			button.isParent = 1;
			button.factionName = name;
		else
			button.isParent = nil;
		end
		if (button.standing) then
			normalText:SetPoint("LEFT", FFF_MENU_BUTTON_CHECK_WIDTH, 0);
			if (button.standingText) then
				levelText:SetText(button.standingText);
			else
				levelText:SetText(FFF_LabelForStanding(button.standing));
			end
			local color = FACTION_BAR_COLORS[button.standing];
			levelText:SetTextColor(color.r, color.g, color.b);
			if (button.watched and check) then
				check:Show();
			end
			local bang = _G[buttonName.."Icon"];
			if (button.hasPotential) then
				bang:Show();
			else
				bang:Hide();
			end
			width = width + FFF_MENU_BUTTON_CHECK_WIDTH + levelText:GetWidth() + FFF_MENU_BUTTON_TEXT_PADDING + FFF_MENU_BUTTON_BANG_WIDTH;
		else
			normalText:SetPoint("LEFT",0,0);
		end
	end	
	button:Show();
	
	return button, width;
end

function FFF_MenuButtonSetWidth(buttonName, width)
	local button = _G[buttonName];
	if (not button) then return; end
	button:SetWidth(width);
	
	-- "status bar" highlight
	local color;
	local highlightLeft = _G[buttonName.."HighlightLeft"];
	local highlightRight = _G[buttonName.."HighlightRight"];
	if (button.standing) then
		color = FACTION_BAR_COLORS[button.standing];
		button.percent = min(button.percent, 1);
		button.percent = max(button.percent, 0);
		highlightLeft:SetTexCoord(0, button.percent, 0, 1);
		highlightLeft:SetPoint("RIGHT", (width * button.percent - width), 0);
		
		highlightRight:SetTexCoord(button.percent, 1, 0, 1);
		highlightRight:SetVertexColor(0.5, 0.5, 0.5, 0.5);
		highlightRight:ClearAllPoints();
		highlightRight:SetPoint("LEFT", (width * button.percent), 0);
		highlightRight:SetPoint("RIGHT", 0, 0);
		highlightRight:SetHeight(FFF_MENU_BUTTON_HEIGHT);
	else
		color = NORMAL_FONT_COLOR;
		highlightLeft:SetPoint("RIGHT", 0, 0);
		highlightRight:Hide();
	end
	highlightLeft:SetPoint("LEFT", 0, 0);
	highlightLeft:SetVertexColor(color.r, color.g, color.b, 0.5);
	highlightLeft:SetHeight(FFF_MENU_BUTTON_HEIGHT);
	
end

function FFF_MenuButton_OnClick(self, button, down)
	if (self.func) then
		self.func();
	elseif (self.factionName) then
		FFF_SetWatchedFaction(self.factionName, true);
	end
	FFF_HideMenus();
end

function FFF_MenuButton_OnEnter(self, motion)

	local thisMenuLevel = self:GetParent():GetID();
	if ( self.isParent) then
		local menuFrame = _G["FFF_Menu"..thisMenuLevel + 1];
		if (not menuFrame or menuFrame.parentName ~= self.factionName or not menuFrame:IsShown()) then
			FFF_ShowMenu(thisMenuLevel + 1, self.factionName, self);
		end
	else
		FFF_HideMenus(thisMenuLevel + 1);
	end

	_G[self:GetName().."HighlightLeft"]:Show();
	if (self.standing) then
		_G[self:GetName().."HighlightRight"]:Show();
	end
	
	FFF_Menu_StopCounting(self:GetParent());
end

function FFF_MenuButton_OnLeave(self, motion)
	_G[self:GetName().."HighlightLeft"]:Hide();
	_G[self:GetName().."HighlightRight"]:Hide();
	
	FFF_Menu_StartCounting(self:GetParent());
end

function FFF_HideMenus(startLevel)
	if (not startLevel) then
		startLevel = 1;
	end
	for level = startLevel, FFF_NumMenus do
		local menuFrame = _G["FFF_Menu"..level];
		if (menuFrame) then
			menuFrame:Hide();
		end
	end
end

FFF_NumMenus = 0;
function FFF_ShowMenu(level, parentName, parentFrame)
	local menuFrame = _G["FFF_Menu"..level];
	if (not menuFrame) then
		menuFrame = CreateFrame("Button", "FFF_Menu"..level, UIParent, "FFF_MenuListTemplate");
		menuFrame:SetFrameStrata("FULLSCREEN_DIALOG");	-- hack so we stay above e.g. titanpanel
		menuFrame:SetToplevel(1);
		menuFrame:SetID(level);
		FFF_NumMenus = FFF_NumMenus + 1;
		table.insert(UISpecialFrames, menuFrame:GetName());
	end
	menuFrame:ClearAllPoints();
	
	local maxWidth = 0;
	local numMenuItems = 0;
	menuFrame.parentName = parentName;
	menuFrame.parentMenu = parentFrame and parentFrame:GetParent();

	if (level == 1) then
		-- submenu starters for faction tree
		local count;
		FFF_FactionTree, count = FFF_BuildFactionTree();

		if (count < FFF_MAX_SIMPLE_MENU_COUNT) then
			for _, header in pairs(FFF_FactionTree) do

				-- major faction group header
				numMenuItems = numMenuItems + 1;
				local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, header.name, true);
				maxWidth = math.max(width, maxWidth);

				for _, item in pairs(header.children) do
					if (item.children) then
						-- it's a subheader
						if (#item.children > 0) then
							numMenuItems = numMenuItems + 1;
							local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, item, not item.hasRep);
							local normalText = _G[button:GetName().."NormalText"];
							normalText:SetPoint("LEFT", FFF_MENU_BUTTON_CHECK_WIDTH, 0);
							maxWidth = math.max(width + FFF_MENU_BUTTON_CHECK_WIDTH, maxWidth);
						
							for _, subItem in pairs(item.children) do
								numMenuItems = numMenuItems + 1;
								local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, subItem);
								local normalText = _G[button:GetName().."NormalText"];
								normalText:SetPoint("LEFT", FFF_MENU_BUTTON_CHECK_WIDTH * 2, 0);
								maxWidth = math.max(width + FFF_MENU_BUTTON_CHECK_WIDTH * 2, maxWidth);
							end
						end
					else
						-- it's a faction
						numMenuItems = numMenuItems + 1;
						local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, item);
						maxWidth = math.max(width, maxWidth);
					end
				end

				-- spacer
				numMenuItems = numMenuItems + 1;
				local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems);

			end				
			
		else
			if (not FFF_RecentFactionsChecked) then
				FFF_SanitizeRecentFactions();
			end
			for _, header in pairs(FFF_FactionTree) do
				numMenuItems = numMenuItems + 1;
				local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, header.name, nil, nil, true);
				maxWidth = math.max(width, maxWidth);
			end

			-- spacer
			numMenuItems = numMenuItems + 1;
			local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems);
			
			-- create "Recents" header
			numMenuItems = numMenuItems + 1;
			local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, FFF_RECENT_FACTIONS, true);
			maxWidth = math.max(width, maxWidth);

			-- add recent factions
			for factionIndex = 1, #FFF_RecentFactions do
				numMenuItems = numMenuItems + 1;
				local name = FFF_RecentFactions[ #FFF_RecentFactions - factionIndex + 1 ];
				local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, name);
				maxWidth = math.max(width, maxWidth);
			end

			-- spacer
			numMenuItems = numMenuItems + 1;
			local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems);

		end
		
		-- other menu items
		numMenuItems = numMenuItems + 1;
		local func = function() ToggleCharacter("ReputationFrame"); end;
		local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, FFF_SHOW_REPUTATION_PANE, nil, func);
		maxWidth = math.max(width, maxWidth);
		numMenuItems = numMenuItems + 1;
		func = function() GFW_FactionFriend:ShowConfig(); end;
		local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, FFF_SHOW_OPTIONS, nil, func);
		maxWidth = math.max(width, maxWidth);
		
	else
		-- contents for faction tree based on parentName
		for _, header in pairs(FFF_FactionTree) do
			if (header.name == parentName) then
				for _, item in pairs(header.children) do
					if (item.children) then
						-- it's a subheader
						if (#item.children > 0) then
							numMenuItems = numMenuItems + 1;
							local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, item, not item.hasRep);
							local normalText = _G[button:GetName().."NormalText"];
							normalText:SetPoint("LEFT", FFF_MENU_BUTTON_CHECK_WIDTH, 0);
							maxWidth = math.max(width + FFF_MENU_BUTTON_CHECK_WIDTH, maxWidth);
							
							for _, subItem in pairs(item.children) do
								numMenuItems = numMenuItems + 1;
								local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, subItem);
								local normalText = _G[button:GetName().."NormalText"];
								normalText:SetPoint("LEFT", FFF_MENU_BUTTON_CHECK_WIDTH * 2, 0);
								maxWidth = math.max(width + FFF_MENU_BUTTON_CHECK_WIDTH * 2, maxWidth);
							end
						end
					else
						-- it's a faction
						numMenuItems = numMenuItems + 1;
						local button, width = FFF_SetupMenuButton(menuFrame, level, numMenuItems, item);
						maxWidth = math.max(width, maxWidth);
					end
				end
				break;
			end
		end
	end
		
	-- final sizing
	for menuItemIndex = 1, numMenuItems do
		local buttonName = "FFF_Menu"..level.."Button"..menuItemIndex;
		FFF_MenuButtonSetWidth(buttonName, maxWidth);
	end
	menuWidth = maxWidth + FFF_MENU_BORDER_HEIGHT * 2;
	menuFrame:SetHeight((numMenuItems * FFF_MENU_BUTTON_HEIGHT) + (FFF_MENU_BORDER_HEIGHT * 2));
	menuFrame:SetWidth(menuWidth);
	
	-- hide unused children
	for index = numMenuItems + 1, menuFrame:GetNumChildren() - 1 do
		local buttonName = "FFF_Menu"..level.."Button"..index;
		button = _G[buttonName];
		if (button) then
			button:Hide();
		end
	end
	-- position & show
	local menuHeight = menuFrame:GetHeight();
	if (parentName) then
		-- submenu
		local left, bottom, width, height = parentFrame:GetRect();
		-- parent frame is the menu *button* to which we're attached
		local menuBottom = -FFF_MENU_BORDER_HEIGHT;
		if (bottom - FFF_MENU_BORDER_HEIGHT + menuHeight > GetScreenHeight()) then
			-- adjust bottom so top fits in screen
			menuBottom = GetScreenHeight() - FFF_MENU_BORDER_HEIGHT - menuHeight - bottom;
		end
		if (left + width + menuWidth > GetScreenWidth()) then
			-- move to other side of parent menu so we stay onscreen
			menuFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMLEFT", 0, menuBottom);
		else
			menuFrame:SetPoint("BOTTOMLEFT", parentFrame, "BOTTOMRIGHT", 0, menuBottom);
		end
	else
		-- top-level menu
		local cursorX, cursorY = GetCursorPosition();
		if (cursorX + menuWidth > GetScreenWidth()) then
			-- clamp to screen dimensions
			cursorX = GetScreenWidth() - menuWidth;
		end
		if (cursorY + menuHeight > GetScreenHeight()) then
			-- clamp to screen dimensions
			cursorY = GetScreenHeight() - menuHeight;
		end
		menuFrame:SetPoint("BOTTOMLEFT", cursorX, cursorY);
	end
	menuFrame:Show();
		
end

-- If dropdown is visible then see if its timer has expired, if so hide the frame
function FFF_Menu_OnUpdate(self, elapsed)
	if ( not self.showTimer or not self.isCounting ) then
		return;
	elseif ( self.showTimer < 0 ) then
		self:Hide();
		self.showTimer = nil;
		self.isCounting = nil;
	else
		self.showTimer = self.showTimer - elapsed;
	end
end

-- Start the countdown on a frame
function FFF_Menu_StartCounting(frame)
	if ( frame.parentMenu ) then
		FFF_Menu_StartCounting(frame.parentMenu);
	else
		frame.showTimer = UIDROPDOWNMENU_SHOW_TIME;
		frame.isCounting = 1;
	end
end

-- Stop the countdown on a frame
function FFF_Menu_StopCounting(frame)
	if ( frame.parentMenu ) then
		FFF_Menu_StopCounting(frame.parentMenu);
	else
		frame.isCounting = nil;
	end
end

------------------------------------------------------
-- Ace3 options panel stuff
------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")

-- AceAddon Initialization
GFW_FactionFriend = LibStub("AceAddon-3.0"):NewAddon(addonName)
GFW_FactionFriend.date = gsub("$Date: 2013-03-07 22:32:45 -0800 (Thu, 07 Mar 2013) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

function GFW_FactionFriend:OnProfileChanged(event, database, newProfileKey)
	-- this is called every time our profile changes (after the change)
	FFF_Config = database.profile
end

local function getProfileOption(info)
	return FFF_Config[info.arg]
end

local function setProfileOption(info, value)
	FFF_Config[info.arg] = value
	FFF_ReputationWatchBar_Update();
	if (FFF_Config.MoveExaltedInactive) then
		-- move any already exalted factions when the preference is first enabled
		FFF_MoveExaltedFactionsInactive();
	end
	if (FFF_Config.CountRepeatGains) then
		-- TODO: check whether reputation messages are set to show in chat windows, warn if not
		
	end
	if (info.arg == "ReputationColors") then
		if (value) then
			FACTION_BAR_COLORS = FFF_FACTION_BAR_COLORS;
		else
			-- TODO: prompt for UI reload
		end
	end
end

local titleText = GetAddOnMetadata(addonName, "Title");
local version = GetAddOnMetadata(addonName, "Version");
titleText = titleText .. " " .. version;

function FFF_ColorsOptionTipText()
	local text = ""
	for standing = 1, 8 do
		local colorCode = GFWUtils.ColorToCode(FFF_FACTION_BAR_COLORS[standing]);
		text = text .. colorCode .. _G["FACTION_STANDING_LABEL"..standing] .. FONT_COLOR_CODE_CLOSE;
		if standing < 8 then
			text = text .. " ";
		end
	end
	return text;
end

local options = {
	type = 'group',
	name = titleText,
	args = {
		general = {
			type = 'group',
			cmdInline = true,
			order = -1,
			get = getProfileOption,
			set = setProfileOption,
			name = FFF_OPTIONS_GENERAL,
			args = {
				showPotential = {
					type = 'toggle',
					order = 10,
					width = "double",
					name = FFF_OPTION_SHOW_POTENTIAL,
					desc = FFF_OPTION_SHOW_POTENTIAL_TIP,
					arg = "ShowPotential",
				},
				-- useCurrency = {
				-- 	type = 'toggle',
				-- 	order = 15,
				-- 	width = "double",
				-- 	name = FFF_OPTION_USE_CURRENCY,
				-- 	desc = FFF_OPTION_USE_CURRENCY_TIP,
				-- 	arg = "UseCurrency",
				-- },
				tooltip = {
					type = 'toggle',
					order = 20,
					width = "double",
					name = FFF_OPTION_TOOLTIP,
					arg = "Tooltip",
				},
				countRepeatGains = {
					type = 'toggle',
					order = 30,
					width = "double",
					name = FFF_OPTION_REPEAT_GAINS,
					desc = FFF_OPTION_REPEAT_GAINS_TIP,
					arg = "CountRepeatGains",
				},
				moveExaltedInactive = {
					type = 'toggle',
					order = 40,
					width = "double",
					name = FFF_OPTION_MOVE_EXALTED,
					arg = "MoveExaltedInactive",
				},
				reputationColors = {
					type = 'toggle',
					order = 40,
					width = "double",
					name = FFF_OPTION_REPUTATION_COLORS,
					desc = FFF_ColorsOptionTipText(),
					arg = "ReputationColors",
				},
				switchBar = {
					type = "group",
					name = FFF_OPTIONS_SWITCHBAR,
					order = 50,
					inline = true,
					args = {
						zones = {
							type = 'toggle',
							order = 10,
							width = "double",
							name = FFF_OPTION_ZONES,
							arg = "Zones",
						},
						repGained = {
							type = 'toggle',
							order = 20,
							width = "double",
							name = FFF_OPTION_REP_GAINED,
							arg = "RepGained",
						},
						tabard = {
							type = 'toggle',
							order = 30,
							width = "double",
							name = FFF_OPTION_TABARD,
							arg = "Tabard",
						},
						guild = {
							type = 'toggle',
							order = 40,
							width = "double",
							name = FFF_OPTION_NO_GUILD_AUTOSWITCH,
							arg = "NoGuildAutoswitch",
						},
						bodyguard = {
							type = 'toggle',
							order = 50,
							width = "double",
							name = FFF_OPTION_NO_BODYGUARD_AUTOSWITCH,
							arg = "NoBodyguardAutoswitch",
					}
					},
				},
				combatDisableMenu = {
					type = 'toggle',
					order = 60,
					width = "double",
					name = FFF_OPTION_COMBAT_DISABLE,
					desc = FFF_OPTION_COMBAT_DISABLE_TIP,
					arg = "CombatDisableMenu",
				},
				tips = {
					type = "description",
					name = FFF_OPTIONS_TIPS,
					order = 100,
				},
			},
		},
	},
}
local profileDefault = {
	ShowPotential = true,
	Tooltip = true,
	CountRepeatGains = false,
	MoveExaltedInactive = false,
	ReputationColors = false,
	Zones = false,
	RepGained = true,
	Tabard = true,
	CombatDisableMenu = false,
	NoGuildAutoswitch = false,
	NoBodyguardAutoswitch = true,
}
local defaults = {}
defaults.profile = profileDefault

function GFW_FactionFriend:SetupOptions()
	-- Inject profile options
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profile.order = -2
	
	-- Register options table
	AceConfig:RegisterOptionsTable(addonName, options)
	
	local titleText = GetAddOnMetadata(addonName, "Title");
	titleText = string.gsub(titleText, "Fizzwidget", "GFW");		-- shorter so it fits in the list width

	-- Setup Blizzard option frames
	self.optionsFrames = {}
	-- The ordering here matters, it determines the order in the Blizzard Interface Options
	self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(addonName, titleText, nil, "general")
	self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions(addonName, FFF_OPTIONS_PROFILE, titleText, "profile")
end

function GFW_FactionFriend:OnInitialize()

	-- Create DB
	self.db = AceDB:New("GFW_FactionFriend_DB", defaults, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	
	FFF_Config = self.db.profile

	self:SetupOptions()
	
	--TEMP
	--FFF_NewMenuTest()
	
end

function GFW_FactionFriend:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

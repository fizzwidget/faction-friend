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

------------------------------------------------------
-- Utilities
------------------------------------------------------

-- infinite loop protection; 366 known factions on wowhead as of patch 11.1
FFF_MAX_FACTIONS = 600
T.FactionIndexForID = setmetatable({}, {__index = function(table, key)
	for index = 1, C_Reputation.GetNumFactions() do
		local factionData = C_Reputation.GetFactionDataByIndex(index)
		if factionData and factionData.factionID == key then
			return index
		end
	end
end})

------------------------------------------------------
-- Events
------------------------------------------------------

function Events:ZONE_CHANGED(...)
	T:HandleZoneChange()
end

function Events:ZONE_CHANGED_NEW_AREA(...)
	T:HandleZoneChange()
end

function Events:PLAYER_CONTROL_GAINED(...)
	T:HandleDeferredZoneChange()
end

------------------------------------------------------
-- Switch watched faction by zone
------------------------------------------------------

function T:HandleZoneChange()
	if (UnitOnTaxi("player")) then
		T.PlayerWasOnTaxi = 1
		return
	end

	if (not T.Settings.Zones) then return; end

	local currentZone = GetRealZoneText()
	local zoneFaction = FFF_ZoneFactions[UnitFactionGroup("player")][currentZone] or FFF_ZoneFactions.Neutral[currentZone]
	if (zoneFaction) then
		T:TrySetWatchedFaction(zoneFaction)
	end
end

function T:HandleDeferredZoneChange()
	if (T.PlayerWasOnTaxi) then
		T.PlayerWasOnTaxi = nil
		self:HandleZoneChange()
	end
end

T.LastBarSwitchTime = 0
function T:TrySetWatchedFaction(factionID, overrideInactive)

	local watchedFaction = C_Reputation.GetWatchedFactionData()
	if watchedFaction.factionID == factionID then
		-- print("no switch: already watching factionID", factionID)
		return
	end
	if GetTime() - T.LastBarSwitchTime < 5 then
		-- print("no switch: GetTime() - T.LastBarSwitchTime < 5")
		return
	end
	local index = T.FactionIndexForID[factionID]
	if not index then
		-- print("no switch: index not found for factionID", factionID)
		return
	end
	
	if overrideInactive or C_Reputation.IsFactionActive(index) then
		C_Reputation.SetWatchedFactionByID(factionID)
		T.LastBarSwitchTime = GetTime()
	end
end



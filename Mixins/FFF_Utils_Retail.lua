-----------------------------------------------
-- Retail-Specific Utils
-----------------------------------------------

FFF_Utils_Retail = {}

local u = FFF_Utils_Retail;

function u.noPotential(potential, factionID)
    return potential == 0 and C_Reputation.IsFactionParagon(factionID);
end

function u.isExalted(standing, factionID)
    return standing == 8 and not C_Reputation.IsFactionParagon(factionID);
end

function u.isExaltedLabel(standingText, factionID)
    return (standingText == FACTION_STANDING_LABEL8 or standingText == FACTION_STANDING_LABEL8_FEMALE) and not C_Reputation.IsFactionParagon(factionID);
end

function u.isParagon(factionID)
    return C_Reputation.IsFactionParagon(factionID);
end

function u.getFriendshipReputation(factionID)
    return GetFriendshipReputation(factionID);
end
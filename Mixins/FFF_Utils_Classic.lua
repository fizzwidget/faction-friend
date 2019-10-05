-----------------------------------------------
-- Classic-Specific Utils
-----------------------------------------------

FFF_Utils_Classic = {}

local u = FFF_Utils_Classic;

function u.noPotential(potential)
    return potential == 0;
end

function u.isExalted(standing)
    return standing == 8;
end

function u.isExaltedLabel(standingText)
    return (standingText == FACTION_STANDING_LABEL8 or standingText == FACTION_STANDING_LABEL8_FEMALE);
end

function u.isParagon()
    return nil;
end

function u.getFriendshipReputation()
    return nil;
end
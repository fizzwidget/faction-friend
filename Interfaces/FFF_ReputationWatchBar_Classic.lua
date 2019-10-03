-----------------------------------------------
-- FFF_ReputationWatchBar_Classic.lua
--
-- The Reputation/Exp Bar has been revamped a
-- few times, so we've extracted this out to
-- make it easier to maintain in the long run. 
-----------------------------------------------

FFF_ReputationWatchBar_Classic = {};

function FFF_ReputationWatchBar_Classic:Update(newLevel)

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
    else
        standingText = FFF_LabelForStanding(standing);
    end

    ReputationWatchStatusBarText:SetText(name..": "..standingText.." "..value-min.." / "..max-min);

    if (name ~= FFF_RecentFactions[1]) then
        FFF_AddToRecentFactions(name);
    end

    local potential = FFF_GetWatchedFactionPotential();
    local totalValue = value + potential;
    local tickSet = ((totalValue - min) / (max - min)) * ReputationWatchStatusBar:GetWidth();
    local tickSet = math.max(tickSet, 0);
    local tickSet = math.min(tickSet, ReputationWatchStatusBar:GetWidth());
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
        FFF_ReputationTick:SetPoint("CENTER", "ReputationWatchStatusBar", "LEFT", tickSet, 0);
        FFF_ReputationExtraFillBarTexture:Show();
        FFF_ReputationExtraFillBarTexture:SetPoint("TOPRIGHT", "ReputationWatchStatusBar", "TOPLEFT", tickSet, 0);
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
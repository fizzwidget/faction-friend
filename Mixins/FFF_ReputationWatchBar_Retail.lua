-----------------------------------------------
-- FFF_ReputationWatchBar_Retail.lua
--
-- The Reputation/Exp Bar has been revamped a
-- few times, so we've extracted this out to
-- make it easier to maintain in the long run. 
-----------------------------------------------

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
    elseif (GFW_FactionFriend.Utils.isParagon(factionID)) then
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

local function FFF_GetReputationWatchBar()
    for _, bar in pairs(StatusTrackingBarManager.bars) do
        if bar.priority == 1 then -- this seems really fragile
            return bar
        end
    end
end

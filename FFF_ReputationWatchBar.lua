-- TODO: Provide auto-detection of Classic vs Retail to use the right code
-- local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) should help with that
FFF_ReputationWatchBar = FFF_ReputationWatchBar_Classic;

function FFF_ReputationWatchBar.OnClick(self, button)
    if (button == "RightButton" and not (FFF_Config.CombatDisableMenu and InCombatLockdown())) then
        FFF_ShowMenu(1);
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
    end
end

function FFF_ReputationWatchBar.OnEnter(self)
    if (not FFF_Config.ShowPotential) then return; end
    FFF_ShowingTooltip = FFF_ReputationTick_Tooltip(self);
end

function FFF_ReputationWatchBar.OnLeave()
    FFF_ReputationTick:UnlockHighlight();
    if (FFF_ShowingTooltip ~= nil) then
        tooltip:Hide();
        FFF_ShowingTooltip = nil;
    end
end

function FFF_ReputationTick_Tooltip(self)
    local x,y;
    x,y = FFF_ReputationTick:GetCenter();
    local _, _, _, _, _, factionID = GetWatchedFactionInfo();
    local tooltip = GameTooltip;
    if ( FFF_ReputationTick:IsVisible() ) then
        FFF_ReputationTick:LockHighlight();
        if ( x >= ( GetScreenWidth() / 2 ) ) then
            GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_LEFT");
        else
            GameTooltip:SetOwner(FFF_ReputationTick, "ANCHOR_RIGHT");
        end
    else
        GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
    end
    FFF_FactionReportTooltip(nil, tooltip);
end
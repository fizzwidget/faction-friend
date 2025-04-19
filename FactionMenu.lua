local addonName, T = ...
-- local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Utilities
------------------------------------------------------
function T.ShowFactionMenu(frame)
    MenuUtil.CreateContextMenu(frame, function(owner, root)
        
        local title = root:CreateTitle(T.Title .. " " .. T.Version)
        title:AddInitializer(function(frame, description, menu)
            frame.fontString:SetTextColor(GRAY_FONT_COLOR:GetRGBA())
        end)
        root:CreateSpacer()

        root:CreateTitle(FFF_RECENT_FACTIONS)
        
        for index, factionID in pairs(T.Recents) do
            local factionData = C_Reputation.GetFactionDataByID(factionID)
            root:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
        end
        
        root:CreateDivider()

        local repPaneButton = root:CreateButton(FFF_SHOW_REPUTATION_PANE, T.MenuShowReputationOnClick)
        repPaneButton:SetEnabled(function()
            return not InCombatLockdown() 
        end)
        repPaneButton:SetTooltip(function(tooltip, element) 
            if InCombatLockdown() then
                GameTooltip_SetTitle(tooltip, FFF_TOOLTIP_DONT_CLICK)
            end
        end)
        
        root:CreateButton(FFF_SHOW_OPTIONS, T.MenuShowSettingsOnClick)
    end)
end

function T.MenuFactionButtonIsChecked(factionID)
    local data = C_Reputation.GetWatchedFactionData()
    return data.factionID == factionID
end

function T.MenuFactionButtonSetChecked(factionID)
    C_Reputation.SetWatchedFactionByID(factionID)
    return MenuResponse.Close
end

function T.MenuShowReputationOnClick()
    -- TODO disable in combat 
    ToggleCharacter("ReputationFrame")
end

function T.MenuShowSettingsOnClick()
    Settings.OpenToCategory(T.SettingsCategoryID)
end
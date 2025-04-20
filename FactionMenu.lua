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
            local radio = root:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
            radio:AddInitializer(function(frame, description, menu)
                local fontString2 = frame:AttachFontString()
                fontString2:SetHeight(20)
                fontString2:SetPoint("RIGHT")

                local text, color = T:StandingText(factionID, false, factionData)
                fontString2:SetTextToFit(text)
                fontString2:SetTextColor(color:GetRGBA())
                
                local potential = T:FactionPotential(factionID, true, factionData)
                if potential > 0 then
                    local fontString = frame.fontString
                    local icon = frame:AttachTexture()
                    icon:SetSize(16, 16)
                    icon:SetPoint("LEFT", fontString, "RIGHT")
                    icon:SetTexture("Interface\\GossipFrame\\DailyQuestIcon")
                end
            end)
            radio:SetTooltip(function(tooltip, element) 
                T.TooltipAddFactionInfo(tooltip, factionID, factionData)
            end)

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
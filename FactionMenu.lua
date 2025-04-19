local addonName, T = ...
-- local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Utilities
------------------------------------------------------

function T:StandingText(factionData)
    -- local factionData = C_Reputation.GetFactionDataByID(factionID)
    local factionID = factionData.factionID
    local friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
    local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
        
    -- if C_Reputation.IsAccountWideReputation(factionID) then
    --     -- TODO something in menu for this?
    -- end
        
    if isFriendship then
        local reactionText = friendshipData.reaction
        -- friendship is always green 
        -- because don't know how many levels above / below
        local color = FACTION_BAR_COLORS[5]
        return reactionText, color
        
    elseif C_Reputation.IsMajorFaction(factionID) then
        local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
                
        local renownLevel = RENOWN_LEVEL_LABEL:format(majorFactionData.renownLevel)
                    
        return renownLevel, BLUE_FONT_COLOR

    else		
        local standingText = GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player"))
        local color = FACTION_BAR_COLORS[factionData.reaction]
                
        return standingText, color
    end
    
end

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

                local text, color = T:StandingText(factionData)
                fontString2:SetTextToFit(text)
                fontString2:SetTextColor(color:GetRGBA())
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
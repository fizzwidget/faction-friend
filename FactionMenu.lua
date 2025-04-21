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
        
        -- TODO still switch to short menu if you have few enough (visible) factions?
        local topLevelButton, afterChild
        for index = 1, C_Reputation.GetNumFactions() do
            local factionData = C_Reputation.GetFactionDataByIndex(index)
            
            -- stop at inactive header
            if not factionData or factionData.factionID == 0 then break end
            
            local factionID = factionData.factionID
            if factionData.isHeader and not factionData.isChild then
                if not factionData.isCollapsed then
                    topLevelButton = root:CreateButton(factionData.name)
                end
                afterChild = false
            elseif factionData.isHeader and factionData.isChild then
                if not factionData.isCollapsed then
                    topLevelButton:CreateSpacer()
                end
                if factionData.isHeaderWithRep then
                    local radio = topLevelButton:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
                    radio:AddInitializer(function(frame, description, menu)
                        T.MenuFactionButtonSetup(frame, factionID, factionData)
                    end)
                    radio:SetTooltip(function(tooltip, element) 
                        T.TooltipAddFactionInfo(tooltip, factionID, factionData)
                    end)
                else
                    topLevelButton:CreateTitle(factionData.name)
                end
            else -- not isHeader; could be 2nd level or 3rd level
                if not factionData.isChild and afterChild then
                    -- put (only) one spacer between the end of a 
                    -- subsection and the next peer to its subheader 
                    -- (even if that peer is not itself a subheader)
                    topLevelButton:ClearQueuedDescriptions()
                    topLevelButton:QueueSpacer()
                    afterChild = false
                end
                local radio = topLevelButton:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
                if factionData.isChild then
                    afterChild = true
                end
                
                radio:AddInitializer(function(frame, description, menu)
                    T.MenuFactionButtonSetup(frame, factionID, factionData)
                    local textureWidth = frame.leftTexture1:GetWidth()
                    if factionData.isChild then
                        local indent = frame:AttachTexture()
                        indent:SetSize(16, 16)
                        indent:SetPoint("LEFT")

                        frame.leftTexture1:SetPoint("LEFT", indent, "RIGHT")
                    end
                end)
                radio:SetTooltip(function(tooltip, element) 
                    T.TooltipAddFactionInfo(tooltip, factionID, factionData)
                end)
            end
            
        end
        

        root:CreateDivider()
        root:CreateTitle(FFF_RECENT_FACTIONS)
        
        for index, factionID in pairs(T.Recents) do
            local factionData = C_Reputation.GetFactionDataByID(factionID)
            local radio = root:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
            radio:AddInitializer(function(frame, description, menu)
                T.MenuFactionButtonSetup(frame, factionID, factionData)
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

function T.MenuFactionButtonSetup(frame, factionID, factionData)
    frame.fontString2 = frame:AttachFontString()
    -- frame.fontString2:SetHeight(20)
    frame.fontString2:SetPoint("RIGHT")
    
    -- TODO something for paragon (also show paragon tooltip elsewhere?)
    local text, color = T:StandingText(factionID, false, factionData)
    frame.fontString2:SetTextToFit(text)
    frame.fontString2:SetTextColor(color:GetRGBA())
    
    local potential = T:FactionPotential(factionID, true, factionData)
    if potential > 0 then
        frame.icon = frame:AttachTexture()
        frame.icon:SetSize(16, 16)
        frame.icon:SetPoint("LEFT", frame.fontString, "RIGHT")
        frame.icon:SetTexture("Interface\\GossipFrame\\DailyQuestIcon")
    end
end

function T.MenuFactionButtonIsChecked(factionID)
    local data = C_Reputation.GetWatchedFactionData()
    return data.factionID == factionID
end

function T.MenuFactionButtonSetChecked(factionID)
    C_Reputation.SetWatchedFactionByID(factionID)
    return MenuResponse.CloseAll
end

function T.MenuShowReputationOnClick()
    -- TODO disable in combat 
    ToggleCharacter("ReputationFrame")
end

function T.MenuShowSettingsOnClick()
    Settings.OpenToCategory(T.SettingsCategoryID)
end
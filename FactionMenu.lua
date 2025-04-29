local addonName, T = ...
-- local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Utilities
------------------------------------------------------

local MAX_SHORT_MENU_FACTION_COUNT = 20

function T.ShowFactionMenu(frame)
    MenuUtil.CreateContextMenu(frame, function(owner, root)
                
        T.CreateFactionsMenu(root)
        
        T.CreateRecentsMenu(root)
        
        local repPaneButton = root:CreateButton(FFF_SHOW_REPUTATION_PANE, T.MenuShowReputationOnClick)
        repPaneButton:SetEnabled(function()
            return not InCombatLockdown() 
        end)
        repPaneButton:SetTooltip(function(tooltip, element) 
            if InCombatLockdown() then
                GameTooltip_SetTitle(tooltip, FFF_TOOLTIP_DONT_CLICK)
            end
        end)
        
        local settingsButton = root:CreateButton(FFF_SHOW_OPTIONS, T.MenuShowSettingsOnClick)
        settingsButton:AddInitializer(function(frame, description, menu)
            frame.fontString2 = frame:AttachFontString()
            frame.fontString2:SetPoint("RIGHT")
            frame.fontString2:SetTextColor(GRAY_FONT_COLOR:GetRGBA())
            frame.fontString2:SetTextToFit("v. " .. T.Version)
        end)

    end)
end

function T.ShouldUseShortMenu()
    local visibleCount = 0
    for index = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(index)

        -- stop at inactive header
        if not factionData or factionData.name == FACTION_INACTIVE then break end

        if not factionData.isCollapsed then
            visibleCount = visibleCount + 1
        end
    end
    return visibleCount <= MAX_SHORT_MENU_FACTION_COUNT
end

function T.CreateFactionsMenu(root)
    local shortMenu = T.ShouldUseShortMenu()
    
    local topLevelButton, afterChild, afterHeader, afterFirstHeader
    for index = 1, C_Reputation.GetNumFactions() do
        local factionData = C_Reputation.GetFactionDataByIndex(index)
        
        -- stop at inactive header
        if not factionData or factionData.name == FACTION_INACTIVE then break end
        
        local factionID = factionData.factionID
        if factionData.isHeader and not factionData.isChild then
            if not factionData.isCollapsed then     
                if shortMenu and afterFirstHeader then
                    root:CreateSpacer()
                end           
                if shortMenu then
                    T.CreateShortMenuTopLevelHeader(root, factionData.name)
                    afterFirstHeader = true
                    afterHeader = true
                elseif not factionData.isCollapsed then
                    topLevelButton = root:CreateButton(factionData.name)
                    afterFirstHeader = true
                    afterHeader = true
                end
            end
            afterChild = false
        elseif factionData.isHeader and factionData.isChild then
            local parent = shortMenu and root or topLevelButton
            if not factionData.isCollapsed and not afterHeader then
                parent:CreateSpacer()
            end
            if factionData.isHeaderWithRep then
                local radio = parent:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
                radio:AddInitializer(function(frame, description, menu)
                    T.MenuFactionButtonSetup(frame, factionID, factionData)
                end)
                radio:SetTooltip(function(tooltip, element) 
                    T.TooltipAddFactionInfo(tooltip, factionID, factionData)
                end)
                afterHeader = false
            elseif not factionData.isCollapsed then
                parent:CreateTitle(factionData.name)
                afterHeader = false
            end
        else -- not isHeader; could be 2nd level or 3rd level
            local parent = shortMenu and root or topLevelButton
            if not factionData.isChild and afterChild then
                -- put (only) one spacer between the end of a subsection and the next peer to its subheader 
                -- (even if that peer is not itself a subheader)
                parent:ClearQueuedDescriptions()
                parent:QueueSpacer()
                afterChild = false
            end
            local radio = parent:CreateRadio(factionData.name, T.MenuFactionButtonIsChecked, T.MenuFactionButtonSetChecked, factionID)
            if factionData.isChild then
                afterChild = true
            end
            afterHeader = false

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
    if afterChild or afterHeader or afterFirstHeader then
        -- must have created something, put a divider before next 
        root:QueueDivider()
    end
end

function T.CreateRecentsMenu(root)
    if #T.Recents > 0 then
        root:CreateTitle(FFF_RECENT_FACTIONS)
    end
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
    if #T.Recents > 0 then
        root:QueueDivider()
    end
end

function T.CreateShortMenuTopLevelHeader(root, name)
    local fancyName = strtrim(string.gsub(name, "(.)", "%1 "))
    local header = root:CreateTitle(strupper(fancyName))
    header:AddInitializer(function(frame, description, menu)
        local left = frame:AttachTexture()
        left:SetPoint("LEFT")
        -- left:SetPoint("RIGHT", frame.fontString, "LEFT")
        left:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
        left:SetWidth(13)
        left:SetHeight(13)
        
        frame.fontString:SetTextColor(GRAY_FONT_COLOR:GetRGBA())
        -- frame.fontString:ClearAllPoints()
        frame.fontString:SetPoint("LEFT", left, "RIGHT", 2, 0)
    
        local right = frame:AttachTexture()
        right:SetPoint("LEFT", frame.fontString, "RIGHT", 2, 0)
        right:SetPoint("RIGHT")
        right:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
        right:SetHeight(13)
    end)
end

function T.MenuFactionButtonSetup(frame, factionID, factionData)
    frame.fontString2 = frame:AttachFontString()
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
    -- can't click the menu button that leads to this during combat
    ToggleCharacter("ReputationFrame")
end

function T.MenuShowSettingsOnClick()
    Settings.OpenToCategory(T.SettingsCategoryID)
end
local addonName, T = ...

------------------------------------------------------
-- Expand / Collapse All buttons
------------------------------------------------------

function T:ShowReputationPane(factionID)
    -- TODO: refactor for similarity with popup menu?
    
    -- force all filtering off
    -- (can't know if factionID will be hidden by filters)
    C_Reputation.SetLegacyReputationsShown(true)
    C_Reputation.SetReputationSortType(0)
    
    -- remember collapsed headers
    local collapsed = {}
    for i = 1, MAX_FACTIONS do
        local data = C_Reputation.GetFactionDataByIndex(i)
        if not data then break; end
        if data.isCollapsed then
            collapsed[data.factionID] = true
        end
    end
        
    C_Reputation.ExpandAllFactionHeaders()
    
    -- iterate again to find headers containing factionID
    local headerID, subHeaderID
    for index = 1, C_Reputation.GetNumFactions() do
        local data = C_Reputation.GetFactionDataByIndex(index)
        if data.isHeader and not data.isChild then
            headerID = data.factionID
            subHeaderID = nil
        elseif data.isHeader and data.isChild then
            subHeaderID = data.factionID
        end
        if factionID == data.factionID then
            if factionID == subHeaderID then
                -- found factionID has rep and children
                -- don't override collapse state
                subHeaderID = nil
            end
            break
        end
    end
    
    -- TODO: finding under sub headers doesn't work when header starts collapsed
    
    -- override collapsed state for parents of factionID
    local parentNames = {}
    if subHeaderID then
        tinsert(parentNames, C_Reputation.GetFactionDataByID(subHeaderID).name)
        collapsed[subHeaderID] = nil
    end
    tinsert(parentNames, C_Reputation.GetFactionDataByID(headerID).name)
    collapsed[headerID] = nil
    print(
        C_Reputation.GetFactionDataByID(factionID).name,
        "parents:",
        strjoin(", ", unpack(parentNames))
    )
    
    -- restore collapsed state
    for index = C_Reputation.GetNumFactions(), 1, -1 do
        local data = C_Reputation.GetFactionDataByIndex(index)
        if collapsed[data.factionID] then
            C_Reputation.CollapseFactionHeader(index)
        end
    end
    
    -- select the faction and scroll to it
    C_Reputation.SetSelectedFaction(T.FactionIndexForID[factionID])
    
    -- update rep frame & show it if we can
    if not ReputationFrame:IsVisible() and InCombatLockdown() then
        UIErrorsFrame:AddMessage(ERR_CANT_DO_THAT_RIGHT_NOW, RED_FONT_COLOR:GetRGBA())
        return
    elseif ReputationFrame:IsVisible() then
        ReputationFrame:Update()
    else
        ToggleCharacter("ReputationFrame")
    end
    -- scroll faction to visible
    ReputationFrame.ScrollBox:ScrollToElementDataByPredicate(function(elementData) return elementData.factionID == factionID; end)

end

------------------------------------------------------
-- Expand / Collapse All buttons
------------------------------------------------------

FFF_ExpandCollapseButtonMixin = {}

function FFF_ExpandCollapseButtonMixin:Setup(expand)
    self.expand = expand
    self:GetNormalTexture():SetAtlas(expand and "campaign_headericon_closed" or "campaign_headericon_open", TextureKitConstants.UseAtlasSize)
    self:GetPushedTexture():SetAtlas(expand and "campaign_headericon_closedpressed" or "campaign_headericon_openpressed", TextureKitConstants.UseAtlasSize)
end

function FFF_ExpandCollapseButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip_SetTitle(GameTooltip, self.expand and FFF_EXPAND_ALL or FFF_COLLAPSE_ALL)
    if self.expand then
        GameTooltip_AddInstructionLine(GameTooltip, FFF_EXPAND_SUBHEADERS_HINT:format(GetBindingText("ALT")))
        GameTooltip_AddInstructionLine(GameTooltip, FFF_EXPAND_INACTIVE_HINT:format(GetBindingText("CTRL")))
    else
        GameTooltip_AddInstructionLine(GameTooltip, FFF_COLLAPSE_SUBHEADERS_HINT:format(GetBindingText("ALT")))
    end
    GameTooltip:Show()
end

function FFF_ExpandCollapseButtonMixin:OnClick()
    -- Blizzard bug?
    -- C_Reputation.(Expand|Collapse)AllFactionHeaders don't
    -- workaround by iterating the list and expanding/collapsing each
    if self.expand then
        for index = C_Reputation.GetNumFactions(), 1, -1 do
            local data = C_Reputation.GetFactionDataByIndex(index)
            if data.isHeader and not data.isChild then
                if data.name ~= FACTION_INACTIVE or IsControlKeyDown() then
                    C_Reputation.ExpandFactionHeader(index)
                end
            elseif data.isHeader and data.isChild then
                if IsAltKeyDown() then
                    C_Reputation.ExpandFactionHeader(index)
                end
            end
        end
    else
        for index = C_Reputation.GetNumFactions(), 1, -1 do
            local data = C_Reputation.GetFactionDataByIndex(index)
            if data.isHeader and not data.isChild then
                C_Reputation.CollapseFactionHeader(index)
            elseif data.isHeader and data.isChild then
                if IsAltKeyDown() then
                    C_Reputation.CollapseFactionHeader(index)
                end
            end
        end
    end
end

EventRegistry:RegisterCallback("CharacterFrame.Show", function(...)
    local shouldExpand = true
    T.ExpandAllButton = CreateFrame("Button", nil, ReputationFrame, "FFF_ExpandCollapseButtonTemplate")
    T.ExpandAllButton:Setup(shouldExpand)
    T.ExpandAllButton:SetPoint("RIGHT", ReputationFrame.filterDropdown, "LEFT", -2, 0)
    
    shouldExpand = false
    T.CollapseAllButton = CreateFrame("Button", nil, ReputationFrame, "FFF_ExpandCollapseButtonTemplate")
    T.CollapseAllButton:Setup(shouldExpand)
    T.CollapseAllButton:SetPoint("RIGHT", T.ExpandAllButton, "LEFT")
end)

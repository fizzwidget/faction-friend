local addonName, T = ...

------------------------------------------------------
-- Utilities
------------------------------------------------------

function T:ShowReputationPane(factionID, forceAll)
    
    -- force all filtering off
    -- (can't know if factionID will be hidden by filters)
    if forceAll then
        -- TODO instead of forcing this for links, revert to searching all only after failing to search with current filters
        C_Reputation.SetLegacyReputationsShown(true)
        C_Reputation.SetReputationSortType(0)
    end
    
    -- remember collapsed headers
    local collapsed = T:GetCollapsedFactionHeaders()
        
    -- Blizzard bug: C_Reputation.ExpandAllFactionHeaders doesn't
    T:ExpandAllFactionHeaders()
    
    -- iterate again to find headers containing factionID
    local headerID, subHeaderID
    local isTopLevelHeader
    for index = 1, C_Reputation.GetNumFactions() do
        local data = C_Reputation.GetFactionDataByIndex(index)
        if data.isHeader and not data.isChild then
            headerID = data.factionID
            subHeaderID = nil
        elseif data.isHeader and data.isChild then
            subHeaderID = data.factionID
        end
        if factionID == data.factionID then
            if factionID == headerID then
                -- found factionID has children
                -- don't override collapse state
                headerID = nil
            end
            if factionID == subHeaderID then
                -- found factionID has rep and children
                -- don't override collapse state
                subHeaderID = nil
            end
            isTopLevelHeader = data.isHeader and not data.isChild
            break
        end
    end
        
    -- for debug
    local function name(id)
        return id and C_Reputation.GetFactionDataByID(id).name
    end
    local function names(table)
        local names = {}
        for key in pairs(table) do
            tinsert(names, name(key))
        end
        return names
    end

    -- DevTools_Dump({faction = name(factionID), subHeader = name(subHeaderID), header = name(headerID)})
    
    -- override collapsed state for parents of factionID    
    -- print("before:", strjoin(", ", unpack(names(collapsed))))
    if subHeaderID then
        collapsed[subHeaderID] = nil
    end
    if (headerID) then
        collapsed[headerID] = nil
    end
    -- if trying to select a top-level header, expand it
    if isTopLevelHeader then
        collapsed[factionID] = nil
    end
    -- print("after:", strjoin(", ", unpack(names(collapsed))))

    -- restore collapsed state
    T:SetCollapsedFactionHeaders(collapsed)
    
    -- select the faction
    if not isTopLevelHeader then
        -- top level isn't normally selectable
        C_Reputation.SetSelectedFaction(T.FactionIndexForID[factionID])
    end
    
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
    ReputationFrame.ScrollBox:ScrollToElementDataByPredicate(function(elementData) return elementData.factionID == factionID end)

end

------------------------------------------------------
-- Potential gains indicator
------------------------------------------------------

function T.ReputationEntrySetupPotentialIcon(frame, elementData)
    icon = frame.Content.PotentialIcon
    local potential = T:FactionPotential(elementData.factionID, false, elementData)
    if potential > 0 then
        if not icon then
            icon = frame:CreateTexture()
            icon:SetSize(16, 16)
            icon:SetTexture("Interface\\GossipFrame\\DailyQuestIcon")
            icon:SetPoint("RIGHT", frame.Content.ReputationBar, "LEFT")
        
            frame.Content.PotentialIcon = icon
        end
        icon:Show()
    elseif icon then
        icon:Hide()
    end 
end

hooksecurefunc(ReputationEntryMixin, "Initialize", T.ReputationEntrySetupPotentialIcon)

function T.ReputationEntryShowStandardTooltip(entry)
    T:TooltipAddFactionReport(GameTooltip, entry.elementData.factionID)
    GameTooltip:Show()
end

function T.ReputationEntryShowFriendshipTooltip(frame, factionID)
    T:TooltipAddFactionReport(GameTooltip, factionID)
    GameTooltip:Show()
end

function T.ReputationEntryShowParagonTooltip(entry)
    -- hide the "rewards" label 
    local lastFontString = _G["EmbeddedItemTooltipTextLeft"..EmbeddedItemTooltip:NumLines()]
    if lastFontString:GetText() == REWARDS then
        lastFontString:SetText("")
    end
    
    T:TooltipAddFactionReport(EmbeddedItemTooltip, entry.elementData.factionID, entry.elementData, nil, true)
    
    -- put the "rewards" label below our added text
    GameTooltip_AddBlankLineToTooltip(EmbeddedItemTooltip)
    GameTooltip_AddNormalLine(EmbeddedItemTooltip, REWARDS)

    EmbeddedItemTooltip:Show()
end

-- TODO position added content above instruction line?
hooksecurefunc(ReputationEntryMixin, "ShowMajorFactionRenownTooltip", T.ReputationEntryShowStandardTooltip)
hooksecurefunc(ReputationEntryMixin, "ShowParagonRewardsTooltip", T.ReputationEntryShowParagonTooltip)
hooksecurefunc(ReputationEntryMixin, "ShowFriendshipReputationTooltip", T.ReputationEntryShowFriendshipTooltip)
hooksecurefunc(ReputationEntryMixin, "ShowStandardTooltip", T.ReputationEntryShowStandardTooltip)
hooksecurefunc(ReputationSubHeaderMixin, "ShowStandardTooltip", T.ReputationEntryShowStandardTooltip)
hooksecurefunc(ReputationSubHeaderMixin, "ShowMajorFactionRenownTooltip", T.ReputationEntryShowStandardTooltip)
hooksecurefunc(ReputationSubHeaderMixin, "ShowParagonRewardsTooltip", T.ReputationEntryShowParagonTooltip)

------------------------------------------------------
-- Expand / Collapse All buttons
------------------------------------------------------

FFF_ExpandCollapseButtonMixin = {}
local ExpandCollapse = FFF_ExpandCollapseButtonMixin

function ExpandCollapse:Setup(expand)
    self.expand = expand
    self:GetNormalTexture():SetAtlas(expand and "campaign_headericon_closed" or "campaign_headericon_open", TextureKitConstants.UseAtlasSize)
    self:GetPushedTexture():SetAtlas(expand and "campaign_headericon_closedpressed" or "campaign_headericon_openpressed", TextureKitConstants.UseAtlasSize)
end

function ExpandCollapse:OnEnter()
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

function ExpandCollapse:OnClick()
    -- Blizzard bug?
    -- C_Reputation.(Expand|Collapse)AllFactionHeaders don't
    -- workaround by iterating the list and expanding/collapsing each
    local includeSubheaders = IsAltKeyDown()
    if self.expand then
        local includeInactive = IsControlKeyDown()
        T:ExpandAllFactionHeaders(includeSubheaders, includeInactive)
    else
        T:CollapseAllFactionHeaders(includeSubheaders)
    end
end

------------------------------------------------------
-- Search field
------------------------------------------------------

FFF_SearchBoxMixin = {}
local Search = FFF_SearchBoxMixin

function Search:OnLoad()
    self.HasStickyFocus = function()
        local ancestry = FFF_SearchResultsContainer
        return DoesAncestryIncludeAny(ancestry, GetMouseFoci());
    end
end

function Search:OnEnterPressed()
    local text = self:GetText()
    if strlen(text) < MIN_CHARACTER_SEARCH then return end
    
    local container = FFF_SearchResultsContainer
    local result = container.searchResults[container.selectedIndex]
    if result and result:IsShown() then
        result:Click()
    end
end

function Search:OnTextChanged()
    self:QueueUpdateSearchResults()
end

function Search:OnEditFocusLost()
    FFF_SearchResultsContainer:Hide()
end

function Search:OnEditFocusGained()
    T.UpdateSearchResults()
end

function Search:OnKeyDown(key)
    local container = FFF_SearchResultsContainer
    local newIndex 
    if key == "UP" or key == "TAB" and IsShiftKeyDown() then
        newIndex = max(1, container.selectedIndex - 1)
        self:SelectResult(newIndex)
    elseif key == "DOWN" or key == "TAB" then
        newIndex = min(#container.results, container.selectedIndex + 1)
        self:SelectResult(newIndex)
    end
end

function Search:SelectResult(index)
    local container = FFF_SearchResultsContainer
    container.selectedIndex = index
    for buttonIndex, button in pairs(container.searchResults) do
        if buttonIndex == index then
            button:LockHighlight()
        else
            button:UnlockHighlight()
        end
    end
end

local SEARCH_UPDATE_DELAY = 0.3
Search.QueuedResultsUpdateTimer = nil
function Search:QueueUpdateSearchResults()
    if not self:HasFocus() or strlen(self:GetText()) < MIN_CHARACTER_SEARCH then
        FFF_SearchResultsContainer:Hide()
        FFF_SearchResultsContainer.results = {}
        return
    end
    
    if T.QueuedResultsUpdateTimer then
        T.QueuedResultsUpdateTimer:Cancel()
    end
    T.QueuedResultsUpdateTimer = C_Timer.NewTimer(SEARCH_UPDATE_DELAY, T.UpdateSearchResults)

end

function T:SearchFactionList(searchText)
    local text = strlower(searchText)
    local results = {}
    for index = 1, T.MAX_FACTIONS do
        local factionData = C_Reputation.GetFactionDataByIndex(index)
        if not factionData or factionData.name == FACTION_INACTIVE then break end
        if strmatch(strlower(factionData.name), text) then
            tinsert(results, factionData)
        end
    end
    return results
end

function T.UpdateSearchResults(timer)
    
    local text = T.SearchBox:GetText()
    local container = FFF_SearchResultsContainer
    if strlen(text) < MIN_CHARACTER_SEARCH then 
        container.results = {}
        container:Hide()
        return
    end
    container.results = T:SearchFactionList(text)
    
    local maxWidth = 120
    if #container.results > 0 then
        for index, resultButton in pairs(container.searchResults) do
            if index <= #container.results then
                resultButton:SetData(container.results[index])
                resultButton:Show()
                maxWidth = max(maxWidth, resultButton:GetFontString():GetWidth() + 30)
            else
                resultButton:Hide()
            end
        end
        for _, resultButton in pairs(container.searchResults) do
            resultButton:SetWidth(maxWidth)
        end

        T.SearchBox:SelectResult(1)
        container:SetHeight(#container.results * container.result1:GetHeight() + 22)
        container:SetWidth(maxWidth)
        container:SetPoint("TOPLEFT", T.SearchBox, "BOTTOMLEFT")
        container:SetFrameLevel(T.SearchBox:GetFrameLevel() + 10)
        container:Show()        
    else
        container.selectedIndex = nil
        container:Hide()
    end
end

FFF_SearchResultButtonMixin = {}
local ResultButton = FFF_SearchResultButtonMixin

function ResultButton:SetData(factionData)
    self.data = factionData
    self:SetText(factionData.name)
end

function ResultButton:OnLoad()
    self:GetFontString():SetPoint("LEFT", self, "LEFT", 15, 0)
end

function ResultButton:OnClick()
    if self.data and self.data.factionID then
        T:ShowReputationPane(self.data.factionID)
        FFF_SearchResultsContainer:Hide()
        T.SearchBox:ClearFocus()
        
        -- this isn't a filter, so when we pick a result 
        -- we clear the search state
        FFF_SearchResultsContainer.results = {}
        T.SearchBox:SetText("")
    end
end

------------------------------------------------------
-- Setup
------------------------------------------------------

function T:SetupReputationPane()
    local shouldExpand = true
    T.ExpandAllButton = CreateFrame("Button", nil, ReputationFrame, "FFF_ExpandCollapseButtonTemplate")
    T.ExpandAllButton:Setup(shouldExpand)
    T.ExpandAllButton:SetPoint("RIGHT", ReputationFrame.filterDropdown, "LEFT", -2, 0)
    
    shouldExpand = false
    T.CollapseAllButton = CreateFrame("Button", nil, ReputationFrame, "FFF_ExpandCollapseButtonTemplate")
    T.CollapseAllButton:Setup(shouldExpand)
    T.CollapseAllButton:SetPoint("RIGHT", T.ExpandAllButton, "LEFT")
  
    T.CleanupButton = CreateFrame("Button", nil, ReputationFrame, "BankAutoSortButtonTemplate")
    T.CleanupButton:SetScript("OnEnter", function(frame)
        GameTooltip:SetOwner(frame)
        GameTooltip_SetTitle(GameTooltip, FFF_CLEAN_UP_FACTIONS)
        GameTooltip_AddColoredLine(GameTooltip, FFF_CLEAN_UP_FACTIONS_TIP, GRAY_FONT_COLOR)
        
        -- TODO preprocess cleanup, show moves to be done in tooltip?
        
        GameTooltip:Show()
    end)
    T.CleanupButton:SetScript("OnClick", function()
        T:CleanUpCompletedFactions()
    end)
    T.CleanupButton:SetPoint("BOTTOMLEFT", CharacterFramePortrait, "BOTTOMRIGHT", 0, 0)
    
    T.SearchBox = CreateFrame("EditBox", nil, ReputationFrame, "FFF_SearchBoxTemplate")
    T.SearchBox:SetPoint("RIGHT", T.CollapseAllButton, "LEFT", -2, 0)
    T.SearchBox:SetPoint("LEFT", T.CleanupButton, "RIGHT", 6, 0) 
    
    EventRegistry:UnregisterCallback("CharacterFrame.Show", self);
end

EventRegistry:RegisterCallback("CharacterFrame.Show", T.SetupReputationPane, T)

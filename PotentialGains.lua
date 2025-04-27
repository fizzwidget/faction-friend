local addonName, T = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Utilities
------------------------------------------------------

-- TODO refactor so we share more with major factions
local PointsPerStanding = {
    [1] = 36000,	-- Hated
    [2] = 3000,		-- Hostile
    [3] = 3000,		-- Unfriendly
    [4] = 3000,		-- Neutral
    [5] = 6000,		-- Friendly
    [6] = 12000,	-- Honored
    [7] = 21000,	-- Revered
    [8] = 1, -- Exalted doesn't really have points
}
local AbsMinForStanding = {
    [1] = 0 - PointsPerStanding[3] - PointsPerStanding[2] - PointsPerStanding[1],
    [2] = 0 - PointsPerStanding[3] - PointsPerStanding[2],
    [3] = 0 - PointsPerStanding[3],
    [4] = 0,
    [5] = PointsPerStanding[4],
    [6] = PointsPerStanding[4] + PointsPerStanding[5],
    [7] = PointsPerStanding[4] + PointsPerStanding[5] + PointsPerStanding[6],
    [8] = PointsPerStanding[4] + PointsPerStanding[5] + PointsPerStanding[6] + PointsPerStanding[7],
    [9] = PointsPerStanding[4] + PointsPerStanding[5] + PointsPerStanding[6] + PointsPerStanding[7] + PointsPerStanding[8],
}


function T:StandingForValue(value)
    value = min(value, AbsMinForStanding[9] - 1)	-- cap at max Exalted
    value = max(value, AbsMinForStanding[1])	-- and min Hated
    for standingID = 1, 8 do
        if (value >= AbsMinForStanding[standingID] and value < AbsMinForStanding[standingID+1]) then
            local pointsInto = value - AbsMinForStanding[standingID]
            return standingID, pointsInto, PointsPerStanding[standingID]
        end
    end
end

function T:ItemCount(itemID)
    if FFF_FakeItemCount and FFF_FakeItemCount[itemID] then
        -- useful for debugging
        return FFF_FakeItemCount[itemID], 0, 0, 0
    end
    if itemID == "currency:1166" and not T.Settings.IncludeTimewarped then
        return 0, 0, 0, 0
    end
    if type(itemID) == "string" then
        -- currency
        local currencyID = strmatch(itemID, "currency:(%d+)")
        currencyID = tonumber(currencyID)
        local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        local count = currencyInfo.quantity
        local warbandCount = 0
        if currencyInfo.isAccountTransferable then
            local warbandData = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID)
            for _, characterData in pairs(warbandData or {}) do
                warbandCount = warbandCount + characterData.quantity
            end
        end
        
        return count, 0, 0, warbandCount -- currency is never in bank/reagents
    end
    
    local function CountOnHand()
        local includeUses = false
        local includeBank, includeReagentBank, includeAccountBank = false, false, false
        return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
    end
    local function CountIncludingBank()
        local includeUses = false
        local includeBank, includeReagentBank, includeAccountBank = true, false, false
        return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
    end
    local function CountIncludingReagents()
        local includeUses = false
        local includeBank, includeReagentBank, includeAccountBank = false, true, false
        return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
    end
    local function CountIncludingWarband()
        local includeUses = false
        local includeBank, includeReagentBank, includeAccountBank = false, false, true
        return C_Item.GetItemCount(itemID, includeBank, includeUses, includeReagentBank, includeAccountBank)
    end

    local onHand = CountOnHand()
    local banked = CountIncludingBank() - onHand
    local reagents = CountIncludingReagents() - onHand
    local warband = CountIncludingWarband() - onHand
    
    return onHand, banked, reagents, warband
end

function T:ItemLink(itemID)
    if (type(itemID) == "string") then
        -- currency
        local currencyID = strmatch(itemID, "currency:(%d+)")
        currencyID = tonumber(currencyID)        
        return C_CurrencyInfo.GetCurrencyLink(currencyID)
    end
    
    local _, link = C_Item.GetItemInfo(itemID)
    return link
    -- if nil, it's already been queued to cache for future calls
    -- but we should have precached any items we know about
end

------------------------------------------------------
-- Tooltip report
------------------------------------------------------

function T:TooltipAddFactionReport(tooltip, factionID, factionData)
    local potential, reportLines, factionData = T:FactionPotential(factionID, true, factionData)
    
    if potential == 0 then return end
    
    -- TODO friendship, paragon, major faction renown
    
    GameTooltip_AddBlankLineToTooltip(tooltip)
    GameTooltip_AddNormalLine(tooltip, FFF_REPUTATION_TICK_TOOLTIP:format(potential))
    
    local currentStandingColor = FACTION_BAR_COLORS[factionData.reaction]
    for _, reportLine in pairs(reportLines) do
        for reportHeader, itemLines in pairs(reportLine) do
            for index, line in pairs(itemLines) do
                GameTooltip_AddColoredDoubleLine(tooltip,
                    index == 1 and reportHeader or "  ",
                    line,
                    HIGHLIGHT_FONT_COLOR,
                    HIGHLIGHT_FONT_COLOR
                )
            end
        end
    end
    
    local potentialTotal = potential + factionData.currentStanding
    local potentialStanding, pointsInto, localMax = T:StandingForValue(potentialTotal)
    local potentialStandingText = GetText("FACTION_STANDING_LABEL"..potentialStanding, UnitSex("player"))
    local potentialStandingColor = FACTION_BAR_COLORS[potentialStanding]
    
    if potentialStanding < MAX_REPUTATION_REACTION then
        potentialStandingText = FFF_STANDING_VALUES:format(potentialStandingText, pointsInto, localMax)
    end

    GameTooltip_AddColoredDoubleLine(tooltip,
        FFF_AFTER_TURNINS_LABEL,
        potentialStandingText,
        HIGHLIGHT_FONT_COLOR,
        potentialStandingColor
    )
end

------------------------------------------------------
-- Debug aids
------------------------------------------------------

-- debug only
function FFF_PrintReport(factionID)
    local potential, reportLines, factionData = T:FactionPotential(factionID, true)
    
    -- TODO friendship, paragon, major faction renown
    
    local standingText = GetText("FACTION_STANDING_LABEL"..factionData.reaction, UnitSex("player"))
    local min = factionData.currentReactionThreshold
    local max = factionData.nextReactionThreshold - min
    local current = factionData.currentStanding - min
    
    print(factionData.name, "-", FFF_STANDING_VALUES:format(standingText, current, max))
    print(FFF_REPUTATION_TICK_TOOLTIP:format(potential))
    
    for _, reportLine in pairs(reportLines) do
        for reportHeader, itemLines in pairs(reportLine) do
            for index, line in pairs(itemLines) do
                print(
                    "  ",
                    index == 1 and reportHeader or "  ",
                    line
                )
            end
        end
    end
    
    local potentialTotal = potential + factionData.currentStanding
    local potentialStanding, pointsInto, localMax = T:StandingForValue(potentialTotal)
    local potentialStandingText = GetText("FACTION_STANDING_LABEL"..potentialStanding, UnitSex("player"))

    print(FFF_AFTER_TURNINS_LABEL, FFF_STANDING_VALUES:format(potentialStandingText, pointsInto, localMax))
end

-- more debug
function FFF_PrintExploitableFactions()
    for index = 1, T.MAX_FACTIONS do
        local factionData = C_Reputation.GetFactionDataByIndex(index)
        if not factionData then break end
        
        local potential = T:FactionPotential(factionData.factionID, false, factionData)
        if potential > 0 then
            print(
                T:FactionLink(factionData.factionID, factionData),
                ":",
                potential
            ) 
        end
    end
end


------------------------------------------------------
-- Potential rep gain calculator
------------------------------------------------------

local PotentialGainsMixin = {
    totalPotential = 0,
    itemsAccounted = {},
    itemsCreated = {}
    -- reportLines: table
    -- factionData: table
}

function T:FactionPotential(factionID, withReport, factionData)
    local calculator = CreateFromMixins(PotentialGainsMixin)
    
    -- why doesn't CreateFromMixins do this?
    wipe(calculator.itemsCreated)
    wipe(calculator.itemsAccounted)

    if withReport then
        calculator.reportLines = {}
    end
    
    return calculator:GetPotential(factionID, factionData)
end

local PG = PotentialGainsMixin

function PG:GetPotential(factionID, factionData)
    local function reactionInRange(reaction, min, max, cap)
        local atOrAboveMin = reaction >= (min or 1)
        local atOrBelowMax = reaction <= (max or cap)
        return atOrAboveMin and atOrBelowMax
    end

    if factionData then
        self.factionData = factionData
    else
        self.factionData = C_Reputation.GetFactionDataByID(factionID)
    end
    local factionQuests = DB.TurninsByQuest[factionID]
    if (factionQuests == nil) then return 0 end
    
    local descending = function(a,b) return a > b end
    for key, info in GFWTable.PairsByKeys(factionQuests, descending) do
        -- is our rep in range for this quest?
        local meetsRequirements = reactionInRange(self.factionData.reaction, info.minStanding, info.maxStanding, MAX_REPUTATION_REACTION)
        
        -- if quest requires another faction too,
        -- is our rep with them in range?
        if meetsRequirements and info.otherFactionRequired then
            local otherFactionData = C_Reputation.GetFactionDataByID(info.otherFactionRequired.faction)
            meetsRequirements = meetsRequirements and reactionInRange(otherFactionData.reaction, info.otherFactionRequired.minStanding, info.otherFactionRequired.maxStanding, MAX_REPUTATION_REACTION)
        end
        
        if meetsRequirements then
            self.totalPotential = self.totalPotential + self:QuestPotential(key, info)
        end
    end

    return self.totalPotential, self.reportLines, self.factionData
end

function PG:QuestPotential(key, info)
    local potentialValue = 0
     
    -- first, figure out how many turnins' worth we have of each item the quest requres
    local turninCounts = {}
    for itemID, qtyPerTurnin in pairs(info.items) do
        local onHand, banked, reagents, warband = T:ItemCount(itemID)
        local totalCount = onHand + banked + reagents + warband
        local created = self.itemsCreated[itemID] or 0
        local alreadyCounted = self.itemsAccounted[itemID] or 0
        local turnins = floor((totalCount + created - alreadyCounted) / qtyPerTurnin)
        -- print(key, "count:", totalCount, "created:", created, "counted:", alreadyCounted, "turnins:", turnins)
        tinsert(turninCounts, turnins)
    end

    -- if a quest requires multiple item, the number of turnins we can actually make
    -- is decided by whichever item we have the fewest turnins' worth of
    -- DevTools_Dump({key=key,turninCounts=turninCounts})
    local numTurnins = 0
    if #turninCounts > 0 then
        numTurnins = min(unpack(turninCounts))
    end

    -- Now we can figure how much rep we stand to gain from this quest
    -- and how many turnins we'll do to get there (adjusted for how much we can actually gain)
    -- TODO handle major faction
    local maxStanding = info.maxStanding or 7	-- no point going past exalted 
    local maxValue = info.maxValue or PointsPerStanding[maxStanding]
    potentialValue, numTurnins = self:AdjustedPotential(numTurnins, info.value, info)
    if info.buyValue then
        -- only track gain from currency purchases if no other turnins available
        -- TODO: option?
        -- TODO: better reporting
        if self.totalPotential == 0 then
            -- if this "turnin" buys another item which is also a rep turnin,
            -- adjust the number we'll buy based on how much that turnin gives
            local buyPotentialValue, buyTurnins = self:AdjustedPotential(numTurnins, info.buyValue, info)
            numTurnins = min(numTurnins, buyTurnins)
        else
            numTurnins = 0
            potentialValue = 0
        end
    end

    -- some turnins create items which can be used for later "turnins"
    local createdItemLink
    if info.creates then
        createdItemLink = self:CountCreatedItems(info.creates, numTurnins)
    end
    
    -- now that we know how many we're actually using of each item for this quest,
    -- account for it so they don't get used again for another quest,
    -- and include it in the report/tooltip
    local reportItemLines = {}
    for itemID, qtyPerTurnin in pairs(info.items) do
        self.itemsAccounted[itemID] = numTurnins * qtyPerTurnin
        
        -- get the link even if not reporting
        -- since that caches it for when next we need it
        local itemLink = T:ItemLink(itemID)

        if numTurnins > 0 and self.reportLines then
            local lineItem = self:ItemTurninReport(itemID, itemLink, info.purchased)
            tinsert(reportItemLines, lineItem)
        end
    end
    
    -- Finally, throw what we've figured out into the report/tooltip
    if self.reportLines then
        local header = self:CompleteFactionReport(potentialValue, numTurnins, info.useItem, createdItemLink)
        if header then 
            tinsert(self.reportLines, {[header] = reportItemLines})
        end
    end
    
    return potentialValue
end

function PG:CountCreatedItems(questCreates, numTurnins)
    local createdItemLink
    for createdID, qtyCreated in pairs(questCreates) do
        if not createdItemLink then
            createdItemLink = T:ItemLink(createdID)
            -- hack: grab first one 'cause it's always the only one in our dataset
        end
        self.itemsCreated[createdID] = (self.itemsCreated[createdID] or 0) + (qtyCreated * numTurnins)
        -- print("created", self.itemsCreated[createdID], "x", createdItemLink, "from", numTurnins, "turnins")
    end
    if not createdItemLink then
        -- have something other than nil if we fail to load link
        createdItemLink = FFF_UNKNOWN_ITEM:format(createdID)
    end
    return createdItemLink
end

function PG:ItemTurninReport(itemID, itemLink, purchased)
    local itemsForTurnin = self.itemsAccounted[itemID]
    local lineItem = FFF_REPORT_LINE_ITEM:format(itemsForTurnin, itemLink)
    -- TODO warband bank
    local inBags, inBank, inReagents, inWarband = T:ItemCount(itemID)
    local totalCount = inBags + inBank + inReagents + inWarband
    
    local lineItemAdditions = {}
    if inBank > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, FFF_COUNT_IN_BANK:format(min(inBank, itemsForTurnin)))
    end
    if inReagents > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, FFF_COUNT_IN_REAGENTS:format(min(inReagents, itemsForTurnin)))
    end
    if inWarband > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, FFF_COUNT_IN_WARBAND:format(min(inWarband, itemsForTurnin)))
    end
    local created = self.itemsCreated[itemID]
    local allText = purchased and FFF_ALL_PURCHASED or FFF_ALL_CREATED
    local countText = purchased and FFF_COUNT_PURCHASED or FFF_COUNT_CREATED
    if created and inBank == 0 and created == itemsForTurnin then
        tinsert(lineItemAdditions, allText)
    elseif created and created > 0 and totalCount < itemsForTurnin then
        tinsert(lineItemAdditions, countText:format(min(created, itemsForTurnin)))
    end

    if #lineItemAdditions > 0 then
        lineItem = lineItem ..GRAY_FONT_COLOR_CODE.. " (".. table.concat(lineItemAdditions, ", ") .. ")" .. FONT_COLOR_CODE_CLOSE
    end
    return lineItem
end

function PG:CompleteFactionReport(potentialValue, numTurnins, useItem, createdItemLink)
    local reportLineHeader
    if potentialValue > 0 then
        reportLineHeader = FFF_REPORT_NUM_POINTS:format(potentialValue)
        if numTurnins > 1 and not useItem then
            reportLineHeader = reportLineHeader  ..GRAY_FONT_COLOR:WrapTextInColorCode(FFF_REPORT_NUM_TURNINS:format(numTurnins))
        end
        return reportLineHeader ..":"
    elseif potentialValue == 0 and numTurnins > 0 then
        -- this represents a purchase
        reportLineHeader = FFF_REPORT_PURCHASE:format(numTurnins, createdItemLink)
        return reportLineHeader ..":"
    end
end

function PG:AdjustedPotential(numTurnins, turninValue, info)
    
    -- these names aren't at all confusing now...
    local currentStanding = self.factionData.reaction
    local currentValue = self.factionData.currentStanding
    
    -- TODO handle friendship, paragon, major faction
    
    -- figure out how much rep we can gain from what we have for the turnin
    -- but adjust how many turnins to make if it'll max us out
    -- (whether in terms of how far the turnin goes or to max exalted)
    local potentialValue = numTurnins * turninValue
    local potentialStanding = currentStanding
    local potentialTotal = currentValue + potentialValue
    if (potentialTotal > PointsPerStanding[currentStanding]) then
        potentialStanding = T:StandingForValue(potentialTotal)
    end

    -- if current standing is below exalted, count only the turnins needed to reach exalted
    local absMaxStanding = max(7, currentStanding)
    local turninMaxStanding = info.maxStanding or absMaxStanding
    if turninValue > 0 and potentialStanding >= turninMaxStanding then
        local maxValue = info.maxValue or PointsPerStanding[turninMaxStanding]
        local absMaxValue = AbsMinForStanding[turninMaxStanding] + maxValue
        if currentValue >= absMaxValue then
            potentialValue = 0
        end
        local maxPotential = max(absMaxValue - currentValue, 0)
        potentialValue = min(potentialValue, maxPotential)
        -- force numTurnins to integer, recalc potentialValue based on that
        -- because we can't do a fractional number of turnins...
        numTurnins = ceil(potentialValue / turninValue)
        if turninValue == info.buyValue and potentialStanding > turninMaxStanding then
            -- when calculating how many to buy, count the ones we already own
            -- before adjusting to fit within maximum
            for createdID, qtyCreated in pairs(info.creates) do
                local inBags, inBank, inReagents, inWarband = T:ItemCount(createdID)
                local alreadyOwned = inBags + inBank + inReagents + inWarband
                numTurnins = numTurnins - alreadyOwned
                break	-- there should only be one created item in this case
            end
        end
        potentialValue = numTurnins * turninValue
    end
    return potentialValue, numTurnins
end

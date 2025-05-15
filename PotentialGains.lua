local addonName, T = ...
local DB = _G[addonName.."_DB"]
local L = _G[addonName.."_Locale"].Text

------------------------------------------------------
-- Utilities
------------------------------------------------------

local PointsPerStanding = {
    [1] = 36000,	-- Hated
    [2] = 3000,		-- Hostile
    [3] = 3000,		-- Unfriendly
    [4] = 3000,		-- Neutral
    [5] = 6000,		-- Friendly
    [6] = 12000,	-- Honored
    [7] = 21000,	-- Revered
    [8] = 0, -- Exalted doesn't really have points
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
}

-- so far this is as safe to assume as the old school reputation numbers
-- but we don't know if it'll always be
local MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL = 2500

function T:StandingForValue(value)
    value = min(value, AbsMinForStanding[8])	-- cap at max Exalted
    value = max(value, AbsMinForStanding[1])	-- and min Hated
    for standingID = 1, 7 do
        if (value >= AbsMinForStanding[standingID] and value < AbsMinForStanding[standingID+1]) then
            local pointsInto = value - AbsMinForStanding[standingID]
            return standingID, pointsInto, PointsPerStanding[standingID]
        end
    end
    return MAX_REPUTATION_REACTION, 0, 0
end

function T:MajorFactionRenownForValue(value, currentRank, potential)
    local absValue = (currentRank - 1) * MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL + value
    local absTotal = absValue + potential
    local level = floor(absTotal / MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL)
    local levelBase = level * MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL
    local pointsInto = absTotal - levelBase
    return level + 1, pointsInto, levelBase
end

-- local terminology: "rank" means
--  - major faction renown level (numeric)
--  - friendship rank/reaction (good friend, best frend)
--  - normal faction reaction (hated, neutral, friendly)
--    - called standing in some places but sometimes that can mean the number of points (e.g. neutral 1234/3000)
function T:GetRankInfo(factionID, factionData, friendshipData)
    if not factionData then
        factionData = C_Reputation.GetFactionDataByID(factionID)
    end
    if not friendshipData then
        friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
    end
    local info = {}
    local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
    if isFriendship then
        info.type = "friendship"
        local repRankInfo = C_GossipInfo.GetFriendshipReputationRanks(factionID)
        info.currentRank = repRankInfo.currentLevel
        info.maxRank = repRankInfo.maxLevel
        info.floorValue = friendshipData.reactionThreshold
        info.currentValue = friendshipData.standing - info.floorValue
        if friendshipData.nextThreshold then
            info.nextRankValue = friendshipData.nextThreshold - info.floorValue
            info.nextRank = min(info.currentRank + 1, info.maxRank)
            info.nextRankName = L.NextRank -- can't get ranks for friendships
        end
        info.capValue = friendshipData.maxRep

    elseif C_Reputation.IsFactionParagon(factionID) then
        -- TODO what happens for paragon + major?
        info.type = "paragon"
        local paragonStanding, paragonThreshold, _, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)
        info.currentRank = 0 -- ?
        info.maxRank = 2 -- ?
        info.floorValue = 0
        info.currentValue = mod(paragonStanding, paragonThreshold)
        if hasRewardPending then
            info.currentValue = info.currentValue + paragonThreshold
        end
        info.nextRankValue = paragonThreshold
        info.nextRank = 1 -- ?
        info.nextRankName = L.ParagonReward
        info.capValue = paragonThreshold * 2 -- ?
        
    elseif C_Reputation.IsMajorFaction(factionID) then
        info.type = "major"
        local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)		
        info.currentRank = majorFactionData.renownLevel
        local renownLevelsInfo = C_MajorFactions.GetRenownLevels(factionID)
        info.maxRank = renownLevelsInfo[#renownLevelsInfo].level
        info.floorValue = 0
        info.currentValue = majorFactionData.renownReputationEarned
        info.nextRankValue = majorFactionData.renownLevelThreshold
        info.nextRank = min(info.currentRank + 1, info.maxRank)
        info.nextRankName = RENOWN_LEVEL_LABEL:format(info.nextRank)
        info.capValue = info.maxRank * MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL
        
    else
        info.type = "standard"
        info.currentRank = factionData.reaction
        info.maxRank = MAX_REPUTATION_REACTION -- or minus one because you can't gain at exalted?
        info.floorValue = factionData.currentReactionThreshold
        info.currentValue = factionData.currentStanding - factionData.currentReactionThreshold
        info.nextRankValue = factionData.nextReactionThreshold - info.floorValue
        info.nextRank = min(info.currentRank + 1, info.maxRank)
        info.nextRankName = GetText("FACTION_STANDING_LABEL"..info.nextRank, UnitSex("player"))
        info.capValue = AbsMinForStanding[MAX_REPUTATION_REACTION]
    end
    return info
end


function T:ItemCount(itemID)
    if DB.TimeLimitedPurchase[itemID] and not T.Settings.IncludeTimewarped then
        return 0, 0, 0, 0
    end
    if FFF_FakeItemCount and FFF_FakeItemCount[itemID] then
        -- useful for debugging
        return FFF_FakeItemCount[itemID], 0, 0, 0
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

function T:AfterTurninsText(potential, factionID, factionData, friendshipData, rankData)
    local potentialTotal = potential + rankData.currentValue + rankData.floorValue

    local text, color
    if rankData.type == "friendship" then
        -- if > current rank, output e.g. "better friend + 2000", otherwise e.g. "good friend (3241/6000)"
        local potentialTotal = rankData.currentValue + rankData.floorValue + potential
        if rankData.nextRankValue and potentialTotal > rankData.nextRankValue then
            local pointsInto = potentialTotal - rankData.nextRankValue
            text = rankData.nextRankName .. " + " .. pointsInto
        else
            local newValue = potentialTotal - rankData.floorValue
            local maxValue = rankData.nextRankValue and rankData.nextRankValue or (rankData.capValue - rankData.floorValue)
            text = L.RankWithValues:format(friendshipData.reaction, newValue, maxValue)
        end
        color = FACTION_BAR_COLORS[5] -- friendship is always green

    elseif rankData.type == "paragon" then
        local potentialTotal = rankData.currentValue + rankData.floorValue + potential
        if rankData.nextRankValue and potentialTotal > rankData.nextRankValue then
            local pointsInto = potentialTotal - rankData.nextRankValue
            text = rankData.nextRankName -- .. " + " .. pointsInto -- can we gain past reward?
        else
            local newValue = potentialTotal - rankData.floorValue
            local maxValue = rankData.nextRankValue and rankData.nextRankValue or (rankData.capValue - rankData.floorValue)
            text = T:StandingText(factionID, false, factionData)
            text = L.RankWithValues:format(text, newValue, maxValue)
        end
        -- TODO switch color for standard+paragon, major+paragon
        color = FACTION_BAR_COLORS[MAX_REPUTATION_REACTION]
        
    elseif rankData.type == "major" then
        local potentialRank, pointsInto = T:MajorFactionRenownForValue(rankData.currentValue, rankData.currentRank, potential)
        text = RENOWN_LEVEL_LABEL:format(potentialRank)
        text = L.RankWithValues:format(text, pointsInto, MAJOR_FACTION_POINTS_PER_RENOWN_LEVEL)
        color = BLUE_FONT_COLOR

    else -- standard
        local potentialRank, pointsInto, localMax = T:StandingForValue(potentialTotal)
        text = GetText("FACTION_STANDING_LABEL"..potentialRank, UnitSex("player"))
        color = FACTION_BAR_COLORS[potentialRank]
        
        if potentialRank < MAX_REPUTATION_REACTION then
            text = L.RankWithValues:format(text, pointsInto, localMax)
        end

    end
    return text, color
end

function T:TooltipAddFactionReport(tooltip, factionID, factionData, friendshipData, skipInitialPadding)
    if not factionData then
        factionData = C_Reputation.GetFactionDataByID(factionID)
    end
    if not friendshipData then
        friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
    end
    local potential, reportLines, rankData = T:FactionPotential(factionID, true, factionData, friendshipData)
    if potential == 0 then return end
        
    if not skipInitialPadding then
        GameTooltip_AddBlankLineToTooltip(tooltip)
    end
    GameTooltip_AddNormalLine(tooltip, L.TotalPotentialLabel:format(potential))
    
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
    
    local text, color = T:AfterTurninsText(potential, factionID, factionData, friendshipData, rankData)

    GameTooltip_AddColoredDoubleLine(tooltip, L.AfterTurninsLabel, text, HIGHLIGHT_FONT_COLOR, color)
end

------------------------------------------------------
-- Debug aids
------------------------------------------------------

-- debug only
function FFF_PrintReport(factionID)
    local factionData = C_Reputation.GetFactionDataByID(factionID)
    local friendshipData = C_GossipInfo.GetFriendshipReputation(factionID)
    
    local potential, reportLines, rankData = T:FactionPotential(factionID, true, factionData, friendshipData)
        
    local standingText, color = T:StandingText(factionID, true, factionData, friendshipData)
    
    print(factionData.name, standingText)
    print(L.TotalPotentialLabel:format(potential))
    
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
    
    local afterTurnins = T:AfterTurninsText(potential, factionID, factionData, friendshipData, rankData)
    
    print(L.AfterTurninsLabel, afterTurnins)
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
    -- friendshipData: table
    -- rankData: table
}

function T:FactionPotential(factionID, withReport, factionData, friendshipData)
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

function PG:GetPotential(factionID, factionData, friendshipData)
    
    local rankInRange = function(rank, min, max, cap)
        local atOrAboveMin = rank >= (min or 1)
        local atOrBelowMax = rank <= (max or cap)
        return atOrAboveMin and atOrBelowMax
    end

    local factionQuests = DB.TurninsByQuest[factionID]
    if (factionQuests == nil) then return 0 end

    self.factionData = factionData or C_Reputation.GetFactionDataByID(factionID)
    self.friendshipData = friendshipData or C_GossipInfo.GetFriendshipReputation(factionID)
    self.rankData = T:GetRankInfo(factionID, factionData, friendshipData)
    
    local descending = function(a,b) return a > b end
    for key, info in GFWTable.PairsByKeys(factionQuests, descending) do
        -- is our rep in range for this quest?
        local meetsRequirements = self.rankData.type == "paragon" or rankInRange(self.factionData.reaction, info.minStanding, info.maxStanding, self.rankData.maxRank)
        
        -- if quest requires another faction too,
        -- is our rep with them in range?
        if meetsRequirements and info.otherFactionRequired then
            local otherFactionData = C_Reputation.GetFactionDataByID(info.otherFactionRequired.faction)
            local otherFactionRankData = T:GetRankInfo(info.otherFactionRequired.faction)
            meetsRequirements = meetsRequirements and rankInRange(otherFactionData.reaction, info.otherFactionRequired.minStanding, info.otherFactionRequired.maxStanding, otherFactionRankData.maxRank)
        end
        
        if meetsRequirements then
            self.totalPotential = self.totalPotential + self:QuestPotential(key, info)
        end
    end

    return self.totalPotential, self.reportLines, self.rankData
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
    potentialValue, numTurnins = self:AdjustedPotential(numTurnins, info.value, info)
    if info.buyValue then
        -- only track gain from currency purchases if no other turnins available
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
        self.itemsAccounted[itemID] = (self.itemsAccounted[itemID] or 0) + numTurnins * qtyPerTurnin
        
        -- get the link even if not reporting
        -- since that caches it for when next we need it
        local itemLink = T:ItemLink(itemID)

        if numTurnins > 0 and self.reportLines then
            local lineItem = self:ItemTurninReport(itemID, itemLink, numTurnins, qtyPerTurnin, info.purchased)
            tinsert(reportItemLines, lineItem)
        end
    end
    
    -- Finally, throw what we've figured out into the report/tooltip
    if self.reportLines then
        local header = self:CompleteQuestReport(potentialValue, numTurnins, info.useItem, createdItemLink)
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
        createdItemLink = L.L.ReportLineItem:format(createdID)
    end
    return createdItemLink
end

function PG:ItemTurninReport(itemID, itemLink, numTurnins, qtyPerTurnin, purchased)
    local itemsForTurnin = numTurnins * qtyPerTurnin
    local lineItem = L.ReportLineItem:format(itemsForTurnin, itemLink)
    local inBags, inBank, inReagents, inWarband = T:ItemCount(itemID)
    local totalCount = inBags + inBank + inReagents + inWarband
    
    local lineItemAdditions = {}
    if inBank > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, L.CountInBank:format(min(inBank, itemsForTurnin)))
    end
    if inReagents > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, L.CountInReagents:format(min(inReagents, itemsForTurnin)))
    end
    if inWarband > 0 and inBags < itemsForTurnin then
        tinsert(lineItemAdditions, L.CountInWarband:format(min(inWarband, itemsForTurnin)))
    end
    local created = self.itemsCreated[itemID]
    local allText = purchased and L.AllPurchased or L.AllCreated
    local countText = purchased and L.CountPurchased or L.CountCreated
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

function PG:CompleteQuestReport(potentialValue, numTurnins, useItem, createdItemLink)
    local reportLineHeader
    if potentialValue > 0 then
        reportLineHeader = L.ReportPoints:format(potentialValue)
        if numTurnins > 1 and not useItem then
            reportLineHeader = reportLineHeader  ..GRAY_FONT_COLOR:WrapTextInColorCode(L.ReportNumTurnins:format(numTurnins))
        end
        return reportLineHeader ..":"
    elseif potentialValue == 0 and numTurnins > 0 then
        -- this represents a purchase
        reportLineHeader = L.ReportPurchase:format(numTurnins, createdItemLink)
        return reportLineHeader ..":"
    end
end

function PG:AdjustedPotential(numTurnins, turninValue, info)
    -- figure out how much rep we can gain from what we have for the turnin
    -- but adjust how many turnins to make if it'll max us out
    -- (whether in terms of how far the turnin goes or to max)
    local currentValue = self.rankData.currentValue + self.rankData.floorValue
    
    local potentialValue = numTurnins * turninValue
    local potentialRank = self.rankData.currentRank
    local potentialTotal = currentValue + potentialValue
    if self.rankData.nextRankValue and potentialTotal >= self.rankData.nextRankValue then
        if self.rankData.type == "standard" then
            potentialRank = T:StandingForValue(potentialTotal)
        elseif self.rankData.type == "major" then
            potentialRank = T:MajorFactionRenownForValue(currentValue, self.rankData.currentRank, potentialValue)
        else
            potentialRank = self.rankData.nextRank
        end
    end
    -- print(self.factionData.name)
    -- DevTools_Dump(self.rankData)

    -- count only the turnins needed to reach max
    -- but only if we know how many ranks ahead
    local turninMaxRank = info.maxStanding or self.rankData.maxRank
    -- print("turninValue", turninValue, "potentialRank", potentialRank, "potentialTotal", potentialTotal, "turninMaxRank", turninMaxRank)
    if turninValue > 0 and potentialRank >= turninMaxRank then
        -- adjust potential to fit within cap or turnin max rank 
        local absMaxValue
        if self.rankData.type == "friendship" then
            absMaxValue = self.rankData.capValue
            print("friensdhip cap", absMaxValue)
        elseif self.rankData.type == "paragon" then
            absMaxValue = self.rankData.maxRank * self.rankData.nextRankValue
        elseif self.rankData.type == "major" then
            absMaxValue = self.rankData.capValue
        else -- standard
            maxValue = info.maxValue or PointsPerStanding[turninMaxRank]
            absMaxValue = AbsMinForStanding[turninMaxRank] + maxValue
        end
        if currentValue >= absMaxValue then
            potentialValue = 0
        end
        local maxPotential = max(absMaxValue - currentValue, 0)
        potentialValue = min(potentialValue, maxPotential)
        -- force numTurnins to integer, recalc potentialValue based on that
        -- because we can't do a fractional number of turnins...
        numTurnins = ceil(potentialValue / turninValue)
        
        if turninValue == info.buyValue and potentialRank > turninMaxRank then
            -- when calculating how many to buy, count the ones we already own
            -- before adjusting to fit within maximum
            for createdID, _ in pairs(info.creates) do
                local inBags, inBank, inReagents, inWarband = T:ItemCount(createdID)
                local alreadyOwned = inBags + inBank + inReagents + inWarband
                numTurnins = numTurnins - alreadyOwned -- TODO bug here? #turnins or #items/turnin
                break	-- there should only be one created item in this case
            end
        end
        potentialValue = numTurnins * turninValue
    end
    return potentialValue, numTurnins
end

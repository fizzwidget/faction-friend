local addonName, T = ...
local DB = _G[addonName.."_DB"]

function T:FactionPotential(factionID, withReport)

    local function reactionInRange(reaction, qInfo)
        local atOrAboveMin = reaction >= (qInfo.minStanding or 1)
        local atOrBelowMax = reaction <= (qInfo.maxStanding or MAX_REPUTATION_REACTION)
        return atOrAboveMin and atOrBelowMax
    end

    local factionData = C_Reputation.GetFactionDataByID(factionID)
    
    local factionQuests = DB.ByQuest[factionID]
    if (factionQuests == nil) then return 0; end
    
    local totalPotential = 0
    local reportLines = {}

    local itemsAccounted = {}
    local itemsCreated = {}
    for quest, qInfo in GFWTable.PairsByKeys(factionInfo, function(a,b) return a > b end) do
        -- is our rep in range for this quest?
        local meetsRequirements = reactionInRange(factionData.reaction, qInfo)
        
        -- if quest requires another faction too,
        -- is our rep with them in range?
        if meetsRequirements and qInfo.otherFactionRequired then
            local otherFactionData = C_Reputation.GetFactionDataByID(qInfo.otherFactionRequired.faction)
            meetsRequirements = meetsRequirements and reactionInRange(otherFactionData.reaction, qInfo.otherFactionRequired)
        end
        
        local potentialValue = T:QuestPotential(qInfo, factionData)
    end


end

function T:QuestPotential(qInfo, factionData)
    local potentialValue = 0
    local reportItemLines = {}
     
    -- first, figure out how many turnins' worth we have of each item the quest requres
    local turninCounts = {}
    for itemID, qtyPerTurnin in pairs(qInfo.items) do
        local countIncludingBank = T:GetItemCount(itemID, true)
        local created = itemsCreated[itemID] or 0
        local alreadyCounted = itemsAccountedFor[itemID] or 0
        local turnins = math.floor((countIncludingBank + created - alreadyCounted) / qtyPerTurnin)
        -- print(quest, countIncludingBank, created, alreadyCounted)
        tinsert(turninCounts, turnins)
    end

end

function T:ItemCount(itemID, includeBank)
    if (type(itemID) == "string") then
        -- currency
        local currencyID = strmatch(itemID, "currency:(%d+)")
        currencyID = tonumber(currencyID)
        local count = C_CurrencyInfo.GetCurrencyInfo(currencyID).quantity
        return count
    end
    
    if (FFF_FakeItemCount and FFF_FakeItemCount[itemID]) then
        -- useful for debugging
        return FFF_FakeItemCount[itemID]
    end
    return C_Item.GetItemCount(itemID, includeBank)

end

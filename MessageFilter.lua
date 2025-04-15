local addonName, T = ...

------------------------------------------------------
-- Message filter for reputation / standing change
------------------------------------------------------

function T:ParseFactionMessage(message, patternList)
    for _, pattern in pairs(patternList) do
        local regex = T.Patterns[pattern]
        local match1, match2 = strmatch(message, regex)
        if match1 then
            -- for the patterns we use:
            -- faction amount gain: match1 is factionName, match1 is amount or nil
            -- faction standing change: match1 is new standing, match2 is factionName or nil
            return match1, match2, pattern
        end
    end
end

function T:FactionAmountChangeFromMessage(message)
    
    local factionName, amount, pattern

    -- patterns from format strings in BlizzardInterfaceResources/GlobalStrings/[locale].lua
    local decreasePatterns = {
        "FACTION_STANDING_DECREASED",
        "FACTION_STANDING_DECREASED_ACCOUNT_WIDE",
        "FACTION_STANDING_DECREASED_GENERIC", -- no amount
        "FACTION_STANDING_DECREASED_GENERIC_ACCOUNT_WIDE", -- no amount
    }
    local increasePatterns = {
        "FACTION_STANDING_INCREASED",
        "FACTION_STANDING_INCREASED_ACCOUNT_WIDE",
        "FACTION_STANDING_INCREASED_ACH_BONUS",
        "FACTION_STANDING_INCREASED_ACH_BONUS_ACCOUNT_WIDE",
        "FACTION_STANDING_INCREASED_BONUS",
        "FACTION_STANDING_INCREASED_DOUBLE_BONUS",
        "FACTION_STANDING_INCREASED_GENERIC", -- no amount
        "FACTION_STANDING_INCREASED_GENERIC_ACCOUNT_WIDE", -- no amount
    }
     
    factionName, amount, pattern = self:ParseFactionMessage(message, decreasePatterns)
    if (factionName) then
        if amount then
            amount = tonumber(amount) * -1 
        else
            amount = 0
        end
        return factionName, amount, pattern
    end

    factionName, amount, pattern = self:ParseFactionMessage(message, increasePatterns)
    if (factionName) then
        if amount then
            amount = tonumber(amount)
        else
            amount = 0
        end
        return factionName, amount, pattern
    end
end

T.QueuedFactionGains = {}
T.QueuedFactionGainsCheckTimer = nil
function T:QueuedFactionGainsCheck(timer)
    if #T.QueuedFactionGains == 0 then
        T.QueuedFactionGainsCheckTimer:Cancel()
        return
    end
    
    sort(T.QueuedFactionGains, function(a, b) return a.amount > b.amount end)
    
    local highestGainFactionID = T.QueuedFactionGains[1].id
    T:TrySetWatchedFaction(highestGainFactionID)
    wipe(T.QueuedFactionGains)
end

function T:CombatMessageFilter(event, message, ...)	
    local factionName, amount, pattern = T:FactionAmountChangeFromMessage(message)
    local factionID = T.FactionIDForName[factionName]
        
    -- add to recents
    T:AddToRecents(factionID)
    
    -- check name of guild faction
    -- message might have either actual guild name or a generic token
    if not factionID and (factionName == GUILD or factionName == GUILD_REPUTATION) then
        factionID = GUILD_FACTION_ID
        factionName = GetGuildInfo("player")
    end
    
    -- switch watched faction only for gains
    if amount > 0 and T:ShouldSetWatchedFaction(factionID) then
        -- accumulate recent changes, switch bar only for the "best"
        -- e.g. 5 everlook, 5 ratchet, 10 gadgetzan, 5 booty bay -> switch to gadgetzan
        tinsert(T.QueuedFactionGains, { id = factionID, amount = amount })
        if T.QueuedFactionGainsCheckTimer then
            T.QueuedFactionGainsCheckTimer:Cancel()
        end
        T.QueuedFactionGainsCheckTimer = C_Timer.NewTimer(0.5, T.QueuedFactionGainsCheck)
    end
    
    local factionData = C_Reputation.GetFactionDataByID(factionID)
    local friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)
    local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0

    -- move to inactive if exalted / max rank
        -- unless paragon faction
        -- skip guild faction too
    
    -- output modified message according to settings
    if not T.Settings.ModifyChat then
        return false
    end
        
    local link = T:FactionLink(factionID, factionData, friendshipData)
    
    local message
    if amount > 0 then
        local addendum = T:RepeatGainsMessage(factionID, amount, factionData, friendshipData)
        message = format(_G[pattern], link, amount) .. " " .. addendum
    else
        message = format(_G[pattern], link)
    end
    
    return false, message, ...
end

function T:FactionStandingChangeFromMessage(message)
    local newStanding, factionName, pattern

    local factionPatterns = {
        "FACTION_STANDING_CHANGED",
        "FACTION_STANDING_CHANGED_ACCOUNT_WIDE",
    }
    
    local friendshipPatterns = {
        "FRIENDSHIP_STANDING_CHANGED",
        "FRIENDSHIP_STANDING_CHANGED_ACCOUNT_WIDE",
    }
    local guildPatterns = {
        "FACTION_STANDING_CHANGED_GUILD", -- no factionName
        "FACTION_STANDING_CHANGED_GUILDNAME",
    }
    
    local isGuild, isFriendship
    
    newStanding, factionName, pattern = self:ParseFactionMessage(message, factionPatterns)
    if factionName then
        return newStanding, factionName, pattern
    end
    
    -- these reverse standing and factionName
    factionName, newStanding, pattern = self:ParseFactionMessage(message, friendshipPatterns)
    if factionName then
        isFriendship = true
        return newStanding, factionName, pattern, isFriendship, isGuild
    end
    
    newStanding, factionName, pattern = self:ParseFactionMessage(message, guildPatterns)
    if factionName then
        isGuild = true
        return newStanding, factionName, pattern, isFriendship, isGuild
    end

end

function T:SystemMessageFilter(event, message, ...)
    local newStanding, factionName, pattern, isFriendship, isGuild = T:FactionStandingChangeFromMessage(message)
    if not newStanding then
        -- lots of CHAT_MSG_SYSTEM we're not interested in
        return false
    end

    local factionID = T.FactionIDForName[factionName]
    if not factionID and isGuild then
        factionID = GUILD_FACTION_ID
        factionName = GetGuildInfo("player")
    end
            
    -- add to recents
    T:AddToRecents(factionID)
        
    -- (don't switch watched faction; we do that only for gains)
    
    -- move to inactive if exalted / max rank
        -- unless paragon faction
        -- skip guild faction too

    -- TODO queued message stuff from original version?

    -- output modified message according to settings
    if not T.Settings.ModifyChat then
        return false
    end
    
        
    local factionData = C_Reputation.GetFactionDataByID(factionID)
    local friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)

    local link = T:FactionLink(factionID, factionData, friendshipData)
    
    local message
    if isFriendship then
        message = format(_G[pattern], link, newStanding)
    else
        message = format(_G[pattern], newStanding, link)		
    end
    
    return false, message, ...

end

function T:ShouldSetWatchedFaction(factionID)
    if factionID == GUILD_FACTION_ID then
        return self.Settings.IncludeGuild
    elseif DB.BodyguardFactionID[factionID] then
        return self.Settings.IncludeBodyguards
    end
    return true
end

function T:RepeatGainsMessage(factionID, amount, factionData, friendshipData)
    local maxValue, currentValue
    local nextStatusName
    
    local isFriendship = friendshipData and friendshipData.friendshipFactionID > 0
    if isFriendship then
        local isMaxRank = friendshipData.nextThreshold == nil
        if isMaxRank then
            return FFF_AT_MAXIMUM
        else
            maxValue = friendshipData.nextThreshold
            currentValue = friendshipData.standing
            nextStatusName = FFF_NEXT_RANK -- can't get next name for friendships
        end
    elseif C_Reputation.IsMajorFaction(factionID) then
        local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
        
        currentValue = majorFactionData.renownReputationEarned
        maxValue = majorFactionData.renownLevelThreshold

        local renownLevelsInfo = C_MajorFactions.GetRenownLevels(factionID)
        local maxRenownLevel = renownLevelsInfo[#renownLevelsInfo].level

        if majorFactionData.renownLevel == maxRenownLevel then
            nextStatusName = FFF_MAXIMUM
        else 
            nextStatusName = RENOWN_LEVEL_LABEL:format(majorFactionData.renownLevel + 1)
        end
        
        nextStatusName = BLUE_FONT_COLOR:WrapTextInColorCode(nextStatusName)

    else
        local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
        if C_Reputation.IsFactionParagon(factionID) then
            local currentStanding, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)

            maxValue = threshold

            -- TODO is this condition applicable?
            -- if ( not hasRewardPending and currentValue and threshold ) then
            currentValue = mod(currentStanding, threshold)
            -- show overflow if reward is pending
            if hasRewardPending then
                currentValue = currentValue + threshold
            end
            nextStatusName = FFF_PARAGON_REWARD
        elseif isCapped then
            return FFF_AT_MAXIMUM
        else
            maxValue = factionData.nextReactionThreshold
            currentValue = factionData.currentStanding
            
            local nextStanding = factionData.reaction + 1
            nextStatusName = GetText("FACTION_STANDING_LABEL"..nextStanding, UnitSex("player"))
            local nextStatusColor = FACTION_BAR_COLORS[math.min(nextStanding, MAX_REPUTATION_REACTION)]
            nextStatusName = nextStatusColor:WrapTextInColorCode(nextStatusName)
        end
    end
    
    local repToNext = maxValue - currentValue;
    local gainsToNext = repToNext / amount;
    local message = format(FFF_REPEAT_TURNINS, gainsToNext, nextStatusName)
    
    return message
end

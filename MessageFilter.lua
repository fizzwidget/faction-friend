local addonName, T = ...
local DB = _G[addonName.."_DB"]
local L = _G[addonName.."_Locale"].Text

------------------------------------------------------
-- Utilities
------------------------------------------------------

T.FormatMatchInfo = {}
function T:FormatMatch(text, formatStringName)
    
    local pattern, reorders = T.FormatMatchInfo[formatStringName]
    if not pattern then
        pattern = _G[formatStringName]
        
        -- record the order of reordering specifiers (e.g. %2$s)	
        reorders = {}
        for index in string.gmatch(pattern, "%%(%d+)%$[diouXxfgbcsq]") do
            tinsert(reorders, tonumber(index))
        end
        -- then strip the reordering specifiers
        pattern = pattern:gsub("%%%d+%$([diouXxfgbcsq])", "%%%1") 

        -- so we can transform the format string to a ~regex~ pattern
        pattern = pattern:gsub("%%(%d-[diu])", "%%d") -- strip field widths from int
        pattern = pattern:gsub("%%(%d-%.?%d-[gef])", "%%f") -- and from float
        pattern = pattern:gsub("([%$%(%)%.%[%]%*%+%-%?%^])", "%%%1") -- convert special characters
        pattern = pattern:gsub("%%c", "(.)") -- %c to (.)
        pattern = pattern:gsub("%%s", "(.+)") -- %s to (.+)
        pattern = pattern:gsub("%%d", "(%%d+)") -- %d to (%d+)
        pattern = pattern:gsub("%%f", "(%%d+%%.*%%d*)") -- %g or %f to (%d+%.*%d*)
        
        -- cache it
        T.FormatMatchInfo[formatStringName] = pattern, reorders
    end

    -- search input text according to the pattern
    local matches = {strmatch(text, pattern)}
    local output = {}
    for index in pairs(matches) do
        -- reorder the output according to saved reorders (no reordering if no reorders)
        local reorderedIndex = reorders and reorders[index] or index
        output[index] = matches[reorderedIndex]
    end
    return unpack(output)

end

-- not a general faction name to ID map: resolves name collisions using 
-- assumptions related to reputation-gain messages 
function T:ReputationGainFactionID(name, isWarband)
    if not T.FactionNamesWithReputation then
        T.FactionNamesWithReputation = {}
    end
    local cacheKey = name .. (isWarband and "|W" or "")
    local cache = T.FactionNamesWithReputation
    local cachedFactionID = cache[cacheKey]
    if cachedFactionID then return cachedFactionID end
    
    for index = 1, T.MAX_FACTIONS do
        local data = C_Reputation.GetFactionDataByIndex(index)
        -- we use this only for identifying factionID that just changed rep / standing
        -- if data then print(data.name, name == data.name, data.isAccountWide, isWarband) end
        if (data and data.name == name)
        -- ignore factions that don't have a reputation bar
        -- (handles collision between War Within / Classic Steamwheedle Cartel)
        and (data.isHeaderWithRep or not data.isHeader) 
        -- match whether the faction we're looking for is account wide
        -- (handles collision between War Within / Classic Bilgewater Cartel)        
        and ((data.isAccountWide and isWarband) or not (data.isAccountWide or isWarband)) then -- xnor
            cache[cacheKey] = data.factionID
            return data.factionID
        end
    end
end

function T:ParseFactionMessage(message, patternList)
    for _, pattern in pairs(patternList) do
        local match1, match2 = T:FormatMatch(message, pattern)
        if match1 then
            -- for the patterns we use:
            -- faction amount gain: match1 is factionName, match1 is amount or nil
            -- faction standing change for guild: match1 is new standing
            -- faction standing change: match1 is new standing, match2 is factionName or nil
            return match1, match2, pattern
        end
    end
end

------------------------------------------------------
-- Combat message filter for reputation change
------------------------------------------------------

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

-- timer-based queue for accumulating / sorting "same time" gains
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

-- programmatically triggered queue for order dependency of getting factino info
T.CombatMessageQueue = {}
function T:QueueCombatMessage(frame, event, message, factionName, ...)
    if not T.CombatMessageQueue[factionName] then
        T.CombatMessageQueue[factionName] = {}
    end
    tinsert(T.CombatMessageQueue[factionName], {frame=frame, event=event, message=message, args={...}})
end

function T:HandleQueuedCombatMessages(factionName)
    if not factionName then return end
    local messages = T.CombatMessageQueue[factionName] or {}
    T.CombatMessageQueue[factionName] = nil
    for _, messageInfo in pairs(messages) do
        -- TODO this might not work as intended
        -- especially when switching to frame:MessageEventHandler
        -- we queue on behalf of our event-handling frame, but we want all actual ChatFrames to handle the queued message
        ChatFrame_MessageEventHandler(messageInfo.frame, messageInfo.event, messageInfo.message, unpack(messageInfo.args))
    end
end

function T:CombatMessageFilter(event, message, ...)	
    local factionName, amount, pattern = T:FactionAmountChangeFromMessage(message)
    if not factionName then 
        -- likely missing localized string pattern (this happens for Brann in Delves)
        -- print("factionName not parsed from combat message")    
        return false 
    end

    local isWarbandFaction = strsub(pattern, -strlen("ACCOUNT_WIDE")) == "ACCOUNT_WIDE"
    local factionID = T:ReputationGainFactionID(factionName, isWarbandFaction)
    if not factionID then
        factionID = T:ReputationGainFactionID(factionName) -- recheck since some ACCOUNT_WIDE formats aren't unique
    end

    -- can't do anything if we don't know the faction yet
    -- keep track of the message so we can try again when the faction becomes known
    if not factionID then
        T:QueueCombatMessage(self, event, message, factionName, ...)
        return true
    end
        
    -- add to recents
    T.AddToRecents(factionID)
    
    -- check name of guild faction
    -- message might have either actual guild name or a generic token
    if not factionID and (factionName == GUILD or factionName == GUILD_REPUTATION) then
        factionID = T.GUILD_FACTION_ID
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

    if T.Settings.CleanUpOnComplete then
        T:CleanUpFactionIfCompleted(factionID, factionData, friendshipData)
    end
    
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

------------------------------------------------------
-- Message filter for standing (rank) change
------------------------------------------------------

function T:FactionStandingChangeFromMessage(message)
    local newStanding, factionName, pattern

    local noNameGuildPattern = {
        "FACTION_STANDING_CHANGED_GUILD", -- no factionName
    }
    local factionPatterns = {
        "FACTION_STANDING_CHANGED",
        "FACTION_STANDING_CHANGED_ACCOUNT_WIDE",
    }
    local friendshipPatterns = {
        "FRIENDSHIP_STANDING_CHANGED",
        "FRIENDSHIP_STANDING_CHANGED_ACCOUNT_WIDE",
    }
    local withNameGuildPattern = {
        -- Test this after factionPatterns (even though FACTION_STANDING_CHANGED_GUILD needs to test before)
        -- because in locales where they're the same, FACTION_STANDING_CHANGED should look up guild
        -- if we know what your guild name is
        
        "FACTION_STANDING_CHANGED_GUILDNAME",
    }
    
    local isGuild, isFriendship
    
    -- this has no factionName
    newStanding, _, pattern = self:ParseFactionMessage(message, noNameGuildPattern)
    if pattern then
        isGuild = true
        return newStanding, factionName, pattern, isFriendship, isGuild
    end
    
    newStanding, factionName, pattern = self:ParseFactionMessage(message, factionPatterns)
    if pattern then
        return newStanding, factionName, pattern
    end
    
    -- these reverse standing and factionName
    factionName, newStanding, pattern = self:ParseFactionMessage(message, friendshipPatterns)
    if pattern then
        isFriendship = true
        return newStanding, factionName, pattern, isFriendship, isGuild
    end
    
    -- this needs to be last because normal FACTION_STANDING_CHANGED should match "gained %d with %s" first
    newStanding, _, pattern = self:ParseFactionMessage(message, withNameGuildPattern)
    if pattern then
        isGuild = true
        return newStanding, factionName, pattern, isFriendship, isGuild
    end

end


T.SystemMessageQueue = {}
function T:QueueSystemMessage(frame, event, message, ...)
    tinsert(T.SystemMessageQueue, {frame=frame, event=event, message=message, args={...}})
end

function T:HandleQueuedSystemMessages()
    local messages = T.SystemMessageQueue or {}
    T.SystemMessageQueue = {}
    for _, messageInfo in pairs(messages) do
        ChatFrame_MessageEventHandler(messageInfo.frame, messageInfo.event, messageInfo.message, unpack(messageInfo.args))
    end
end

function T:SystemMessageFilter(event, message, ...)
    local newStanding, factionName, pattern, isFriendship, isGuild = T:FactionStandingChangeFromMessage(message)
    if not newStanding then
        -- lots of CHAT_MSG_SYSTEM we're not interested in
        return false
    end

    local isWarbandFaction = strsub(pattern, -strlen("ACCOUNT_WIDE")) == "ACCOUNT_WIDE"
    local factionID = T:ReputationGainFactionID(factionName, isWarbandFaction)
    if not factionID then
        factionID = T:ReputationGainFactionID(factionName) -- recheck since some ACCOUNT_WIDE formats aren't unique
    end
    
    if not factionID and isGuild then
        factionID = T.GUILD_FACTION_ID
        factionName = GetGuildInfo("player")

        -- on joining a guild, FACTION_STANDING_CHANGED_GUILD fires before GetGuildInfo can return data
        -- and FACTION_STANDING_CHANGED_GUILD doesn't include guild name
        -- queue handling this system message until guild info is ready
        if not factionName then
            if not T.EventHandlers.PLAYER_GUILD_UPDATE then
                -- create this function first time we need it so we don't have to register/unregister
                T.EventHandlers.PLAYER_GUILD_UPDATE = function(self, unit)
                    local guildName = GetGuildInfo("player")
                    if not guildName then return end
                    
                    T:HandleQueuedSystemMessages()
                    self:UnregisterEvent("PLAYER_GUILD_UPDATE")
                end
            end

            T:QueueSystemMessage(self, event, message, ...)
            return false
        end
    end

    -- take care of any rep-increase messages that predate first learning the faction
    T:HandleQueuedCombatMessages(factionName)
    
    -- add to recents
    T.AddToRecents(factionID)
        
    -- (don't switch watched faction; we do that only for gains)
    
    local factionData = C_Reputation.GetFactionDataByID(factionID)
    local friendshipData = C_GossipInfo.GetFriendshipReputation(factionData.factionID)

    if T.Settings.CleanUpOnComplete then
        T:CleanUpFactionIfCompleted(factionID, factionData, friendshipData)
    end

    -- output modified message according to settings
    if not T.Settings.ModifyChat then
        return false
    end

    -- change guild pattern without factionName so we can use a link
    if pattern == "FACTION_STANDING_CHANGED_GUILD" then
        pattern = "FACTION_STANDING_CHANGED_GUILDNAME"
    end
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
    if factionID == T.GUILD_FACTION_ID then
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
    local isMajorFaction = C_Reputation.IsMajorFaction(factionID)
    local isParagon = C_Reputation.IsFactionParagon(factionID)
    if isFriendship then
        local isMaxRank = friendshipData.nextThreshold == nil
        if isMaxRank then
            return L.AtMaximum
        else
            maxValue = friendshipData.nextThreshold
            currentValue = friendshipData.standing
            nextStatusName = L.NextRank -- can't get next name for friendships
        end
    elseif isParagon then
        local currentStanding, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(factionID)
        if hasRewardPending then
            return L.ParagonRewardReady
        else        
            maxValue = threshold
            currentValue = currentStanding % threshold
            -- show overflow if reward is pending
            if hasRewardPending then
                currentValue = currentValue + threshold
            end
            nextStatusName = L.ParagonReward
        end
        
    elseif isMajorFaction then
        local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
        
        currentValue = majorFactionData.renownReputationEarned
        maxValue = majorFactionData.renownLevelThreshold

        if C_MajorFactions.HasMaximumRenown(factionID) then
            nextStatusName = L.Maximum
        else 
            nextStatusName = RENOWN_LEVEL_LABEL:format(majorFactionData.renownLevel + 1)
        end
        
        nextStatusName = BLUE_FONT_COLOR:WrapTextInColorCode(nextStatusName)

    else
        local isCapped = factionData.reaction == MAX_REPUTATION_REACTION
        if isCapped then
            return L.AtMaximum
        else
            maxValue = factionData.nextReactionThreshold
            currentValue = factionData.currentStanding
            
            local nextStanding = factionData.reaction + 1
            nextStatusName = GetText("FACTION_STANDING_LABEL"..nextStanding, UnitSex("player"))
            local nextStatusColor = FACTION_BAR_COLORS[math.min(nextStanding, MAX_REPUTATION_REACTION)]
            nextStatusName = nextStatusColor:WrapTextInColorCode(nextStatusName)
        end
    end
    
    local repToNext = maxValue - currentValue
    local gainsToNext = ceil(repToNext / amount)
    local message = format(L.RepeatTurnins, gainsToNext, nextStatusName)
    
    return message
end

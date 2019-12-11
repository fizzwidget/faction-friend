------------------------------------------------------
-- FFF_ItemInfo.lua
------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

------------------------------------------------------
-- Faction IDs
------------------------------------------------------
FFF_FactionIDs = {
-- Classic
    ZANDALAR = 270,
    BROOD_NOZDORMU = 910,
    CENARION_CIRCLE = 609,
    ARGENT_DAWN = 529,
    TIMBERMAW = 576,
    THORIUM_BROTHERHOOD = 59,
    HYDRAXIAN_WATERLORDS = 749,
-- Horde/Alliance racial factions   
    HORDE = 67,
        ORC = 76,
        TAUREN = 81,
        TROLL = 530,
        FORSAKEN = 68,
    ALLIANCE = 469,
        DWARF = 47,
        NELF = 69,
        GNOME = 54,
        HUMAN = 72,
-- Horde/Alliance Forces            
    FROSTWOLF = 729,
    DEFILERS = 510,
    WARSONG_OUTRIDERS = 889,
    STORMPIKE = 730,
    ARATHOR = 509,
    SILVERWING = 890,
}
local F = FFF_FactionIDs;

------------------------------------------------------
-- For zone-based switching
------------------------------------------------------
FFF_ZoneFactions = {
    ["Horde"] = {
        [ZONE_AV] = F.FROSTWOLF,
        [ZONE_AB] = F.DEFILERS,
        [ZONE_WSG] = F.WARSONG_OUTRIDERS,
    },
    ["Alliance"] = {
        [ZONE_AV] = F.STORMPIKE,
        [ZONE_AB] = F.ARATHOR,
        [ZONE_WSG] = F.SILVERWING,
    },
    ["Neutral"] = {
        [ZONE_SILITHUS] = F.CENARION_CIRCLE,
        [ZONE_AQ20] = F.CENARION_CIRCLE,
        [ZONE_AQ40] = F.BROOD_NOZDORMU,
        [ZONE_FELWOOD] = F.TIMBERMAW,
        [ZONE_WINTERSPRING] = F.TIMBERMAW,
        [ZONE_WESTERN_PLAGUELANDS] = F.ARGENT_DAWN,
        [ZONE_EASTERN_PLAGUELANDS] = F.ARGENT_DAWN,
        [ZONE_MOLTEN_CORE] = F.HYDRAXIAN_WATERLORDS,
        [ZONE_BLACKROCK_DEPTHS] = F.THORIUM_BROTHERHOOD,
        [ZONE_SEARING_GORGE] = F.THORIUM_BROTHERHOOD,
    },
};

------------------------------------------------------
-- keeps Alliance/Horde-specific factions from showing up for opposing players
------------------------------------------------------
FFF_ExcludedFactions = {
    ["Alliance"] = {
        [F.FORSAKEN] = 1,
        [F.TROLL] = 1,
        [F.TAUREN] = 1,
        [F.ORC] = 1,
    },
    ["Horde"] = {
        [F.HUMAN] = 1,
        [F.GNOME] = 1,
        [F.NELF] = 1,
        [F.DWARF] = 1,
    },
};

--[[ only used in disabled quest-rep scanning
-- TODO: autogenerate one or the other of these
FFF_FactionGroups = {
    [F.ORC]         = F.HORDE,
    [F.TROLL]       = F.HORDE,
    [F.TAUREN]      = F.HORDE,
    [F.FORSAKEN]    = F.HORDE,
    [F.BELF]        = F.HORDE,
    [F.GOBLIN]      = F.HORDE,
    [F.HUOJIN]      = F.HORDE,
    
    [F.HUMAN]   = F.ALLIANCE,
    [F.DWARF]   = F.ALLIANCE,
    [F.GNOME]   = F.ALLIANCE,
    [F.NELF]    = F.ALLIANCE,
    [F.DRAENEI] = F.ALLIANCE,
    [F.WORGEN]  = F.ALLIANCE,
    [F.TUSHUI]  = F.ALLIANCE,
    
    [F.HAND_VENGEANCE]      = F.HORDE_EXPEDITION,
    [F.TAUNKA]              = F.HORDE_EXPEDITION,
    [F.SUNREAVERS]          = F.HORDE_EXPEDITION,
    [F.WARSONG_OFFENSIVE]   = F.HORDE_EXPEDITION,

    [F.EXPLORERS]       = F.ALLIANCE_VANGUARD,
    [F.FROSTBORN]       = F.ALLIANCE_VANGUARD,
    [F.SILVER_COVENANT] = F.ALLIANCE_VANGUARD,
    [F.VALIANCE]        = F.ALLIANCE_VANGUARD,
}
FFF_GroupFactions = {
    [F.HORDE] = {
        F.ORC,
        F.TROLL,
        F.TAUREN,
        F.FORSAKEN,
        F.BELF,
        F.GOBLIN,
        F.HUOJIN,
    },
    [F.ALLIANCE] = {
        F.HUMAN,
        F.DWARF,
        F.GNOME,
        F.NELF,
        F.DRAENEI,
        F.WORGEN,
        F.TUSHUI,
    },
    [F.HORDE_EXPEDITION] = {
        F.HAND_VENGEANCE,
        F.TAUNKA,
        F.SUNREAVERS,
        F.WARSONG_OFFENSIVE,
    },
    [F.ALLIANCE_VANGUARD] = {
        F.EXPLORERS,
        F.FROSTBORN,
        F.SILVER_COVENANT,
        F.VALIANCE,
    },
}
]]


------------------------------------------------------
-- Localized item names for "created" items, since they can appear without being cached by client
------------------------------------------------------
FFF_SpecialItems = {
    -- vanilla
    [12844] = FFF_ITEM_AD_TOKEN,
    [19858] = FFF_ITEM_ZG_TOKEN,
}

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
------------------------------------------------------
FFF_ItemInfo = {
    
    -- Racial factions: Horde
    [F.TAUREN] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45722] = 1,    -- Thunder Bluff Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45722] = 1,    -- Thunder Bluff Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70153] = 1,    -- Thunder Bluff Writ of Commendation
            },
        },
    },
    [F.TROLL] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45720] = 1,    -- Sen'jin Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45720] = 1,    -- Sen'jin Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70150] = 1,    -- Sen'jin Writ of Commendation
            },
        },
    },
    [F.FORSAKEN] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45723] = 1,    -- Undercity Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45723] = 1,    -- Undercity Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70154] = 1,    -- Undercity Writ of Commendation
            },
        },
    },
    [F.ORC] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45719] = 1,    -- Orgrimmar Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45719] = 1,    -- Orgrimmar Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70149] = 1,    -- Orgrimmar Writ of Commendation
            },
        },
        
        -- AV turnins
        AV_RiderHarnesses = {
            value = 10,
            items = {
                [17642] = 1,    -- Alterac Ram Hide
            },
        },
        AV_BossSummon_5 = {
            value = 50,
            items = {
                [17306] = 5,    -- Stormpike Soldier's Blood
            },
        },
        AV_BossSummon_1 = {
            value = 10,
            items = {
                [17306] = 1,    -- Stormpike Soldier's Blood
            },
        },
        AV_ArmorScraps = {
            value = 10,
            items = {
                [17422] = 20,   -- Armor Scraps
            },
        },
        AV_3rdAirstrike = {
            value = 10,
            items = {
                [17328] = 1,    -- Stormpike Commander's Flesh
            },
        },
        AV_2ndAirstrike = {
            value = 10,
            items = {
                [17327] = 1,    -- Stormpike Lieutenant's Flesh
            },
        },
        AV_1stAirstrike = {
            value = 10,
            items = {
                [17326] = 1,    -- Stormpike Soldier's Flesh
            },
        },
    },
    
    -- Racial factions: Alliance
    [F.NELF] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45714] = 1,    -- Darnassus Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45714] = 1,    -- Darnassus Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70145] = 1,    -- Darnassus Writ of Commendation
            },
        },
    },
    [F.GNOME] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45716] = 1,    -- Gnomeregan Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45716] = 1,    -- Gnomeregan Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70147] = 1,    -- Gnomeregan Writ of Commendation
            },
        },
    },
    [F.HUMAN] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45718] = 1,    -- Stormwind Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45718] = 1,    -- Stormwind Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70152] = 1,    -- Stormwind Writ of Commendation
            },
        },
    },
    [F.DWARF] = {
        -- Argent Tournament vendor (not really a quest, but it works here)
        ChampionWrit = {
            creates = {
                [45717] = 1,    -- Ironforge Commendation Badge
            },
            value = 0,
            buyValue = 250,
            items = {
                [46114] = 1,    -- Champion's Writ
            },
        },
        A_CommendationBadge = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [45717] = 1,    -- Ironforge Commendation Badge
            },
        },
        -- Molten Front vendor (not really a quest, but it works here)
        A_CommendationWrit = {
            value = 250,
            useItem = 1,
            purchased = 1,
            items = {
                [70148] = 1,    -- Ironforge Writ of Commendation
            },
        },

        -- AV turnins
        AV_RiderHarnesses = {
            value = 10,
            items = {
                [17643] = 1,    -- Frostwolf Hide
            },
        },
        AV_BossSummon_5 = {
            value = 50,
            items = {
                [17423] = 5,    -- Storm Crystal
            },
        },
        AV_BossSummon_1 = {
            value = 10,
            items = {
                [17423] = 1,    -- Storm Crystal
            },
        },
        AV_ArmorScraps = {
            value = 10,
            items = {
                [17422] = 20,   -- Armor Scraps
            },
        },
        AV_3rdAirstrike = {
            value = 10,
            items = {
                [17504] = 1,    -- Frostwolf Commander's Medal
            },
        },
        AV_2ndAirstrike = {
            value = 10,
            items = {
                [17503] = 1,    -- Frostwolf Lieutenant's Medal
            },
        },
        AV_1stAirstrike = {
            value = 10,
            items = {
                [17502] = 1,    -- Frostwolf Soldier's Medal
            },
        },
    },
    
    -- Battleground factions
    [F.FROSTWOLF] = {
        AV_RiderHarnesses = {
            value = 1,
            items = {
                [17642] = 1,    -- Alterac Ram Hide
            },
        },
        AV_BossSummon_5 = {
            value = 5,
            items = {
                [17306] = 5,    -- Stormpike Soldier's Blood
            },
        },
        AV_BossSummon_1 = {
            value = 1,
            items = {
                [17306] = 1,    -- Stormpike Soldier's Blood
            },
        },
        AV_ArmorScraps = {
            value = 1,
            items = {
                [17422] = 20,   -- Armor Scraps
            },
        },
        AV_3rdAirstrike = {
            value = 3,
            items = {
                [17328] = 1,    -- Stormpike Commander's Flesh
            },
        },
        AV_2ndAirstrike = {
            value = 2,
            items = {
                [17327] = 1,    -- Stormpike Lieutenant's Flesh
            },
        },
        AV_1stAirstrike = {
            value = 1,
            items = {
                [17326] = 1,    -- Stormpike Soldier's Flesh
            },
        },
    },
    [F.STORMPIKE] = {
        AV_RiderHarnesses = {
            value = 1,
            items = {
                [17643] = 1,    -- Frostwolf Hide
            },
        },
        AV_BossSummon_5 = {
            value = 5,
            items = {
                [17423] = 5,    -- Storm Crystal
            },
        },
        AV_BossSummon_1 = {
            value = 1,
            items = {
                [17423] = 1,    -- Storm Crystal
            },
        },
        AV_ArmorScraps = {
            value = 1,
            items = {
                [17422] = 20,   -- Armor Scraps
            },
        },
        AV_3rdAirstrike = {
            value = 3,
            items = {
                [17504] = 1,    -- Frostwolf Commander's Medal
            },
        },
        AV_2ndAirstrike = {
            value = 2,
            items = {
                [17503] = 1,    -- Frostwolf Lieutenant's Medal
            },
        },
        AV_1stAirstrike = {
            value = 1,
            items = {
                [17502] = 1,    -- Frostwolf Soldier's Medal
            },
        },
    },

    -- Other factions
    [F.ZANDALAR] = {
        A_HonorTokens = {
            value = 50,
            useItem = 1,
            items = {
                [19858] = 1,    -- Zandalar Honor Token
            },
        },
        HakkariBijous = {
            value = 125,    -- Full reward, including Honor Token
            items = {
                [19707] = 1, -- Red
                [19708] = 1, -- Blue
                [19709] = 1, -- Yellow
                [19710] = 1, -- Orange
                [19711] = 1, -- Green
                [19712] = 1, -- Purple
                [19713] = 1, -- Bronze
                [19714] = 1, -- Silver
                [19715] = 1, -- Gold
            }
        }
    },
    [F.BROOD_NOZDORMU] = {
        MortalChampions = {
            value = 500,
            items = {
                [21229] = 1,    -- Qiraji Lord's Insignia
            },
        },
        SecretsOfTheQiraji = {
            value = 1000,
            items = {
                [21230] = 1,    -- Ancient Qiraji Artifact
            },
        },
        HandOfTheRighteous = {
            value = 500,
            maxStanding = 4, 
            items = {
                [20384] = 200,  -- Silithid Carapace Fragment
            },
        },
    },
    [F.CENARION_CIRCLE] = {
        _MortalChampions = {
            value = 200,
            items = {
                [21229] = 1,    -- Qiraji Lord's Insignia
            },
        },

        TwilightTexts = {
            value = 500,
            items = {
                [20404] = 10,   -- Encrypted Twilight Text
            },
        },

        Allegiance = {
            value = 200,
            items = {
                [20800] = 1,    -- Cenarion Logistics Badge
                [20801] = 1,    -- Cenarion Tactical Badge
                [20802] = 1,    -- Cenarion Combat Badge
            },
        },

        Abyssal3_Scepters = {
            value = 350,       
            items = {
                [20515] = 3,    -- Abyssal Scepter
            },
        },
        Abyssal2_Signets = {
            value = 250,
            items = {
                [20514] = 3,    -- Abyssal Signet
            },
        },
        Abyssal1_Crests = {
            value = 75,
            items = {
                [20513] = 3,    -- Abyssal Crest
            },
        },
    },
    [F.ARGENT_DAWN] = {
        A_ValorTokens = {
            value = 25,
            useItem = 1,
            items = {
                [12844] = 1,    -- Argent Dawn Valor Token
            },
        },
        Scourgestones = {
            value = 50,     -- Includes value of AD Valor Token use
            items = {
                [12843] = 1, -- Corruptor's Scourgestones
                [12841] = 5, -- Invader's Scourgestones
                [12840] = 20, -- Minion's Scourgestones
            }
        }
    },
    [F.TIMBERMAW] = {
        Totem_Winterfall = {
            value = 150,
            minStanding = 4, 
            items = {
                [20742] = 1,    -- Winterfall Ritual Totem
            },
        },
        Totem_Deadwood = {
            value = 150,
            minStanding = 4, 
            items = {
                [20741] = 1,    -- Deadwood Ritual Totem
            },
        },
        Feathers_Deadwood = {
            value = 50,
            items = {
                [21377] = 5,    -- Deadwood Headdress Feather
            },
        },
        Beads_Winterfall = {
            value = 50,
            items = {
                [21383] = 5,    -- Winterfall Spirit Beads
            },
        },
    },
    [F.THORIUM_BROTHERHOOD] = {
        DarkIronResidue = {
            value = 25,
            minStanding = 5,
            maxStanding = 7, 
            items = {
                [18945] = 4,    -- Dark Iron Residue
            },
        },
        DarkIronOre = {
            value = 50,
            items = {
                [11370] = 10,   -- Dark Iron Ore
            },
        },
        CoreLeather = {
            value = 150,
            items = {
                [17012] = 2,    -- Core Leather
            },
        },
        FieryCore = {
            value = 200,
            items = {
                [17010] = 1,    -- Fiery Core
            },
        },
        LavaCore = {
            value = 200,
            items = {
                [17011] = 1,    -- Lava Core
            },
        },
        BloodOfTheMountain = {
            value = 200,
            items = {
                [11382] = 1,    -- Blood of the Mountain
            },
        },
    },
    
};

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
-- Horde/Alliance racial factions   
	HORDE = 67,
		ORC = 76,
		TAUREN = 81,
		TROLL = 530,
		FORSAKEN = 68,
		BELF = 911,
		GOBLIN = 1133,
	ALLIANCE = 469,
		DWARF = 47,
		NELF = 69,
		GNOME = 54,
		HUMAN = 72,
		DRAENEI = 930,
		WORGEN = 1134,
-- Horde/Alliance Forces            
	FROSTWOLF = 729,
	DEFILERS = 510,
	WARSONG_OUTRIDERS = 889,
	STORMPIKE = 730,
	ARATHOR = 509,
	SILVERWING = 890,
                                    
-- Burning Crusade factions 	    
	TRANQUILLIEN = 922,
	CENARION_EXPEDITION = 942,
	SPOREGGAR = 970,
	KURENAI = 978,
	MAGHAR = 941,
	CONSORTIUM = 933,
	ALDOR = 932,
	SCRYER = 934,
	SHATAR = 935,
	LOWER_CITY = 1011,
	NETHERWING = 1015,
	SKYGUARD = 1031,
	HONOR_HOLD = 946,
	THRALLMAR = 947,
	KEEPERS_OF_TIME = 989,
	SCALE_SANDS = 990,
	SHATTERED_SUN = 1077,
	VIOLET_EYE = 967,
                                    
-- Wrath of the Lich King factions
	HORDE_EXPEDITION = 1052,
		HAND_VENGEANCE = 1067,
		TAUNKA = 1064,
		SUNREAVERS = 1124,
		WARSONG_OFFENSIVE = 1085,
	ALLIANCE_VANGUARD = 1037,
		EXPLORERS = 1068,
		FROSTBORN = 1126,
		SILVER_COVENANT = 1094,
		VALIANCE = 1050,
	SONS_HODIR = 1119,
	EBON_BLADE = 1098,
	ARGENT_CRUSADE = 1106,
	WYRMREST = 1091,
	KIRIN_TOR = 1090,
	ASHEN_VERDICT = 1156,
                                    
-- Cataclysm factions               
	RAMKAHEN = 1173,
	EARTHEN_RING = 1135,
	AVENGERS_HYJAL = 1204,
	GUARDIANS_HYJAL = 1158,
	THERAZANE = 1171,
	WILDHAMMER = 1174,
	DRAGONMAW = 1172,
	BARADIN = 1177,
	HELLSCREAM = 1178,
	
-- Mists of Pandaria factions
	HUOJIN = 1352,
	TUSHUI = 1353,
	ORDER_CLOUD_SERPENT = 1271,
	KLAXXI = 1337,
	GOLDEN_LOTUS = 1269,
	KIRIN_TOR_OFFENSIVE = 1387,
	SUNREAVER_ONSLAUGHT = 1388,
-- NPC friendships
	CHEE_CHEE = 1277,
	ELLA = 1275,
	FARMER_FUNG = 1283,
	FISH_FELLREED = 1282,
	GINA_MUDCLAW = 1281,
	HAOHAN_MUDCLAW = 1279,
	JOGU_THE_DRUNK = 1273,
	OLD_HILLPAW = 1276,
	SHO = 1278,
	TINA_MUDCLAW = 1280,
	
-- Warlords of Draenor factions
	STEAMWHEEDLE_SOCIETY = 1711,

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
		[ZONE_SOTA] = F.WARSONG_OFFENSIVE,
		
		-- BC zones/dungeons
		[ZONE_GHOSTLANDS] = F.TRANQUILLIEN,
		[ZONE_HELLFIRE_RAMPARTS] = F.THRALLMAR,
		[ZONE_BLOOD_FURNACE] = F.THRALLMAR,
		[ZONE_SHATTERED_HALLS] = F.THRALLMAR,
	},
	["Alliance"] = {
		[ZONE_AV] = F.STORMPIKE,
		[ZONE_AB] = F.ARATHOR,
		[ZONE_WSG] = F.SILVERWING,
		[ZONE_SOTA] = F.VALIANCE,

		-- BC zones/dungeons
		[ZONE_HELLFIRE_RAMPARTS] = F.HONOR_HOLD,
		[ZONE_BLOOD_FURNACE] = F.HONOR_HOLD,
		[ZONE_SHATTERED_HALLS] = F.HONOR_HOLD,
	},
	["Neutral"] = {
		[ZONE_SILITHUS] = F.CENARION_CIRCLE,
		[ZONE_AQ20] = F.CENARION_CIRCLE,
		[ZONE_AQ40] = F.BROOD_NOZDORMU,
		[ZONE_FELWOOD] = F.TIMBERMAW,
		[ZONE_WINTERSPRING] = F.TIMBERMAW,
		
		-- BC zones/dungeons
		[ZONE_ISLE_QUELDANAS] = F.SHATTERED_SUN,
		[ZONE_AUCHENAI_CRYPTS] = F.LOWER_CITY,
		[ZONE_MANA_TOMBS] = F.CONSORTIUM,
		[ZONE_SETHEKK_HALLS] = F.LOWER_CITY,
		[ZONE_SHADOW_LABYRINTH] = F.LOWER_CITY,
		[ZONE_OLD_HILLSBRAD] = F.KEEPERS_OF_TIME,
		[ZONE_BLACK_MORASS] = F.KEEPERS_OF_TIME,
		[ZONE_SLAVE_PENS] = F.CENARION_EXPEDITION,
		[ZONE_STEAMVAULT] = F.CENARION_EXPEDITION,
		[ZONE_UNDERBOG] = F.CENARION_EXPEDITION,
		[ZONE_MAGISTERS_TERRACE] = F.SHATTERED_SUN,
		[ZONE_ARCATRAZ] = F.SHATAR,
		[ZONE_BOTANICA] = F.SHATAR,
		[ZONE_MECHANAR] = F.SHATAR,
		[ZONE_KARAZHAN] = F.VIOLET_EYE,
		[ZONE_HYJAL_SUMMIT] = F.SCALE_SANDS,
		
		-- Wrath of the Lich King
		[ZONE_ICECROWN_CITADEL] = F.ASHEN_VERDICT,

		-- Warlords of Draenor
		[ZONE_FANGRILA] = F.SABERSTALKERS,
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
		[F.BELF] = 1,
		[F.GOBLIN] = 1,
		[F.HUOJIN] = 1,
		[F.FROSTWOLF] = 1,
		[F.MAGHAR] = 1,
		[F.TRANQUILLIEN] = 1,
		[F.WARSONG_OFFENSIVE] = 1,
		[F.DRAGONMAW] = 1,
		[F.HELLSCREAM] = 1,
		[F.SUNREAVER_ONSLAUGHT] = 1,
	},
	["Horde"] = {
		[F.HUMAN] = 1,
		[F.GNOME] = 1,
		[F.NELF] = 1,
		[F.DWARF] = 1,
		[F.DRAENEI] = 1,
		[F.WORGEN] = 1,
		[F.TUSHUI] = 1,
		[F.STORMPIKE] = 1,
		[F.KURENAI] = 1,
		[F.VALIANCE] = 1,
		[F.WILDHAMMER] = 1,
		[F.BARADIN] = 1,
		[F.KIRIN_TOR_OFFENSIVE] = 1,
	},
};

--[[ only used in disabled quest-rep scanning
-- TODO: autogenerate one or the other of these
FFF_FactionGroups = {
	[F.ORC]			= F.HORDE,
	[F.TROLL]		= F.HORDE,
	[F.TAUREN]		= F.HORDE,
	[F.FORSAKEN]	= F.HORDE,
	[F.BELF]		= F.HORDE,
	[F.GOBLIN]		= F.HORDE,
	[F.HUOJIN]		= F.HORDE,
	
	[F.HUMAN]	= F.ALLIANCE,
	[F.DWARF]	= F.ALLIANCE,
	[F.GNOME]	= F.ALLIANCE,
	[F.NELF]	= F.ALLIANCE,
	[F.DRAENEI]	= F.ALLIANCE,
	[F.WORGEN]	= F.ALLIANCE,
	[F.TUSHUI]	= F.ALLIANCE,
	
	[F.HAND_VENGEANCE]		= F.HORDE_EXPEDITION,
	[F.TAUNKA]				= F.HORDE_EXPEDITION,
	[F.SUNREAVERS]			= F.HORDE_EXPEDITION,
	[F.WARSONG_OFFENSIVE]	= F.HORDE_EXPEDITION,

	[F.EXPLORERS]		= F.ALLIANCE_VANGUARD,
	[F.FROSTBORN]		= F.ALLIANCE_VANGUARD,
	[F.SILVER_COVENANT]	= F.ALLIANCE_VANGUARD,
	[F.VALIANCE]		= F.ALLIANCE_VANGUARD,
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
-- For tabard-based switching
------------------------------------------------------
FFF_TabardFactions = {
	-- Northrend
	[43154]	= F.ARGENT_CRUSADE,
	[43155]	= F.EBON_BLADE,
	[43156]	= F.WYRMREST,
	[43157]	= F.KIRIN_TOR,
	-- Cataclysm
	[65904]	= F.RAMKAHEN,
	[65905]	= F.EARTHEN_RING,
	[65906]	= F.GUARDIANS_HYJAL,
	[65907]	= F.THERAZANE,
	[65908]	= F.WILDHAMMER,
	[65909]	= F.DRAGONMAW,
	-- Racial (Horde)
	[45581]	= F.ORC,
	[45582]	= F.TROLL,
	[45584]	= F.TAUREN,
	[45583]	= F.FORSAKEN,
	[45585]	= F.BELF,
	[64884]	= F.GOBLIN,
	[83080]	= F.HUOJIN,
	-- Racial (Alliance)
	[45574]	= F.HUMAN,
	[45577]	= F.DWARF,
	[45578]	= F.GNOME,
	[45579]	= F.NELF,
	[45580]	= F.DRAENEI,
	[64882]	= F.WORGEN,
	[83079]	= F.TUSHUI,
};

------------------------------------------------------
-- Localized item names for "created" items, since they can appear without being cached by client
------------------------------------------------------
FFF_SpecialItems = {
	-- vanilla; no longer obtainable
	[12844] = FFF_ITEM_AD_TOKEN,
	[19858] = FFF_ITEM_ZG_TOKEN,
	
	-- racial factions; purchased with champion's writ at argent tournament
	[45714] = FFF_ITEM_NELF_BADGE,
	[45715] = FFF_ITEM_DRAENEI_BADGE,
	[45716] = FFF_ITEM_GNOME_BADGE,
	[45717] = FFF_ITEM_DWARF_BADGE,
	[45718] = FFF_ITEM_HUMAN_BADGE,
	[45719] = FFF_ITEM_ORC_BADGE,
	[45720] = FFF_ITEM_TROLL_BADGE,
	[45721] = FFF_ITEM_BELF_BADGE,
	[45722] = FFF_ITEM_TAUREN_BADGE,
	[45723] = FFF_ITEM_FORSAKEN_BADGE,
	
	-- cata tol barad factions; purchase with tol barad commendations
	[63517] = FFF_ITEM_BARADIN_COMMENDATION,
	[63518] = FFF_ITEM_HELLSCREAM_COMMENDATION,
	
	-- racial factions; purchase with marks of the world tree at molten front
	[70145] = FFF_ITEM_NELF_WRIT,
	[70146] = FFF_ITEM_DRAENEI_WRIT,
	[70147] = FFF_ITEM_GNOME_WRIT,
	[70148] = FFF_ITEM_DWARF_WRIT,
	[70149] = FFF_ITEM_ORC_WRIT,
	[70150] = FFF_ITEM_TROLL_WRIT,
	[70151] = FFF_ITEM_BELF_WRIT,
	[70152] = FFF_ITEM_HUMAN_WRIT,
	[70153] = FFF_ITEM_TAUREN_WRIT,
	[70154] = FFF_ITEM_FORSAKEN_WRIT,
	[71087] = FFF_ITEM_WORGEN_WRIT,
	[71088] = FFF_ITEM_GOBLIN_WRIT,
	
	-- mists isle of thunder factions; purchase with tattered historical parchments
	[95487] = FFF_SUNREAVER_ONSLAUGHT_INSIGNIA, 
	[95488] = FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER, 
	[95489] = FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA, 
	[95490] = FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER, 
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
				[45722] = 1,	-- Thunder Bluff Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45722] = 1,	-- Thunder Bluff Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70153] = 1,	-- Thunder Bluff Writ of Commendation
			},
		},
	},
	[F.TROLL] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45720] = 1,	-- Sen'jin Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45720] = 1,	-- Sen'jin Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70150] = 1,	-- Sen'jin Writ of Commendation
			},
		},
	},
	[F.FORSAKEN] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45723] = 1,	-- Undercity Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45723] = 1,	-- Undercity Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70154] = 1,	-- Undercity Writ of Commendation
			},
		},
	},
	[F.BELF] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45721] = 1,	-- Silvermoon Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45721] = 1,	-- Silvermoon Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70151] = 1,	-- Silvermoon Writ of Commendation
			},
		},
	},
	[F.ORC] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45719] = 1,	-- Orgrimmar Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45719] = 1,	-- Orgrimmar Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70149] = 1,	-- Orgrimmar Writ of Commendation
			},
		},
		
		-- AV turnins
		AV_RiderHarnesses = {
			value = 10,
			items = {
				[17642] = 1,	-- Alterac Ram Hide
			},
		},
		AV_BossSummon_5 = {
			value = 50,
			items = {
				[17306] = 5,	-- Stormpike Soldier's Blood
			},
		},
		AV_BossSummon_1 = {
			value = 10,
			items = {
				[17306] = 1,	-- Stormpike Soldier's Blood
			},
		},
		AV_ArmorScraps = {
			value = 10,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		AV_3rdAirstrike = {
			value = 10,
			items = {
				[17328] = 1,	-- Stormpike Commander's Flesh
			},
		},
		AV_2ndAirstrike = {
			value = 10,
			items = {
				[17327] = 1,	-- Stormpike Lieutenant's Flesh
			},
		},
		AV_1stAirstrike = {
			value = 10,
			items = {
				[17326] = 1,	-- Stormpike Soldier's Flesh
			},
		},
	},
	[F.GOBLIN] = {
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[71088] = 1,	-- Bilgewater Writ of Commendation
			},
		},
	},
	
	-- Racial factions: Alliance
	[F.NELF] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45714] = 1,	-- Darnassus Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45714] = 1,	-- Darnassus Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70145] = 1,	-- Darnassus Writ of Commendation
			},
		},
	},
	[F.GNOME] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45716] = 1,	-- Gnomeregan Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45716] = 1,	-- Gnomeregan Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70147] = 1,	-- Gnomeregan Writ of Commendation
			},
		},
	},
	[F.HUMAN] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45718] = 1,	-- Stormwind Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45718] = 1,	-- Stormwind Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70152] = 1,	-- Stormwind Writ of Commendation
			},
		},
	},
	[F.DRAENEI] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45715] = 1,	-- Exodar Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45715] = 1,	-- Exodar Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70146] = 1,	-- Exodar Writ of Commendation
			},
		},
	},
	[F.DWARF] = {
		-- Argent Tournament vendor (not really a quest, but it works here)
		ChampionWrit = {
			creates = {
				[45717] = 1,	-- Ironforge Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45717] = 1,	-- Ironforge Commendation Badge
			},
		},
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70148] = 1,	-- Ironforge Writ of Commendation
			},
		},

		-- AV turnins
		AV_RiderHarnesses = {
			value = 10,
			items = {
				[17643] = 1,	-- Frostwolf Hide
			},
		},
		AV_BossSummon_5 = {
			value = 50,
			items = {
				[17423] = 5,	-- Storm Crystal
			},
		},
		AV_BossSummon_1 = {
			value = 10,
			items = {
				[17423] = 1,	-- Storm Crystal
			},
		},
		AV_ArmorScraps = {
			value = 10,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		AV_3rdAirstrike = {
			value = 10,
			items = {
				[17504] = 1,	-- Frostwolf Commander's Medal
			},
		},
		AV_2ndAirstrike = {
			value = 10,
			items = {
				[17503] = 1,	-- Frostwolf Lieutenant's Medal
			},
		},
		AV_1stAirstrike = {
			value = 10,
			items = {
				[17502] = 1,	-- Frostwolf Soldier's Medal
			},
		},
	},
	[F.WORGEN] = {
		-- Molten Front vendor (not really a quest, but it works here)
		A_CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[71087] = 1,	-- Gilneas Writ of Commendation
			},
		},
	},
	
	-- Battleground factions
	[F.FROSTWOLF] = {
		AV_RiderHarnesses = {
			value = 1,
			items = {
				[17642] = 1,	-- Alterac Ram Hide
			},
		},
		AV_BossSummon_5 = {
			value = 5,
			items = {
				[17306] = 5,	-- Stormpike Soldier's Blood
			},
		},
		AV_BossSummon_1 = {
			value = 1,
			items = {
				[17306] = 1,	-- Stormpike Soldier's Blood
			},
		},
		AV_ArmorScraps = {
			value = 1,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		AV_3rdAirstrike = {
			value = 3,
			items = {
				[17328] = 1,	-- Stormpike Commander's Flesh
			},
		},
		AV_2ndAirstrike = {
			value = 2,
			items = {
				[17327] = 1,	-- Stormpike Lieutenant's Flesh
			},
		},
		AV_1stAirstrike = {
			value = 1,
			items = {
				[17326] = 1,	-- Stormpike Soldier's Flesh
			},
		},
	},
	[F.STORMPIKE] = {
		AV_RiderHarnesses = {
			value = 1,
			items = {
				[17643] = 1,	-- Frostwolf Hide
			},
		},
		AV_BossSummon_5 = {
			value = 5,
			items = {
				[17423] = 5,	-- Storm Crystal
			},
		},
		AV_BossSummon_1 = {
			value = 1,
			items = {
				[17423] = 1,	-- Storm Crystal
			},
		},
		AV_ArmorScraps = {
			value = 1,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		AV_3rdAirstrike = {
			value = 3,
			items = {
				[17504] = 1,	-- Frostwolf Commander's Medal
			},
		},
		AV_2ndAirstrike = {
			value = 2,
			items = {
				[17503] = 1,	-- Frostwolf Lieutenant's Medal
			},
		},
		AV_1stAirstrike = {
			value = 1,
			items = {
				[17502] = 1,	-- Frostwolf Soldier's Medal
			},
		},
	},

	-- Other factions
	[F.ZANDALAR] = {
		A_HonorTokens = {
			value = 50,
			useItem = 1,
			items = {
				[19858] = 1,	-- Zandalar Honor Token
			},
		},
	},
	[F.BROOD_NOZDORMU] = {
		MortalChampions = {
			value = 500,
			items = {
				[21229] = 1,	-- Qiraji Lord's Insignia
			},
		},
		SecretsOfTheQiraji = {
			value = 1000,
			items = {
				[21230] = 1,	-- Ancient Qiraji Artifact
			},
		},
		HandOfTheRighteous = {
			value = 500,
			maxStanding = 4, 
			items = {
				[20384] = 200,	-- Silithid Carapace Fragment
			},
		},
	},
	[F.CENARION_CIRCLE] = {
		_MortalChampions = {
			value = 500,
			items = {
				[21229] = 1,	-- Qiraji Lord's Insignia
			},
		},

		TwilightTexts = {
			value = 500,
			items = {
				[20404] = 10,	-- Encrypted Twilight Text
			},
		},

		Allegiance = {
			value = 1000,
			items = {
				[20800] = 1,	-- Cenarion Logistics Badge
				[20801] = 1,	-- Cenarion Tactical Badge
				[20802] = 1,	-- Cenarion Combat Badge
			},
		},

		Abyssal3_Scepters = {
			value = 1000,		
			items = {
				[20515] = 3,	-- Abyssal Scepter
			},
		},
		Abyssal2_Signets = {
			value = 500,
			items = {
				[20514] = 3,	-- Abyssal Signet
			},
		},
		Abyssal1_Crests = {
			value = 150,
			items = {
				[20513] = 3,	-- Abyssal Crest
			},
		},
	},
	[F.ARGENT_DAWN] = {
		A_ValorTokens = {
			value = 100,
			useItem = 1,
			items = {
				[12844] = 1,	-- Argent Dawn Valor Token
			},
		},
	},
	[F.TIMBERMAW] = {
		Totem_Winterfall = {
			value = 1400,
			minStanding = 4, 
			items = {
				[20742] = 1,	-- Winterfall Ritual Totem
			},
		},
		Totem_Deadwood = {
			value = 1400,
			minStanding = 4, 
			items = {
				[20741] = 1,	-- Deadwood Ritual Totem
			},
		},
		Feathers_Deadwood = {
			value = 2000,
			items = {
				[21377] = 5,	-- Deadwood Headdress Feather
			},
		},
		Beads_Winterfall = {
			value = 2000,
			items = {
				[21383] = 5,	-- Winterfall Spirit Beads
			},
		},
	},
	[F.THORIUM_BROTHERHOOD] = {
		DarkIronResidue = {
			value = 60,
			minStanding = 5,
			maxStanding = 7, 
			items = {
				[18945] = 4,	-- Dark Iron Residue
			},
		},
		DarkIronOre = {
			value = 300,
			items = {
				[11370] = 10,	-- Dark Iron Ore
			},
		},
		CoreLeather = {
			value = 1400,
			items = {
				[17012] = 2,	-- Core Leather
			},
		},
		FieryCore = {
			value = 2000,
			items = {
				[17010] = 1,	-- Fiery Core
			},
		},
		LavaCore = {
			value = 2000,
			items = {
				[17011] = 1,	-- Lava Core
			},
		},
		BloodOfTheMountain = {
			value = 2000,
			items = {
				[11382] = 1,	-- Blood of the Mountain
			},
		},
	},

	-- Burning Crusade factions
	[F.CONSORTIUM] = {
		Prisons2_AThousandWorlds = {
			value = 500,
			minStanding = 7, 
			items = {
				[29460] = 5,	-- Ethereum Prison Key
			},
		},
		Prisons1_EthereumSecrets = {
			value = 250,
			minStanding = 6, 
			items = {
				[31957] = 1,	-- Ethereum Prisoner I.D. Tag
			},
		},
		Netherstorm_HeapOfEtherials = {
			value = 250,
			minStanding = 5, 
			items = {
				[29209] = 10,	-- Zaxxis Insignia
			},
		},
		Nagrand_Warbeads = {
			value = 250,
			minStanding = 5, 
			items = {
				[25433] = 10,	-- Obsidian Warbeads
			},
		},
		IvoryTusks = {
			value = 250,
			minStanding = 4, 
			maxStanding = 4, 
			items = {
				[25463] = 3,	-- Pair of Ivory Tusks
			},
		},
		CrystalFragments = {
			value = 250,
			minStanding = 4, 
			maxStanding = 4, 
			items = {
				[25416] = 10,	-- Oshu'gun Crystal Fragment
			},
		},
	},
	[F.MAGHAR] = {
		Warbeads = {
			value = 500,
			minStanding = 4, 
			items = {
				[25433] = 10,	-- Obsidian Warbeads
			},
		},
	},
	[F.KURENAI] = {
		Warbeads = {
			value = 500,
			minStanding = 4, 
			items = {
				[25433] = 10,	-- Obsidian Warbeads
			},
		},
	},
	[F.CENARION_EXPEDITION] = {
		Junk_IdentifyPlantParts = {
			value = 250,
			minStanding = 4, 
			maxStanding = 5, 
			items = {
				[24401] = 10,	-- Unidentified Plant Parts
			},
		},
		Junk_UncataloguedSpecies = {
			value = 500,
			minStanding = 4, 
			items = {
				[24407] = 1,	-- Uncatalogued Species
			},
		},
		--[[
		CoilfangArmaments = {
			value = 75,
			minStanding = 4, 
			items = {
				[24368] = 1,	-- Coilfang Armaments
			},
		},
		]]
		CantGetEarnough = {
			value = 150,
			minStanding = 4, 
			items = {
				[35188] = 15,	-- Nesingwary Lackey Ear
			},
		},
	},
	[F.SPOREGGAR] = {
		Part3_BringMeAShrubbery = {
			value = 750,
			minStanding = 5, 
			items = {
				[24246] = 5,	-- Sanguine Hibiscus
			},
		},
		Part2_Glowcaps = {
			value = 750,
			minStanding = 4, 
			maxStanding = 4, 
			items = {
				[24245] = 10,	-- Glowcap
			},
		},
		Part2_FertileSpores = {
			value = 750,
			minStanding = 4, 
			items = {
				[24449] = 6,	-- Fertile Spores
			},
		},
		Part1_Tendrils = {
			value = 750,
			maxStanding = 4, 
			items = {
				[24291] = 6,	-- Bog Lord Tendril
			},
		},
		Part1_SporeSacs = {
			value = 750,
			maxStanding = 4, 
			items = {
				[24290] = 10,	-- Mature Spore Sac
			},
		},
	},
	[F.ALDOR] = {
		Unfriendly_VenomSacs = {
			value = 250,
			maxStanding = 3, 
			items = {
				[25802] = 8,	-- Dreadfang Venom Sac
			},
		},
		MarksOfSargeras_10 = {
			value = 250,
			minStanding = 5, 
			items = {
				[30809] = 10,	-- Mark of Sargeras
			},
		},
		MarksOfSargeras_01 = {
			value = 25,
			minStanding = 5, 
			items = {
				[30809] = 1,	-- Mark of Sargeras
			},
		},
		MarksOfKiljaeden_10 = {
			value = 250,
			minStanding = 4, 
			maxStanding = 5,
			items = {
				[29425] = 10,	-- Mark of Kil'jaeden
			},
		},
		MarksOfKiljaeden_01 = {
			value = 25,
			minStanding = 4,
			maxStanding = 5,
			items = {
				[29425] = 1,	-- Mark of Kil'jaeden
			},
		},
		FelArmament = {
			value = 350,
			minStanding = 5, 
			items = {
				[29740] = 1,	-- Fel Armament
			},
		},
	},
	[F.SCRYER] = {
		Unfriendly_BasiliskEyes = {
			value = 250,
			maxStanding = 3, 
			items = {
				[25744] = 8,	-- Dampscale Basilisk Eye
			},
		},		
		SunfurySignet_10 = {
			value = 250,
			minStanding = 5, 
			items = {
				[30810] = 10,	-- Sunfury Signet
			},
		},
		SunfurySignet_01 = {
			value = 25,
			minStanding = 5, 
			items = {
				[30810] = 1,	-- Sunfury Signet
			},
		},
		FirewingSignet_10 = {
			value = 250,
			minStanding = 4, 
			maxStanding = 5,
			items = {
				[29426] = 10,	-- Firewing Signet
			},
		},
		FirewingSignet_01 = {
			value = 25,
			minStanding = 4, 
			maxStanding = 5,
			items = {
				[29426] = 1,	-- Firewing Signet
			},
		},
		ArcaneTome = {
			value = 350,
			minStanding = 5, 
			items = {
				[29739] = 1,	-- Arcane Tome
			},
		},
	},
	[F.LOWER_CITY] = {
		ArakkoaFeathers = {
			value = 250,
			minStanding = 4, 
			maxStanding = 5, 
			items = {
				[25719] = 30,	-- Arakkoa Feather
			},
		},
	},
	[F.NETHERWING] = {
		GreatEggHunt = {
			value = 250,
			minStanding = 4, 
			items = {
				[32506] = 1,	-- Netherwing Egg
			},
		},
	},
	[F.SKYGUARD] = {
		ElixirOfShadows = {
			value = 150,
			minStanding = 4, 
			items = {
				[32388] = 6,	-- Shadow Dust
			},
		},
	},
	[F.SHATAR] = {
		Scryer_ArcaneTome = {
			value = 175,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.SCRYER,
				minStanding = 5,
			},
			items = {
				[29739] = 1,	-- Arcane Tome
			},
		},
		Scryer_SunfurySignet_10 = {
			value = 125,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.SCRYER,
				minStanding = 5,
			},
			items = {
				[30810] = 10,	-- Sunfury Signet
			},
		},
		Scryer_FirewingSignet_10 = {
			value = 125,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.SCRYER,
				minStanding = 4, 
				maxStanding = 5,
			},
			items = {
				[29426] = 10,	-- Firewing Signet
			},
		},

		Aldor_FelArmament = {
			value = 175,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.ALDOR,
				minStanding = 5,
			},
			items = {
				[29740] = 1,	-- Fel Armament
			},
		},
		Aldor_MarksOfSargeras_10 = {
			value = 125,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.ALDOR,
				minStanding = 5,
			},
			items = {
				[30809] = 10,	-- Mark of Sargeras
			},
		},
		Aldor_MarksOfKiljaeden_10 = {
			value = 125,
			maxStanding = 5,
			otherFactionRequired = {
				faction = F.ALDOR,
				minStanding = 4, 
				maxStanding = 5,
			},
			items = {
				[29425] = 10,	-- Mark of Kil'jaeden
			},
		},
	},

	-- Wrath of the Lich King factions
	[F.SONS_HODIR] = {
		Everfrost = {
			value = 455,
			minStanding = 5, 
			items = {
				[44724] = 1,	-- Everfrost Chip
			},
		},
		HodirsTribute = {
			value = 650,
			minStanding = 4,
			items = {
				[42780] = 10,	-- Relic of Ulduar
			},
		},
	},
	[F.EBON_BLADE] = {
		ReadingTheBones = {
			value = 10,
			minStanding = 4,	-- needs verifying 
			items = {
				[43089] = 15,	-- Vrykul Bones
			},
		},
	},

	-- Cataclysm factions
	[F.BARADIN] = {
		-- vendors (not really a quest, but it works here)
		TolBaradCommendations = {
			creates = {
				[63517] = 1,	-- Baradin's Wardens Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:391"] = 16,		-- Tol Barad Commendations
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[63517] = 1,	-- Baradin's Wardens Commendation
			},
		},
	},
	[F.HELLSCREAM] = {
		-- vendors (not really a quest, but it works here)
		TolBaradCommendations = {
			creates = {
				[63518] = 1,	-- Hellscream's Reach Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:391"] = 16,		-- Tol Barad Commendations
			},
		},
		A_CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[63518] = 1,	-- Hellscream's Reach Commendation
			},
		},
	},
	
	-- Mists of Pandaria factions
	[F.ORDER_CLOUD_SERPENT] = {
		OnyxToGoodness = {
			value = 500,
			minStanding = 4, 
			items = {
				[89155] = 1,	-- Onyx Egg
			},
		},
	},
	[F.KLAXXI] = {
		SeedsOfFear = {
			value = 250,
			minStanding = 4, 
			items = {
				[87903] = 5,	-- Dread Amber Shards
			},
		},
	},
	[F.GOLDEN_LOTUS] = {
		RelicThunderKing = {
			value = 350,
			useItem = 1,
			items = {
				[90816] = 1,	-- Relic of the Thunder King
			},
		},	
		RelicGuoLai = {
			value = 150,
			useItem = 1,
			items = {
				[90815] = 1,	-- Relic of Guo-Lai
			},
		},	
	},

	[F.CHEE_CHEE] = {
		BlueFeather	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79265] = 1,	-- Blue Feather
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74647] = 5,	-- Valley Stir Fry
			},
		},
	},
	[F.OLD_HILLPAW] = {
		BlueFeather	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79265] = 1,	-- Blue Feather
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74649] = 5,	-- Braised Turtle
			},
		},
	},
	[F.ELLA] = {
		JadeCat	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79266] = 1,	-- Jade Cat
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74651] = 5,	-- Shrimp Dumplings
			},
		},
	},
	[F.FISH_FELLREED] = {
		JadeCat	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79266] = 1,	-- Jade Cat
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74655] = 5,	-- Twin Fish Platter
			},
		},
	},
	[F.FARMER_FUNG] = {
		MarshLily	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79268] = 1,	-- Marsh Lily
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74654] = 5,	-- Wildfowl Roast
			},
		},
	},
	[F.GINA_MUDCLAW] = {
		MarshLily	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79268] = 1,	-- Marsh Lily
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74644] = 5,	-- Swirling Mist Soup
			},
		},
	},
	[F.HAOHAN_MUDCLAW] = {
		RubyShard	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79264] = 1,	-- Ruby Shard
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74642] = 5,	-- Charbroiled Tiger Steak
			},
		},
	},
	[F.TINA_MUDCLAW] = {
		RubyShard	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79264] = 1,	-- Ruby Shard
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74652] = 5,	-- Fire Spirit Salmon
			},
		},
	},
	[F.JOGU_THE_DRUNK] = {
		LovelyApple	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79267] = 1,	-- Lovely Apple
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74643] = 5,	-- Sauteed Carrots
			},
		},
	},
	[F.SHO] = {
		LovelyApple	 = {
			value = 900,
			minStanding = 4, 
			items = {
				[79267] = 1,	-- Lovely Apple
			},
		},
		Food	 = {
			value = 1800,
			minStanding = 4, 
			items = {
				[74645] = 5,	-- Eternal Blossom Fish
			},
		},
	},

	[F.SUNREAVER_ONSLAUGHT] = {
		-- vendors (not really a quest, but it works here)
		TatteredDocs_01 = {
			creates = {
				[95487] = 1,	-- Sunreaver Onslaught Insignia
			},
			value = 0,
			buyValue = 25,
			items = {
				[95491] = 1,		-- Tattered Historical Parchments
			},
		},
		A_Insignia = {
			value = 25,
			useItem = 1,
			purchased = 1,
			items = {
				[95487] = 1,	-- Sunreaver Onslaught Insignia
			},
		},
		TatteredDocs_10 = {
			creates = {
				[95488] = 1,	-- Greater Sunreaver Onslaught Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				[95491] = 10,		-- Tattered Historical Parchments
			},
		},
		A_InsigniaGreater = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[95488] = 1,	-- Greater Sunreaver Onslaught Insignia
			},
		},
	},
	[F.KIRIN_TOR_OFFENSIVE] = {
		-- vendors (not really a quest, but it works here)
		TatteredDocs_01 = {
			creates = {
				[95489] = 1,	-- Kirin Tor Offensive Insignia
			},
			value = 0,
			buyValue = 25,
			items = {
				[95491] = 1,		-- Tattered Historical Parchments
			},
		},
		A_Insignia = {
			value = 25,
			useItem = 1,
			purchased = 1,
			items = {
				[95489] = 1,	-- Kirin Tor Offensive Insignia
			},
		},
		TatteredDocs_10 = {
			creates = {
				[95490] = 1,	-- Greater Kirin Tor Offensive Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				[95491] = 10,		-- Tattered Historical Parchments
			},
		},
		A_InsigniaGreater = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[95490] = 1,	-- Greater Kirin Tor Offensive Insignia
			},
		},
	},

	-- Warlords of Draenor factions
	[F.STEAMWHEEDLE_SOCIETY] = {
		ARareFind = {
			value = 250,
			minStanding = 4,	-- needs verifying 
			items = {
				[118100] = 1,	-- Highmaul Relic
			},
		},
		FragmentsOfThePast = {
			value = 250,
			minStanding = 4,	-- needs verifying 
			items = {
				[118099] = 20,	-- Gorian Artifact Fragment
			},
		},

		AogexonsFang = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118654] = 1,	-- Aogexon's Fang
			},
		},
		BergruusHorn = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118655] = 1,	-- Bergruu's Horn
			},
		},
		DekorhansTusk = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118656] = 1,	-- Dekorhan's Tusk
			},
		},
		DirehoofsHide = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118657] = 1,	-- Direhoof's Hide
			},
		},
		GagrogsSkull = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118658] = 1,	-- Gagrog's Skull
			},
		},
		MugrasHead = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118659] = 1,	-- Mu'gra's Head
			},
		},
		ThektalonsTalon = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118660] = 1,	-- Thek'talon's Talon
			},
		},
		XelganaksStinger = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[118661] = 1,	-- Xelganak's Stinger
			},
		},
		VileclawsClaw = {
			value = 500,
			minStanding = 4,	-- needs verifying 
			items = {
				[120172] = 1,	-- Vileclaw's Claw
			},
		},
	},
};




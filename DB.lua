------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, T = ...
_G[addonName.."_DB"] = {}
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------
local F = {
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
	SHADOPAN = 1270,
	AUGUST_CELESTIALS = 1341,
	TILLERS = 1272,
	DOMINANCE_OFFENSIVE = 1375,
	OPERATION_SHIELDWALL = 1376,
	SHADOPAN_ASSAULT = 1435,
	ANGLERS = 1302,
	EMPEROR_SHAOHAO = 1492,
	
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
	ARAKKOA_OUTCASTS = 1515,
	AWAKENED_ORDER = 1849,
	SABERSTALKERS = 1850,
	NAT_PAGLE_GARRISON = 1358,
	
	-- Horde
	VOLJIN_HEADHUNTERS = 1848,
	VOLJINS_SPEAR = 1681,
	FROSTWOLF_ORCS = 1445,
	LAUGHING_SKULL = 1708,
	-- Alliance
	EXARCHS_COUNCIL = 1731,
	PROPHET_HAND = 1847,
	SHATARI_DEFENSE = 1710,
	WRYNNS_VANGUARD = 1682,

-- Legion factions
	HIGHMOUNTAIN_TRIBE = 1828,
	NIGHTFALLEN = 1859,
	DREAMWEAVERS = 1883,
	WARDENS = 1894,
	FARONDIS_COURT = 1900,
	VALARJAR = 1948,
	CONJURER_MARGOSS = 1975,
	ARMIES_LEGIONFALL = 2045,
	
	FISHERFRIEND_ILYSSIA = 2097,
	FISHERFRIEND_RAYNAE = 2098,
	FISHERFRIEND_AKULE = 2099,
	FISHERFRIEND_CORBYN = 2100,
	FISHERFRIEND_SHALETH = 2101,
	FISHERFRIEND_IMPUS = 2102, 
}

------------------------------------------------------
-- For bodyguard switching option
------------------------------------------------------
DB.BodyguardFactionID = {
	[1739] = 1, -- Vivianne
	[1736] = 1, -- Tormmok
	[1737] = 1, -- Ishaal
	[1741] = 1, -- Leorajh
	[1733] = 1, -- Ironfist
	[1738] = 1, -- Illona
	[1740] = 1, -- Brightdawn
}

------------------------------------------------------
-- keeps Alliance/Horde-specific factions from showing up for opposing players
------------------------------------------------------
DB.ExcludedFactions = {
	Alliance = {
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
		[F.DOMINANCE_OFFENSIVE] = 1,
		[F.EXARCHS_COUNCIL] = 1,
		[F.PROPHET_HAND] = 1,
		[F.SHATARI_DEFENSE] = 1,
		[F.WRYNNS_VANGUARD] = 1,
	},
	Horde = {
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
		[F.OPERATION_SHIELDWALL] = 1,
		[F.VOLJINS_SPEAR] = 1,
		[F.VOLJIN_HEADHUNTERS] = 1,
		[F.FROSTWOLF_ORCS] = 1,
		[F.LAUGHING_SKULL] = 1,
	},
}

------------------------------------------------------
-- Localized item names for "created" items, since they can appear without being cached by client
------------------------------------------------------
FFF_SpecialItems = {
	-- vanilla no longer obtainable
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
DB.TurninsByQuest = {
	
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129945] = 1,	-- Commendation of the Consortium
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129945] = 1,	-- Commendation of the Consortium
			}
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
		CantGetEarnough = {
			value = 150,
			minStanding = 4, 
			items = {
				[35188] = 15,	-- Nesingwary Lackey Ear
			},
		},
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129949] = 1,	-- Commendation of Cenarion Expedition
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129949] = 1,	-- Commendation of Cenarion Expedition
			}
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
		PungentTruffle = {
			value = 15,
			items = {
				[144263] = 1, -- Pungent Truffle
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129951] = 1,	-- Commendation of Lower City
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129951] = 1,	-- Commendation of Lower City
			}
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

		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129946] = 1,	-- Commendation of The Sha'tar
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129946] = 1,	-- Commendation of The Sha'tar
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129943] = 1,	-- Commendation of the Sons of Hodir
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129943] = 1,	-- Commendation of the Sons of Hodir
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129941] = 1,	-- Commendation of The Ebonblade
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129941] = 1,	-- Commendation of The Ebonblade
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143942] = 1, -- Commendation of the Order of the Cloud Serpent
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143942] = 1, -- Commendation of the Order of the Cloud Serpent
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143935] = 1, -- Commendation of The Klaxxi
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143935] = 1, -- Commendation of The Klaxxi
			}
		},
		StolenInsignia = {
			value = 1000,
			items = {
				[94226] = 1, -- Stolen Klaxxi Insignia
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143937] = 1, -- Commendation of the Golden Lotus
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143937] = 1, -- Commendation of the Golden Lotus
			}
		},
		StolenInsignia = {
			value = 1000,
			items = {
				[94227] = 1, -- Stolen Golden Lotus Insignia
			}
		},
	},
	[F.SHADOPAN] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143936] = 1, -- Commendation of the Shado-Pan
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143936] = 1, -- Commendation of the Shado-Pan
			}
		},
		StolenInsignia = {
			value = 1000,
			items = {
				[94223] = 1, -- Stolen Shado-Pan Insignia
			}
		},
	},
	[F.AUGUST_CELESTIALS] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143938] = 1, -- Commendation of The August Celestials
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143938] = 1, -- Commendation of The August Celestials
			}
		},
		StolenInsignia = {
			value = 1000,
			items = {
				[94225] = 1, -- Stolen Celestial Insignia
			}
		},
	},
	[F.SHADOPAN_ASSAULT] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143945] = 1, -- Commendation of the Shado-Pan Assault
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143945] = 1, -- Commendation of the Shado-Pan Assault
			}
		},
		Insignia = {
			value = 1000,
			items = {
				[95496] = 1, -- Shado-Pan Assault Insignia
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143939] = 1, -- Commendation of the Sunreaver Onslaught
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[143939] = 1, -- Commendation of the Sunreaver Onslaught
			}
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
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143940] = 1, -- Commendation of the Kirin Tor Offensive
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[143940] = 1, -- Commendation of the Kirin Tor Offensive
			}
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
	[F.ARAKKOA_OUTCASTS] = {
		RelicRukhmar = {
			value = 2500,
			useItem = 1,
			items = {
				[117492] = 1, -- Relic of Rukhmar
			}
		},
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.AWAKENED_ORDER] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.SABERSTALKERS] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.NAT_PAGLE_GARRISON] = {
		AbyssalGulperLunker = {
			value = 350,
			items = {
				[116818] = 1, -- Abyssal Gulper Lunker
			}
		},
		BlackwaterWhiptailLunker = {
			value = 350,
			items = {
				[116817] = 1, -- Blackwater Whiptail Lunker
			}
		},
		BlindLakeLunker = {
			value = 350,
			items = {
				[116820] = 1, -- Blind Lake Lunker
			}
		},
		FatSleeperLunker = {
			value = 350,
			items = {
				[116821] = 1, -- Fat Sleeper Lunker
			}
		},
		FireAmmoniteLunker = {
			value = 350,
			items = {
				[116819] = 1, -- Fire Ammonite Lunker
			}
		},
		JawlessSkulkerLunker = {
			value = 350,
			items = {
				[116822] = 1, -- Jawless Skulker Lunker
			}
		},
		SeaScorpionLunker = {
			value = 350,
			items = {
				[122696] = 1, -- Sea Scorpion Lunker
			}
		},
		FelmouthFrenzyLunker = {
			value = 350,
			items = {
				[127994] = 1, -- Felmouth Frenzy Lunker
			}
		},
	},
	[F.VOLJIN_HEADHUNTERS] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.VOLJINS_SPEAR] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.FROSTWOLF_ORCS] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.LAUGHING_SKULL] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.EXARCHS_COUNCIL] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.PROPHET_HAND] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.SHATARI_DEFENSE] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},
	[F.WRYNNS_VANGUARD] = {
		MedallionOfLegion = {
			value = 1000,
			useItem = 1,
			items = {
				[128315] = 1, -- Medallion of the Legion
			}
		}
	},

	-- Legion factions
	[F.NIGHTFALLEN] = {
		ArcaneTablet = {
			value = 100,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141870] = 1, -- Arcane Tablet of Falanaar
			}
		},
		ArcaneRemnant = {
			value = 25,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[140260] = 1, -- Arcane Remnant of Falanaar
			}
		},
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139026] = 1, -- Nightfallen Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141343] = 1, -- Nightfallen Insignia
			}
		},
		InsigniaGreater = {
			value = 750,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141992] = 1, -- Greater Nightfallen Insignia
			}
		},
		Paragon_ArcaneTablet = {
			value = 100,
			useItem = 1,
			items = {
				[147416] = 1, -- Arcane Tablet of Falanaar
			}
		},
		Paragon_ArcaneRemnant = {
			value = 25,
			useItem = 1,
			items = {
				[147418] = 1, -- Arcane Remnant of Falanaar
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146940] = 1, -- Nightfallen Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146946] = 1, -- Nightfallen Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 750,
			useItem = 1,
			items = {
				[147413] = 1, -- Greater Nightfallen Insignia
			}
		},
	},
	[F.VALARJAR] = {
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139020] = 1, -- Valarjar Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141338] = 1, -- Valarjar Insignia
			}
		},
		InsigniaGreater = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141987] = 1, -- Greater Valarjar Insignia
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146935] = 1, -- Valarjar Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146941] = 1, -- Valarjar Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 1500,
			useItem = 1,
			items = {
				[147414] = 1, -- Greater Valarjar Insignia
			}
		},
	},
	[F.HIGHMOUNTAIN_TRIBE] = {
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139024] = 1, -- Highmountain Tribe Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141341] = 1, -- Highmountain Tribe Insignia
			}
		},
		InsigniaGreater = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141990] = 1, -- Greater Highmountain Tribe Insignia
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146938] = 1, -- Highmountain Tribe Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146944] = 1, -- Highmountain Tribe Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 1500,
			useItem = 1,
			items = {
				[147412] = 1, -- Greater Highmountain Tribe Insignia
			}
		},
	},
	[F.DREAMWEAVERS] = {
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139021] = 1, -- Dreamweaver Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141339] = 1, -- Dreamweaver Insignia
			}
		},
		InsigniaGreater = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141988] = 1, -- Greater Dreamweaver Insignia
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146936] = 1, -- Dreamweaver Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146942] = 1, -- Dreamweaver Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 1500,
			useItem = 1,
			items = {
				[147411] = 1, -- Greater Dreamweaver Insignia
			}
		},
	},
	[F.FARONDIS_COURT] = {
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139023] = 1, -- Court of Farondis Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141340] = 1, -- Court of Farondis Insignia
			}
		},
		InsigniaGreater = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141989] = 1, -- Greater Court of Farondis Insignia
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146937] = 1, -- Court of Farondis Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146943] = 1, -- Court of Farondis Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 1500,
			useItem = 1,
			items = {
				[147410] = 1, -- Greater Court of Farondis Insignia
			}
		},
	},
	[F.WARDENS] = {
		InsigniaBoP = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[139025] = 1, -- Wardens Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141342] = 1, -- Wardens Insignia
			}
		},
		InsigniaGreater = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[141991] = 1, -- Greater Wardens Insignia
			}
		},
		Paragon_InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146939] = 1, -- Wardens Insignia
			}
		},
		Paragon_InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146945] = 1, -- Wardens Insignia
			}
		},
		Paragon_InsigniaGreater = {
			value = 1500,
			useItem = 1,
			items = {
				[147415] = 1, -- Greater Wardens Insignia
			}
		},
	},
	[F.ARMIES_LEGIONFALL] = {
		InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146949] = 1, -- Legionfall Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[146950] = 1, -- Legionfall Insignia
			}
		},
		InsigniaGreater = {
			value = 750,
			useItem = 1,
			items = {
				[147727] = 1, -- Greater Legionfall Insignia
			}
		},
	},

	[F.CONJURER_MARGOSS] = {
		DrownedMana_10 = {
			value = 500,
			items = {
				[138777] = 10, -- Drowned Mana
			}
		},
		DrownedMana_01 = {
			value = 50,
			items = {
				[138777] = 1, -- Drowned Mana
			}
		},
	},
	[F.FISHERFRIEND_ILYSSIA] = {
		FragmentedEnchantment_01 = {
			value = 75,
			items = {
				[146848] = 1, -- Fragmented Enchantment
			}
		},
	},
	[F.FISHERFRIEND_RAYNAE] = {
		CorruptedGlobule_01 = {
			value = 75,
			items = {
				[146959] = 1, -- Corrupted Globule
			}
		},
	},
	[F.FISHERFRIEND_AKULE] = {
		AncientTotemFragment_01 = {
			value = 75,
			items = {
				[146960] = 1, -- Ancient Totem Fragment
			}
		},
	},
	[F.FISHERFRIEND_CORBYN] = {
		ShinyBauble_01 = {
			value = 75,
			items = {
				[146961] = 1, -- Shiny Bauble
			}
		},
	},
	[F.FISHERFRIEND_SHALETH] = {
		GoldenMinnow_01 = {
			value = 75,
			items = {
				[146962] = 1, -- Golden Minnow
			}
		},
	},
	[F.FISHERFRIEND_IMPUS] = {
		DesecratedSeaweed_01 = {
			value = 75,
			items = {
				[146963] = 1, -- Desecrated Seaweed
			}
		},
	},
	
	-- Old factions with only Timewalker turn-ins (Timewarped Badges)
	[F.HONOR_HOLD] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129948] = 1,	-- Commendation of Honor Hold
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129948] = 1,	-- Commendation of Honor Hold
			}
		},
	},
	[F.ALLIANCE_VANGUARD] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129955] = 1,	-- Commendation of the Alliance Vanguard
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129955] = 1,	-- Commendation of the Alliance Vanguard
			}
		},
	},
	[F.ARGENT_CRUSADE] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129942] = 1,	-- Commendation of the Argent Crusade
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129942] = 1,	-- Commendation of the Argent Crusade
			}
		},
	},
	[F.DRAGONMAW] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133150] = 1,	-- Commendation of the Dragonmaw Clan
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133150] = 1,	-- Commendation of the Dragonmaw Clan
			}
		},
	},
	[F.EARTHEN_RING] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133159] = 1,	-- Commendation of the Earthen Ring
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133159] = 1,	-- Commendation of the Earthen Ring
			}
		},
	},
	[F.GUARDIANS_HYJAL] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133152] = 1,	-- Commendation of the Guardians of Hyjal
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133152] = 1,	-- Commendation of the Guardians of Hyjal
			}
		},
	},
	[F.HORDE_EXPEDITION] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129954] = 1,	-- Commendation of the Horde Expedition
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129954] = 1,	-- Commendation of the Horde Expedition
			}
		},
	},
	[F.KEEPERS_OF_TIME] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129950] = 1,	-- Commendation of the Keepers of Time
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129950] = 1,	-- Commendation of the Keepers of Time
			}
		},
	},
	[F.KIRIN_TOR] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129940] = 1,	-- Commendation of the Kirin Tor
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129940] = 1,	-- Commendation of the Kirin Tor
			}
		},
	},
	[F.RAMKAHEN] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133154] = 1,	-- Commendation of the Ramkahen
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133154] = 1,	-- Commendation of the Ramkahen
			}
		},
	},
	[F.WILDHAMMER] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133151] = 1,	-- Commendation of the Wildhammer Clan
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133151] = 1,	-- Commendation of the Wildhammer Clan
			}
		},
	},
	[F.WYRMREST] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129944] = 1,	-- Commendation of the Wyrmrest Accord
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129944] = 1,	-- Commendation of the Wyrmrest Accord
			}
		},
	},
	[F.THERAZANE] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[133160] = 1,	-- Commendation of Therazane
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[133160] = 1,	-- Commendation of Therazane
			}
		},
	},
	[F.THRALLMAR] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[129947] = 1,	-- Commendation of Thrallmar
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[129947] = 1,	-- Commendation of Thrallmar
			}
		},
	},

	[F.TILLERS] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143941] = 1, -- Commendation of The Tillers
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143941] = 1, -- Commendation of The Tillers
			}
		},
	},
	[F.DOMINANCE_OFFENSIVE] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143943] = 1, -- Commendation of the Dominance Offensive
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143943] = 1, -- Commendation of the Dominance Offensive
			}
		},
	},
	[F.OPERATION_SHIELDWALL] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143944] = 1, -- Commendation of Operation: Shieldwall
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143944] = 1, -- Commendation of Operation: Shieldwall
			}
		},
	},
	[F.ANGLERS] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143946] = 1, -- Commendation of The Anglers
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 300,
			items = {
				[143946] = 1, -- Commendation of The Anglers
			}
		},
	},
	[F.EMPEROR_SHAOHAO] = {
		B_TimewarpedBadge = { -- "A_" and "B_" keys for order dependency
			creates = {
				[143947] = 1, -- Commendation of Emperor Shaohao
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		A_TimewarpedCommendation = {
			value = 500,
			items = {
				[143947] = 1, -- Commendation of Emperor Shaohao
			}
		},
	},
	
}




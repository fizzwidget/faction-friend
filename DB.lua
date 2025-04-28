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
	WINTERSABER_TRAINERS = 589,
	HYDRAXIAN_WATERLORDS = 749,
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
	LOREWALKERS = 1345,
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
	COUNCIL_OF_EXARCHS = 1731,
	HAND_OF_PROPHET = 1847,
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
	TALONS_VENGEANCE = 2018, 
	ARMIES_LEGIONFALL = 2045,
	ARMY_OF_LIGHT = 2165,
	ARGUSSIAN_REACH = 2170,
	
	FISHERFRIEND_ILYSSIA = 2097,
	FISHERFRIEND_RAYNAE = 2098,
	FISHERFRIEND_AKULE = 2099,
	FISHERFRIEND_CORBYN = 2100,
	FISHERFRIEND_SHALETH = 2101,
	FISHERFRIEND_IMPUS = 2102,

-- Battle for Azeroth factions
	RUSTBOLT_RESISTANCE = 2391,
	RAJANI = 2415,
	ZANDALARI_EMPIRE = 2103,
	TALANJIS_EXPEDITION = 2156,
	VOLDUNAI = 2158,
	PROUDMOORE_ADMIRALTY = 2160,
	ORDER_OF_EMBERS = 2161,
	STORMS_WAKE = 2162,
	TORTOLLAN_SEEKERS = 2163,

-- Dragonflight factions
	MARUUK_CENTAUR = 2503,
	DRAGONSCALE_EXPEDITION = 2507,
	VALDRAKKEN_ACCORD = 2510,
	ISKAARA_TUSKARR = 2511,
	
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
	Alliance = { -- horde factions unavailable to alliance players
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
		[F.VOLJINS_SPEAR] = 1,
		[F.VOLJIN_HEADHUNTERS] = 1,
		[F.FROSTWOLF_ORCS] = 1,
		[F.LAUGHING_SKULL] = 1,
		[F.ZANDALARI_EMPIRE] = 1,
		[F.TALANJIS_EXPEDITION] = 1,
		[F.VOLDUNAI] = 1,
	},
	Horde = { -- alliance factions unavailable to horde players
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
		[F.COUNCIL_OF_EXARCHS] = 1,
		[F.HAND_OF_PROPHET] = 1,
		[F.SHATARI_DEFENSE] = 1,
		[F.WRYNNS_VANGUARD] = 1,
		[F.PROUDMOORE_ADMIRALTY] = 1,
		[F.ORDER_OF_EMBERS] = 1,
		[F.STORMS_WAKE] = 1,
	},
}

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
DB.TurninsByQuest = {
	
	-- Racial factions: Horde
	[F.TAUREN] = {
		ZZ_ChampionWrit = {
			creates = {
				[45722] = 1,	-- Thunder Bluff Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45722] = 1,	-- Thunder Bluff Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70153] = 1,	-- Thunder Bluff Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70153] = 1,	-- Thunder Bluff Writ of Commendation
			},
		},
	},
	[F.TROLL] = {
		ZZ_ChampionWrit = {
			creates = {
				[45720] = 1,	-- Sen'jin Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45720] = 1,	-- Sen'jin Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70150] = 1,	-- Sen'jin Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70150] = 1,	-- Sen'jin Writ of Commendation
			},
		},
	},
	[F.FORSAKEN] = {
		ZZ_ChampionWrit = {
			creates = {
				[45723] = 1,	-- Undercity Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45723] = 1,	-- Undercity Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70154] = 1,	-- Undercity Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70154] = 1,	-- Undercity Writ of Commendation
			},
		},
	},
	[F.BELF] = {
		ZZ_ChampionWrit = {
			creates = {
				[45721] = 1,	-- Silvermoon Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45721] = 1,	-- Silvermoon Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70151] = 1,	-- Silvermoon Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70151] = 1,	-- Silvermoon Writ of Commendation
			},
		},
	},
	[F.ORC] = {
		ZZ_ChampionWrit = {
			creates = {
				[45719] = 1,	-- Orgrimmar Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45719] = 1,	-- Orgrimmar Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70149] = 1,	-- Orgrimmar Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
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
		ZZ_ParacausalFlakes = {
			creates = {
				[208133] = 1,	-- Orgrimmar Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:2594"] = 2500,	-- Paracausal Flakes
			},
		},
		ParacausalInsignia = {
			value = 250,
			useItem = 1,
			items = {
				[208133] = 1,	-- Orgrimmar Insignia
			}
		},	
	},
	[F.GOBLIN] = {
		ZZ_MarkOfWorldTree = {
			creates = {
				[71088] = 1,	-- Bilgewater Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
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
		ZZ_ChampionWrit = {
			creates = {
				[45714] = 1,	-- Darnassus Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45714] = 1,	-- Darnassus Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70145] = 1,	-- Darnassus Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70145] = 1,	-- Darnassus Writ of Commendation
			},
		},
	},
	[F.GNOME] = {
		ZZ_ChampionWrit = {
			creates = {
				[45716] = 1,	-- Gnomeregan Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45716] = 1,	-- Gnomeregan Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70147] = 1,	-- Gnomeregan Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70147] = 1,	-- Gnomeregan Writ of Commendation
			},
		},
	},
	[F.HUMAN] = {
		ZZ_ChampionWrit = {
			creates = {
				[45718] = 1,	-- Stormwind Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45718] = 1,	-- Stormwind Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70152] = 1,	-- Stormwind Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70152] = 1,	-- Stormwind Writ of Commendation
			},
		},
		ZZ_ParacausalFlakes = {
			creates = {
				[208132] = 1,	-- Stormwind Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:2594"] = 2500,	-- Paracausal Flakes
			},
		},
		ParacausalInsignia = {
			value = 250,
			useItem = 1,
			items = {
				[208132] = 1,	-- Stormwind Insignia
			}
		},	
	},
	[F.DRAENEI] = {
		ZZ_ChampionWrit = {
			creates = {
				[45715] = 1,	-- Exodar Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45715] = 1,	-- Exodar Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70146] = 1,	-- Exodar Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[70146] = 1,	-- Exodar Writ of Commendation
			},
		},
	},
	[F.DWARF] = {
		ZZ_ChampionWrit = {
			creates = {
				[45717] = 1,	-- Ironforge Commendation Badge
			},
			value = 0,
			buyValue = 250,
			items = {
				[46114] = 1,	-- Champion's Writ
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[45717] = 1,	-- Ironforge Commendation Badge
			},
		},
		ZZ_MarkOfWorldTree = {
			creates = {
				[70148] = 1,	-- Ironforge Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
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
		ZZ_MarkOfWorldTree = {
			creates = {
				[71087] = 1,	-- Gilneas Writ of Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:416"] = 30,	-- Mark of the World Tree
			},
		},
		CommendationWrit = {
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

	-- Other Classic factions
	[F.ZANDALAR] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[224570] = 1, -- Commendation of the Zandalar Tribe
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[224570] = 1, -- Commendation of the Zandalar Tribe
			}
		},
		HonorTokens = {
			value = 50,
			useItem = 1,
			items = {
				[19858] = 1,	-- Zandalar Honor Token
			},
		},
	},
	[F.BROOD_NOZDORMU] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[224558] = 1, -- Commendation of the Brood of Nozdormu
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[224558] = 1, -- Commendation of the Brood of Nozdormu
			}
		},
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
		ZZ_TimewarpedBadge = {
			creates = {
				[224567] = 1, -- Commendation of the Argent Dawn
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[224567] = 1, -- Commendation of the Argent Dawn
			}
		},
		ValorTokens = {
			value = 100,
			useItem = 1,
			items = {
				[12844] = 1,	-- Argent Dawn Valor Token
			},
		},
	},
	[F.TIMBERMAW] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[224566] = 1, -- Commendation of the Timbermaw Hold
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[224566] = 1, -- Commendation of the Timbermaw Hold
			}
		},
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
		ZZ_TimewarpedBadge = {
			creates = {
				[224571] = 1, -- Commendation of the Thorium Brotherhood
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[224571] = 1, -- Commendation of the Thorium Brotherhood
			}
		},
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
	[F.WINTERSABER_TRAINERS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				 [224565] = 1, -- Commendation of the Wintersaber Trainers
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				 [224565] = 1, -- Commendation of the Wintersaber Trainers
			}
		},
	},
	[F.HYDRAXIAN_WATERLORDS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				 [224561] = 1, -- Commendation of the Hydraxian Waterlords
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				 [224561] = 1, -- Commendation of the Hydraxian Waterlords
			}
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
		ZZ_TimewarpedBadge = {
			creates = {
				[129945] = 1,	-- Commendation of the Consortium
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
		ZZ_TimewarpedBadge = {
			creates = {
				[129949] = 1,	-- Commendation of the Cenarion Expedition
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[129949] = 1,	-- Commendation of the Cenarion Expedition
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
		ZZ_TimewarpedBadge = {
			creates = {
				[129951] = 1,	-- Commendation of Lower City
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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

		ZZ_TimewarpedBadge = {
			creates = {
				[129946] = 1,	-- Commendation of The Sha'tar
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[129946] = 1,	-- Commendation of The Sha'tar
			}
		},
	},
	[F.HONOR_HOLD] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129948] = 1,	-- Commendation of Honor Hold
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[129948] = 1,	-- Commendation of Honor Hold
			}
		},
	},
	[F.THRALLMAR] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129947] = 1,	-- Commendation of Thrallmar
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[129947] = 1,	-- Commendation of Thrallmar
			}
		},
	},
	[F.KEEPERS_OF_TIME] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129950] = 1,	-- Commendation of the Keepers of Time
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[129950] = 1,	-- Commendation of the Keepers of Time
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
		ZZ_TimewarpedBadge = {
			creates = {
				[129943] = 1,	-- Commendation of the Sons of Hodir
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
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
		ZZ_TimewarpedBadge = {
			creates = {
				[129941] = 1,	-- Commendation of The Ebon Blade
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129941] = 1,	-- Commendation of The Ebon Blade
			}
		},
		ZZ_ParacausalFlakes = {
			creates = {
				[208617] = 1,	-- Ebon Blade Commendation Badge
			},
			value = 0,
			buyValue = 260,
			items = {
				["currency:2594"] = 2600,	-- Paracausal Flakes
			},
		},
		ParacausalInsignia = {
			value = 260,
			useItem = 1,
			items = {
				[208617] = 1,	-- Ebon Blade Commendation Badge
			}
		},	
	},
	[F.ALLIANCE_VANGUARD] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129955] = 1,	-- Commendation of the Alliance Vanguard
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129955] = 1,	-- Commendation of the Alliance Vanguard
			}
		},
	},
	[F.ARGENT_CRUSADE] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129942] = 1,	-- Commendation of the Argent Crusade
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129942] = 1,	-- Commendation of the Argent Crusade
			}
		},
	},
	[F.HORDE_EXPEDITION] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129954] = 1,	-- Commendation of the Horde Expedition
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129954] = 1,	-- Commendation of the Horde Expedition
			}
		},
	},
	[F.KIRIN_TOR] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129940] = 1,	-- Commendation of the Kirin Tor
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129940] = 1,	-- Commendation of the Kirin Tor
			}
		},
	},
	[F.WYRMREST] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[129944] = 1,	-- Commendation of the Wyrmrest Accord
			},
			value = 0,
			buyValue = 501,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 501,
			items = {
				[129944] = 1,	-- Commendation of the Wyrmrest Accord
			}
		},
	},

	-- Cataclysm factions
	[F.BARADIN] = {
		ZZ_TolBaradCommendations = {
			creates = {
				[63517] = 1,	-- Baradin's Wardens Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:391"] = 16,		-- Tol Barad Commendations
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[63517] = 1,	-- Baradin's Wardens Commendation
			},
		},
	},
	[F.HELLSCREAM] = {
		ZZ_TolBaradCommendations = {
			creates = {
				[63518] = 1,	-- Hellscream's Reach Commendation
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:391"] = 16,		-- Tol Barad Commendations
			},
		},
		CommendationBadge = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[63518] = 1,	-- Hellscream's Reach Commendation
			},
		},
	},
	[F.DRAGONMAW] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133150] = 1,	-- Commendation of the Dragonmaw Clan
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133150] = 1,	-- Commendation of the Dragonmaw Clan
			}
		},
	},
	[F.WILDHAMMER] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133151] = 1,	-- Commendation of the Wildhammer Clan
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133151] = 1,	-- Commendation of the Wildhammer Clan
			}
		},
	},
	[F.EARTHEN_RING] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133159] = 1,	-- Commendation of the Earthen Ring
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133159] = 1,	-- Commendation of the Earthen Ring
			}
		},
	},
	[F.GUARDIANS_HYJAL] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133152] = 1,	-- Commendation of the Guardians of Hyjal
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133152] = 1,	-- Commendation of the Guardians of Hyjal
			}
		},
	},
	[F.RAMKAHEN] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133154] = 1,	-- Commendation of the Ramkahen
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133154] = 1,	-- Commendation of the Ramkahen
			}
		},
	},
	[F.THERAZANE] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[133160] = 1,	-- Commendation of Therazane
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[133160] = 1,	-- Commendation of Therazane
			}
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
		ZZ_TimewarpedBadge = {
			creates = {
				[143942] = 1, -- Commendation of the Order of the Cloud Serpent
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[143942] = 1, -- Commendation of the Order of the Cloud Serpent
			}
		},
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
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
		ZZ_TimewarpedBadge = {
			creates = {
				[143935] = 1, -- Commendation of The Klaxxi
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
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
		ZZ_TimewarpedBadge = {
			creates = {
				[143937] = 1, -- Commendation of the Golden Lotus
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.SHADOPAN] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143936] = 1, -- Commendation of the Shado-Pan
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.AUGUST_CELESTIALS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143938] = 1, -- Commendation of The August Celestials
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.SHADOPAN_ASSAULT] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143945] = 1, -- Commendation of the Shado-Pan Assault
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
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
	[F.ANGLERS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143946] = 1, -- Commendation of The Anglers
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[143946] = 1, -- Commendation of The Anglers
			}
		},
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.TILLERS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143941] = 1, -- Commendation of The Tillers
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[143941] = 1, -- Commendation of The Tillers
			}
		},
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.LOREWALKERS] = {
		OfferingOfPeace = {
			value = 1000,
			items = {
				[86592] = 1, -- Hozen Peace Pipe
			}
		},
	},
	[F.DOMINANCE_OFFENSIVE] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143943] = 1, -- Commendation of the Dominance Offensive
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[143943] = 1, -- Commendation of the Dominance Offensive
			}
		},
	},
	[F.OPERATION_SHIELDWALL] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143944] = 1, -- Commendation of Operation: Shieldwall
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[143944] = 1, -- Commendation of Operation: Shieldwall
			}
		},
	},
	[F.EMPEROR_SHAOHAO] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[143947] = 1, -- Commendation of Emperor Shaohao
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[143947] = 1, -- Commendation of Emperor Shaohao
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
		ZZ_TatteredDocs_01 = {
			creates = {
				[95487] = 1,	-- Sunreaver Onslaught Insignia
			},
			value = 0,
			buyValue = 25,
			items = {
				[95491] = 1,		-- Tattered Historical Parchments
			},
		},
		Insignia = {
			value = 25,
			useItem = 1,
			purchased = 1,
			items = {
				[95487] = 1,	-- Sunreaver Onslaught Insignia
			},
		},
		ZZ_TatteredDocs_10 = {
			creates = {
				[95488] = 1,	-- Greater Sunreaver Onslaught Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				[95491] = 10,		-- Tattered Historical Parchments
			},
		},
		InsigniaGreater = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[95488] = 1,	-- Greater Sunreaver Onslaught Insignia
			},
		},
		ZZ_TimewarpedBadge = {
			creates = {
				[143939] = 1, -- Commendation of the Sunreaver Onslaught
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[143939] = 1, -- Commendation of the Sunreaver Onslaught
			}
		},
	},
	[F.KIRIN_TOR_OFFENSIVE] = {
		ZZ_TatteredDocs_01 = {
			creates = {
				[95489] = 1,	-- Kirin Tor Offensive Insignia
			},
			value = 0,
			buyValue = 25,
			items = {
				[95491] = 1,		-- Tattered Historical Parchments
			},
		},
		Insignia = {
			value = 25,
			useItem = 1,
			purchased = 1,
			items = {
				[95489] = 1,	-- Kirin Tor Offensive Insignia
			},
		},
		ZZ_TatteredDocs_10 = {
			creates = {
				[95490] = 1,	-- Greater Kirin Tor Offensive Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				[95491] = 10,		-- Tattered Historical Parchments
			},
		},
		InsigniaGreater = {
			value = 250,
			useItem = 1,
			purchased = 1,
			items = {
				[95490] = 1,	-- Greater Kirin Tor Offensive Insignia
			},
		},
		ZZ_TimewarpedBadge = {
			creates = {
				[143940] = 1, -- Commendation of the Kirin Tor Offensive
			},
			value = 0,
			buyValue = 500,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 500,
			items = {
				[143940] = 1, -- Commendation of the Kirin Tor Offensive
			}
		},
	},

	-- Warlords of Draenor factions
	[F.STEAMWHEEDLE_SOCIETY] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[167926] = 1, -- Commendation of the Steamwheedle Preservation Society
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167926] = 1, -- Commendation of the Steamwheedle Preservation Society
			}
		},
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
		ZZ_TimewarpedBadge = {
			creates = {
				[167924] = 1, -- Commendation of the Arakkoa Outcasts
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167924] = 1, -- Commendation of the Arakkoa Outcasts
			}
		},
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
		ZZ_TimewarpedBadge = {
			creates = {
				[167925] = 1, -- Commendation of the Order of the Awakened
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167925] = 1, -- Commendation of the Order of the Awakened
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
	[F.SABERSTALKERS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[167927] = 1, -- Commendation of the Saberstalkers
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167927] = 1, -- Commendation of the Saberstalkers
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
		ZZ_TimewarpedBadge = {
			creates = {
				[168017] = 1, -- Commendation of Vol'jin's Headhunters
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[168017] = 1, -- Commendation of Vol'jin's Headhunters
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
		ZZ_TimewarpedBadge = {
			creates = {
				[167928] = 1, -- Commendation of the Frostwolf Orcs
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167928] = 1, -- Commendation of the Frostwolf Orcs
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
	[F.LAUGHING_SKULL] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[167930] = 1, -- Commendation of the Laughing Skull Orcs
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167930] = 1, -- Commendation of the Laughing Skull Orcs
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
	[F.COUNCIL_OF_EXARCHS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[167929] = 1, -- Commendation of the Council of Exarchs
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167929] = 1, -- Commendation of the Council of Exarchs
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
	[F.HAND_OF_PROPHET] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[168018] = 1, -- Commendation of the Hand of the Prophet
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[168018] = 1, -- Commendation of the Hand of the Prophet
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
	[F.SHATARI_DEFENSE] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[167932] = 1, -- Commendation of the Sha'tari Defense
			},
			value = 0,
			buyValue = 300,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		TimewarpedCommendation = {
			value = 300,
			items = {
				[167932] = 1, -- Commendation of the Sha'tari Defense
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
		ZZ_TimewarpedBadge = {
			creates = {
				[141343] = 1, -- Nightfallen Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 750,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150930] = 1, -- Greater Nightfallen Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.VALARJAR] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[141338] = 1, -- Valarjar Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150925] = 1, -- Greater Valarjar Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.HIGHMOUNTAIN_TRIBE] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[141341] = 1, -- Highmountain Tribe Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150928] = 1, -- Greater Highmountain Tribe Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.DREAMWEAVERS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[141339] = 1, -- Dreamweaver Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150926] = 1, -- Greater Dreamweaver Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.FARONDIS_COURT] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[141340] = 1, -- Court of Farondis Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150927] = 1, -- Greater Court of Farondis Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.WARDENS] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[141342] = 1, -- Wardens Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
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
		InsigniaGreaterBoA = {
			value = 1500,
			maxStanding = 7, 
			useItem = 1,
			items = {
				[150929] = 1, -- Greater Wardens Insignia
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.ARMIES_LEGIONFALL] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[146950] = 1, -- Legionfall Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[146949] = 1, -- Legionfall Insignia
			}
		},
		ZZ_ParacausalFlakes = {
			creates = {
				[146949] = 1, -- Legionfall Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:2594"] = 2500,	-- Paracausal Flakes
			},
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
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.ARMY_OF_LIGHT] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[152957] = 1, -- Army of the Light Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[152958] = 1, -- Army of the Light Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[152957] = 1, -- Army of the Light Insignia
			}
		},
		InsigniaGreaterBoP = {
			value = 750,
			useItem = 1,
			items = {
				[152956] = 1, -- Greater Army of the Light Insignia
			}
		},
		InsigniaGreaterBoA = {
			value = 750,
			useItem = 1,
			items = {
				[152955] = 1, -- Greater Army of the Light Insignia
			}
		},
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.ARGUSSIAN_REACH] = {
		ZZ_TimewarpedBadge = {
			creates = {
				[152960] = 1, -- Argussian Reach Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1166"] = 50,	-- Timewarped Badge
			},
		},
		InsigniaBoP = {
			value = 250,
			useItem = 1,
			items = {
				[152959] = 1, -- Argussian Reach Insignia
			}
		},
		InsigniaBoA = {
			value = 250,
			useItem = 1,
			items = {
				[152960] = 1, -- Argussian Reach Insignia
			}
		},
		InsigniaGreaterBoP = {
			value = 750,
			useItem = 1,
			items = {
				[152961] = 1, -- Greater Argussian Reach Insignia
			}
		},
		InsigniaGreaterBoA = {
			value = 750,
			useItem = 1,
			items = {
				[152954] = 1, -- Greater Argussian Reach Insignia
			}
		},
		DemonsSoulstone = {
			value = 1000,
			useItem = 1,
			items = {
				[153113] = 1, -- Demon's Soulstone
			}
		},
	},
	[F.TALONS_VENGEANCE] = {
		MarkOfPrey = {
			value = 100,
			items = {
				[142363] = 1, -- Mark of Prey
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
	
	-- Battle for Azeroth factions
	[F.RUSTBOLT_RESISTANCE] = {
		LIKE = {
			value = 250,
			useItem = 1,
			items = {
				[173736] = 1,	-- Layered Information Kernel of E-steam
			}
		},	
		TKE = {
			value = 250,
			useItem = 1,
			items = {
				[174521] = 1,	-- Transferable Kernel of E-steam
			}
		},	
		InsigniaBoA = {
			value = 100,
			useItem = 1,
			items = {
				[298138] = 1,	-- Rustbolt Resistance Insignia
			}
		},	
		ZZ_ParacausalFlakes = {
			creates = {
				[208134] = 1,	-- Rustbolt Resistance Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:2594"] = 2500,	-- Paracausal Flakes
			},
		},
		ParacausalInsignia = {
			value = 250,
			useItem = 1,
			items = {
				[208134] = 1,	-- Rustbolt Resistance Insignia
			}
		},	
	},
	[F.RAJANI] = {
		ZZ_ParacausalFlakes = {
			creates = {
				[173375] = 1,	-- Rajani Insignia
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:2594"] = 2500,	-- Paracausal Flakes
			},
		},
		ParacausalInsignia = {
			value = 250,
			useItem = 1,
			items = {
				[173375] = 1,	-- Rajani Insignia
			}
		},	
	},
	[F.TORTOLLAN_SEEKERS] = {
		ZZ_Dubloon = {
			creates = {
				[166501] = 1,	-- Soggy Page
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[166501] = 1,	-- Soggy Page
			},
		},
	},
	[F.ZANDALARI_EMPIRE] = {
		ZZ_Dubloon = {
			creates = {
				[163620] = 1,	-- Island Flotsam
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163620] = 1,	-- Island Flotsam
			},
		},
	},
	[F.TALANJIS_EXPEDITION] = {
		ZZ_Dubloon = {
			creates = {
				[163619] = 1,	-- Golden Beetle
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163619] = 1,	-- Golden Beetle
			},
		},
	},
	[F.VOLDUNAI] = {
		ZZ_Dubloon = {
			creates = {
				[163618] = 1,	-- Shimmering Shell
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163618] = 1,	-- Shimmering Shell
			},
		},
	},
	[F.PROUDMOORE_ADMIRALTY] = {
		ZZ_Dubloon = {
			creates = {
				[163616] = 1,	-- Dented Coin
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163616] = 1,	-- Dented Coin
			},
		},
	},
	[F.STORMS_WAKE] = {
		ZZ_Dubloon = {
			creates = {
				[163615] = 1,	-- Lost Sea Scroll
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163615] = 1,	-- Lost Sea Scroll
			},
		},
	},
	[F.ORDER_OF_EMBERS] = {
		ZZ_Dubloon = {
			creates = {
				[163614] = 1,	-- Exotic Spices
			},
			value = 0,
			buyValue = 250,
			items = {
				["currency:1710"] = 100,	-- Seafarer's Dubloon
			},
		},
		DubloonPurchase = {
			value = 250,
			items = {
				[163614] = 1,	-- Exotic Spices
			},
		},
	},
	
	-- Dragonflight factions
	[F.MARUUK_CENTAUR] = {
		HuntingTropy = {
			-- technically 3 quests, for 1x, 5x, or 20x items, but rep reward is same multiplier
			value = 25,
			items = {
				[200093] = 1,	-- Centaur Hunting Trophy
			},
		},
	},
	[F.DRAGONSCALE_EXPEDITION] = {
		DragonIslesArtifacts = {
			-- technically 3 quests, for 1x, 5x, or 20x items, but rep reward is same multiplier
			value = 25,
			items = {
				[192055] = 1,	-- Dragon Isles Artifact
			},
		},
		VaultArtifacts = {
			-- technically 2 quests, for 1x or 5x items, but rep reward is same multiplier
			value = 30,
			items = {
				[201412] = 1,	-- Ancient Vault Artifact
			},
		},
	},
	[F.VALDRAKKEN_ACCORD] = {
		TitanRelic = {
			-- technically 2 quests, for 1x or 5x items, but rep reward is same multiplier
			value = 25,
			items = {
				[199906] = 1,	-- Titan Relic
			},
		},
	},
	[F.ISKAARA_TUSKARR] = {
		StolenTotems = {
			-- technically 2 quests, for 1x or 5x items, but rep reward is same multiplier
			value = 25,
			items = {
				[200071] = 1,	-- Sacred Tuskarr Totem
			},
		},

	},
	
}




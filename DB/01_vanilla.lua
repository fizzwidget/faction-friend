------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.ZANDALAR = 270
F.BROOD_NOZDORMU = 910
F.CENARION_CIRCLE = 609
F.ARGENT_DAWN = 529
F.TIMBERMAW = 576
F.THORIUM_BROTHERHOOD = 59
F.HYDRAXIAN_WATERLORDS = 749

local H = DB.ID.Horde

H.ORC = 76
H.TAUREN = 81
H.TROLL = 530
H.FORSAKEN = 68
H.FROSTWOLF = 729
H.DEFILERS = 510
H.WARSONG_OUTRIDERS = 889

local A = DB.ID.Alliance

A.DWARF = 47
A.NELF = 69
A.GNOME = 54
A.HUMAN = 72
A.WINTERSABER_TRAINERS = 589
A.STORMPIKE = 730
A.ARATHOR = 509
A.SILVERWING = 890

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
-- Racial factions: Horde
Q[H.TAUREN] = {
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
}
Q[H.TROLL] = {
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
}
Q[H.FORSAKEN] = {
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
}
Q[H.ORC] = {
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
}

-- Racial factions: Alliance
Q[A.NELF] = {
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
}
Q[A.GNOME] = {
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
}
Q[A.HUMAN] = {
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
}
Q[A.DWARF] = {
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
}

-- Battleground factions
Q[H.FROSTWOLF] = {
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
}
Q[A.STORMPIKE] = {
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
}

-- Other Classic factions
Q[F.ZANDALAR] = {
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
}
Q[F.BROOD_NOZDORMU] = {
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
}
Q[F.CENARION_CIRCLE] = {
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
}
Q[F.ARGENT_DAWN] = {
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
	ZZ_NewInvader_50 = {
		value = 125,
		creates = {
			[12844] = 5,	-- Argent Dawn Valor Token
		},
		buyValue = 500,
		items = {
			[206374] = 50,	-- Invader's Scourgestone
		},
	},
	ZZ_NewInvader_10 = {
		value = 25,
		creates = {
			[12844] = 5,	-- Argent Dawn Valor Token
		},
		buyValue = 100,
		items = {
			[206374] = 10,	-- Invader's Scourgestone
		},
	},
	ZZ_NewCorruptor_05 = {
		value = 250,
		creates = {
			[12844] = 5,	-- Argent Dawn Valor Token
		},
		buyValue = 500,
		items = {
			[206375] = 5,	-- Corruptor's Scourgestone
		},
	},
	ZZ_NewCorruptor_01 = {
		value = 50,
		creates = {
			[12844] = 5,	-- Argent Dawn Valor Token
		},
		buyValue = 100,
		items = {
			[206375] = 1,	-- Corruptor's Scourgestone
		},
	},
}
Q[F.TIMBERMAW] = {
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
}
Q[F.THORIUM_BROTHERHOOD] = {
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
}
Q[A.WINTERSABER_TRAINERS] = {
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
}
Q[F.HYDRAXIAN_WATERLORDS] = {
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
}


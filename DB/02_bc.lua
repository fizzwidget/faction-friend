------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.CENARION_EXPEDITION = 942
F.SPOREGGAR = 970
F.CONSORTIUM = 933
F.ALDOR = 932
F.SCRYER = 934
F.SHATAR = 935
F.LOWER_CITY = 1011
F.NETHERWING = 1015
F.SKYGUARD = 1031
F.KEEPERS_OF_TIME = 989
F.SCALE_SANDS = 990
F.SHATTERED_SUN = 1077
F.VIOLET_EYE = 967

local H = DB.ID.Horde

H.BELF = 911
H.THRALLMAR = 947
H.MAGHAR = 941

local A = DB.ID.Alliance

A.DRAENEI = 930
A.HONOR_HOLD = 946
A.KURENAI = 978

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------

local Q = DB.TurninsByQuest
	
-- Racial factions: Horde
Q[H.BELF] = {
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
}

-- Racial factions: Alliance
Q[A.DRAENEI] = {
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
}

-- Burning Crusade factions
Q[F.CONSORTIUM] = {
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
}
Q[H.MAGHAR] = {
	Warbeads = {
		value = 500,
		minStanding = 4, 
		items = {
			[25433] = 10,	-- Obsidian Warbeads
		},
	},
}
Q[A.KURENAI] = {
	Warbeads = {
		value = 500,
		minStanding = 4, 
		items = {
			[25433] = 10,	-- Obsidian Warbeads
		},
	},
}
Q[F.CENARION_EXPEDITION] = {
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
}
Q[F.SPOREGGAR] = {
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
}
Q[F.ALDOR] = {
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
}
Q[F.SCRYER] = {
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
}
Q[F.LOWER_CITY] = {
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
}
Q[F.NETHERWING] = {
	GreatEggHunt = {
		value = 250,
		minStanding = 4, 
		items = {
			[32506] = 1,	-- Netherwing Egg
		},
	},
}
Q[F.SKYGUARD] = {
	ElixirOfShadows = {
		value = 150,
		minStanding = 4, 
		items = {
			[32388] = 6,	-- Shadow Dust
		},
	},
}
Q[F.SHATAR] = {
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
}
Q[A.HONOR_HOLD] = {
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
}
Q[H.THRALLMAR] = {
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
}
Q[F.KEEPERS_OF_TIME] = {
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
}

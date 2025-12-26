------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.MARUUK_CENTAUR = 2503
F.DRAGONSCALE_EXPEDITION = 2507
F.VALDRAKKEN_ACCORD = 2510
F.ISKAARA_TUSKARR = 2511
F.LOAMM_NIFFEN = 2564
F.DREAM_WARDENS = 2574

F.WRATHION = 2517
F.SABELLIAN = 2518

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.MARUUK_CENTAUR] = {
	HuntingTropy_01 = {
		value = 25,
		items = {
			[200093] = 1,	-- Centaur Hunting Trophy
		},
	},
	HuntingTropy_05 = {
		value = 125,
		items = {
			[200093] = 5,	-- Centaur Hunting Trophy
		},
	},
	HuntingTropy_20 = {
		value = 500,
		items = {
			[200093] = 20,	-- Centaur Hunting Trophy
		},
	},
	ZZ_FlightstoneInsignia = {
		creates = {
			[200288] = 1, -- Maruuk Centaur Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2245"] = 150,	-- Flightstones
		},
	},
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[200288] = 1, -- Maruuk Centaur Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[200454] = 1, -- Maruuk Centaur Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[201923] = 1, -- Maruuk Centaur Insignia Q4
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[202094] = 1, -- Maruuk Centaur Insignia Q4+
		},
	},
}
Q[F.DRAGONSCALE_EXPEDITION] = {
	DragonIslesArtifacts_01 = {
		value = 25,
		items = {
			[192055] = 1,	-- Dragon Isles Artifact
		},
	},
	DragonIslesArtifacts_05 = {
		value = 125,
		items = {
			[192055] = 5,	-- Dragon Isles Artifact
		},
	},
	DragonIslesArtifacts_20 = {
		value = 500,
		items = {
			[192055] = 20,	-- Dragon Isles Artifact
		},
	},
	VaultArtifacts_01 = {
		value = 30,
		items = {
			[201412] = 1,	-- Ancient Vault Artifact
		},
	},
	VaultArtifacts_05 = {
		value = 150,
		items = {
			[201412] = 5,	-- Ancient Vault Artifact
		},
	},
	ZZ_FlightstoneInsignia = {
		creates = {
			[200285] = 1, -- Dragonscale Expedition Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2245"] = 150,	-- Flightstones
		},
	},
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[200285] = 1, -- Dragonscale Expedition Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[200452] = 1, -- Dragonscale Expedition Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[201921] = 1, -- Dragonscale Expedition Insignia Q4
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[202091] = 1, -- Dragonscale Expedition Insignia Q4+
		},
	},
}
Q[F.VALDRAKKEN_ACCORD] = {
	TitanRelic_01 = {
		value = 25,
		items = {
			[199906] = 1,	-- Titan Relic
		},
	},
	TitanRelic_05 = {
		value = 125,
		items = {
			[199906] = 5,	-- Titan Relic
		},
	},
	ZZ_FlightstoneInsignia = {
		creates = {
			[200289] = 1, -- Valdrakken Accord Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2245"] = 150,	-- Flightstones
		},
	},
	ZZ_DragonracingInsignia = {
		creates = {
			[200289] = 1, -- Valdrakken Accord Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2588"] = 150,	-- Riders of Azeroth Badge
		},
	},
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[200289] = 1, -- Valdrakken Accord Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[200455] = 1, -- Valdrakken Accord Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[201924] = 1, -- Valdrakken Accord Insignia Q4
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[202093] = 1, -- Valdrakken Accord Insignia Q4+
		},
	},
}
Q[F.ISKAARA_TUSKARR] = {
	StolenTotems_01 = {
		value = 25,
		items = {
			[200071] = 1,	-- Sacred Tuskarr Totem
		},
	},
	StolenTotems_05 = {
		value = 125,
		items = {
			[200071] = 5,	-- Sacred Tuskarr Totem
		},
	},
	ZZ_FlightstoneInsignia = {
		creates = {
			[200287] = 1, -- Iskaara Tuskarr Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2245"] = 150,	-- Flightstones
		},
	},
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[200287] = 1, -- Iskaara Tuskarr Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[200453] = 1, -- Iskaara Tuskarr Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[201922] = 1, -- Iskaara Tuskarr Insignia Q4
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[202092] = 1, -- Iskaara Tuskarr Insignia Q4+
		},
	},
}
Q[F.LOAMM_NIFFEN] = {
	ZZ_FlightstoneInsignia = {
		creates = {
			[205365] = 1, -- Loamm Niffen Insignia Q2
		},
		value = 0,
		buyValue = 50,
		items = {
			["currency:2245"] = 150,	-- Flightstones
		},
	},
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[205365] = 1, -- Loamm Niffen Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[205342] = 1, -- Loamm Niffen Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[205985] = 1, -- Loamm Niffen Insignia Q4
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[210422] = 1, -- Loamm Niffen Insignia Q4+
		},
	},
}
Q[F.DREAM_WARDENS] = {
	InsigniaUncommon = {
		value = 50,
		useItem = 1,
		items = {
			[210419] = 1, -- Dream Wardens Insignia Q2
		},
	},
	InsigniaRare = {
		value = 250,
		useItem = 1,
		items = {
			[210420] = 1, -- Dream Wardens Insignia Q3
		},
	},
	InsigniaEpic = {
		value = 500,
		useItem = 1,
		items = {
			[210421] = 1, -- Dream Wardens Insignia Q4
		},
	},
	InsigniaEpicBoA = {
		value = 1000,
		useItem = 1,
		items = {
			[211416] = 1, -- Dream Wardens Insignia Q4+
		},
	},
	InsigniaEpicBoP = {
		value = 500,
		useItem = 1,
		items = {
			[211417] = 1, -- Dream Wardens Insignia Q4+
		},
	},
	InsigniaEpicBig = {
		value = 2500,
		useItem = 1,
		items = {
			[210423] = 1, -- Dream Wardens Insignia Q4++
		},
	},
}
Q[F.WRATHION] = {
	Sargha_01 = {
		value = 50,
		items = {
			[201991] = 1,	-- Sargha's Signet
		},
	},
	Sargha_10 = {
		value = 500,
		items = {
			[201991] = 10,	-- Sargha's Signet
		},
	},
}
Q[F.SABELLIAN] = {
	Sargha_01 = {
		value = 50,
		items = {
			[200224] = 1,	-- Mark of Sargha
		},
	},
	Sargha_10 = {
		value = 500,
		items = {
			[200224] = 10,	-- Mark of Sargha
		},
	},
}

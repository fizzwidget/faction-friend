------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.ORDER_CLOUD_SERPENT = 1271
F.KLAXXI = 1337
F.GOLDEN_LOTUS = 1269
F.SHADOPAN = 1270
F.AUGUST_CELESTIALS = 1341
F.TILLERS = 1272
F.LOREWALKERS = 1345
F.SHADOPAN_ASSAULT = 1435
F.ANGLERS = 1302
F.EMPEROR_SHAOHAO = 1492
	
-- NPC friendships
F.CHEE_CHEE = 1277
F.ELLA = 1275
F.FARMER_FUNG = 1283
F.FISH_FELLREED = 1282
F.GINA_MUDCLAW = 1281
F.HAOHAN_MUDCLAW = 1279
F.JOGU_THE_DRUNK = 1273
F.OLD_HILLPAW = 1276
F.SHO = 1278
F.TINA_MUDCLAW = 1280
	
local H = DB.ID.Horde

H.HUOJIN = 1352
H.DOMINANCE_OFFENSIVE = 1375
H.SUNREAVER_ONSLAUGHT = 1388

local A = DB.ID.Alliance

A.TUSHUI = 1353
A.OPERATION_SHIELDWALL = 1376
A.KIRIN_TOR_OFFENSIVE = 1387

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.ORDER_CLOUD_SERPENT] = {
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
}
Q[F.KLAXXI] = {
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
}
Q[F.GOLDEN_LOTUS] = {
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
}
Q[F.SHADOPAN] = {
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
}
Q[F.AUGUST_CELESTIALS] = {
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
}
Q[F.SHADOPAN_ASSAULT] = {
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
}
Q[F.ANGLERS] = {
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
}
Q[F.TILLERS] = {
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
}
Q[F.LOREWALKERS] = {
	OfferingOfPeace = {
		value = 1000,
		items = {
			[86592] = 1, -- Hozen Peace Pipe
		}
	},
}
Q[H.DOMINANCE_OFFENSIVE] = {
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
}
Q[A.OPERATION_SHIELDWALL] = {
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
}
Q[F.EMPEROR_SHAOHAO] = {
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
}
Q[H.SUNREAVER_ONSLAUGHT] = {
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
}
Q[A.KIRIN_TOR_OFFENSIVE] = {
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
}

Q[F.CHEE_CHEE] = {
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
}
Q[F.OLD_HILLPAW] = {
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
}
Q[F.ELLA] = {
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
}
Q[F.FISH_FELLREED] = {
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
}
Q[F.FARMER_FUNG] = {
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
}
Q[F.GINA_MUDCLAW] = {
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
}
Q[F.HAOHAN_MUDCLAW] = {
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
}
Q[F.TINA_MUDCLAW] = {
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
}
Q[F.JOGU_THE_DRUNK] = {
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
}
Q[F.SHO] = {
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
}

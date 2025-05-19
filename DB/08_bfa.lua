------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.RUSTBOLT_RESISTANCE = 2391
F.RAJANI = 2415
F.TORTOLLAN_SEEKERS = 2163
F.CHAMPIONS_OF_AZEROTH = 2164

local H = DB.ID.Horde

H.ZANDALARI_EMPIRE = 2103
H.TALANJIS_EXPEDITION = 2156
H.VOLDUNAI = 2158
H.HONORBOUND = 2157
H.UNSHACKLED = 2373

local A = DB.ID.Alliance

A.PROUDMOORE_ADMIRALTY = 2160
A.ORDER_OF_EMBERS = 2161
A.STORMS_WAKE = 2162
A.SEVENTH_LEGION = 2159
A.WAVEBLADE_ANKOAN = 2400
A.HONEYBACK_HIVE = 2395

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest

Q[F.RUSTBOLT_RESISTANCE] = {
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
}
Q[F.RAJANI] = {
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
}
Q[F.TORTOLLAN_SEEKERS] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[166501] = 1,	-- Soggy Page
		},
	},
}
Q[H.ZANDALARI_EMPIRE] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163620] = 1,	-- Island Flotsam
		},
	},
}
Q[H.TALANJIS_EXPEDITION] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163619] = 1,	-- Golden Beetle
		},
	},
}
Q[H.VOLDUNAI] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163618] = 1,	-- Shimmering Shell
		},
	},
}
Q[A.PROUDMOORE_ADMIRALTY] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163616] = 1,	-- Dented Coin
		},
	},
}
Q[A.STORMS_WAKE] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163615] = 1,	-- Lost Sea Scroll
		},
	},
}
Q[A.ORDER_OF_EMBERS] = {
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
	IslandExpedition = {
		value = 250,
		items = {
			[163614] = 1,	-- Exotic Spices
		},
	},
}
Q[F.CHAMPIONS_OF_AZEROTH] = {
	IslandExpedition = {
		value = 250,
		items = {
			[163217] = 1,	-- Azeroth's Tear
		},
	},
}
Q[H.HONORBOUND] = {
	IslandExpedition = {
		value = 250,
		items = {
			[163621] = 1,	-- Rusted Horde Insignia
		},
	},
}
Q[A.SEVENTH_LEGION] = {
	IslandExpedition = {
		value = 250,
		items = {
			[163617] = 1,	-- Rusted Alliance Insignia
		},
	},
}
Q[H.UNSHACKLED] = {
	BodyguardBox = {
		value = 400,
		items = {
			[169942] = 1,	-- Vibrant Sea Blossom
		},
	},
	ZZ_Manapearl = {
		creates = {
			[174522] = 1,	-- Waveswept Abyssal Conch
		},
		value = 0,
		buyValue = 250,
		items = {
			["currency:1721"] = 100,	-- Prismatic Manapearl
		},
	},
	ChestConch = {
		value = 150,
		items = {
			[170079] = 1,	-- Abyssal Conch
		},
	},
	SalvageConch = {
		value = 250,
		items = {
			[173947] = 1,	-- Glittering Abyssal Conch
		},
	},
	ManapearlConch = {
		value = 250,
		items = {
			[174522] = 1,	-- Waveswept Abyssal Conch
		},
	},
}
Q[A.WAVEBLADE_ANKOAN] = {
	BodyguardBox = {
		value = 400,
		items = {
			[169941] = 1,	-- Ceremonial Ankoan Scabbard
		},
	},
	ZZ_Manapearl = {
		creates = {
			[174523] = 1,	-- Waveswept Abyssal Conch
		},
		value = 0,
		buyValue = 250,
		items = {
			["currency:1721"] = 100,	-- Prismatic Manapearl
		},
	},
	ChestConch = {
		value = 150,
		items = {
			[170081] = 1,	-- Abyssal Conch
		},
	},
	SalvageConch = {
		value = 250,
		items = {
			[173948] = 1,	-- Glittering Abyssal Conch
		},
	},
	ManapearlConch = {
		value = 250,
		items = {
			[174523] = 1,	-- Waveswept Abyssal Conch
		},
	},
}
Q[A.HONEYBACK_HIVE] = {
	ThinJelly = {
		value = 20,
		items = {
			[168822] = 1,	-- Thin Jelly
		},
	},
	RichJelly = {
		value = 80,
		items = {
			[168825] = 1,	-- Rich Jelly
		},
	},
	RoyalJelly = {
		value = 20,
		items = {
			[168828] = 1,	-- Royal Jelly
		},
	},
}

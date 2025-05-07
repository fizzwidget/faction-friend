------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.RAMKAHEN = 1173
F.EARTHEN_RING = 1135
F.AVENGERS_HYJAL = 1204
F.GUARDIANS_HYJAL = 1158
F.THERAZANE = 1171
	

local H = DB.ID.Horde

H.GOBLIN = 1133
H.DRAGONMAW = 1172
H.HELLSCREAM = 1178

local A = DB.ID.Alliance

A.WORGEN = 1134
A.WILDHAMMER = 1174
A.BARADIN = 1177

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
-- Racial factions: Horde
Q[H.GOBLIN] = {
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
}

-- Racial factions: Alliance
Q[A.WORGEN] = {
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
}

-- Cataclysm factions
Q[A.BARADIN] = {
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
}
Q[H.HELLSCREAM] = {
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
}
Q[H.DRAGONMAW] = {
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
}
Q[A.WILDHAMMER] = {
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
}
Q[F.EARTHEN_RING] = {
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
}
Q[F.GUARDIANS_HYJAL] = {
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
}
Q[F.RAMKAHEN] = {
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
}
Q[F.THERAZANE] = {
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
}

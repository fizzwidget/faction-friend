------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.SONS_HODIR = 1119
F.EBON_BLADE = 1098
F.ARGENT_CRUSADE = 1106
F.WYRMREST = 1091
F.KIRIN_TOR = 1090
F.ASHEN_VERDICT = 1156

local H = DB.ID.Horde

H.HORDE_EXPEDITION = 1052

local A = DB.ID.Alliance

A.ALLIANCE_VANGUARD = 1037

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.SONS_HODIR] = {
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
}
Q[F.EBON_BLADE] = {
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
}
Q[A.ALLIANCE_VANGUARD] = {
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
}
Q[F.ARGENT_CRUSADE] = {
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
}
Q[H.HORDE_EXPEDITION] = {
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
}
Q[F.KIRIN_TOR] = {
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
}
Q[F.WYRMREST] = {
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
}


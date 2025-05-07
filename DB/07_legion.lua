------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.HIGHMOUNTAIN_TRIBE = 1828
F.NIGHTFALLEN = 1859
F.DREAMWEAVERS = 1883
F.WARDENS = 1894
F.FARONDIS_COURT = 1900
F.VALARJAR = 1948
F.CONJURER_MARGOSS = 1975
F.TALONS_VENGEANCE = 2018 
F.ARMIES_LEGIONFALL = 2045
F.ARMY_OF_LIGHT = 2165
F.ARGUSSIAN_REACH = 2170
	
F.FISHERFRIEND_ILYSSIA = 2097
F.FISHERFRIEND_RAYNAE = 2098
F.FISHERFRIEND_AKULE = 2099
F.FISHERFRIEND_CORBYN = 2100
F.FISHERFRIEND_SHALETH = 2101
F.FISHERFRIEND_IMPUS = 2102

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.NIGHTFALLEN] = {
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
}
Q[F.VALARJAR] = {
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
}
Q[F.HIGHMOUNTAIN_TRIBE] = {
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
}
Q[F.DREAMWEAVERS] = {
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
}
Q[F.FARONDIS_COURT] = {
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
}
Q[F.WARDENS] = {
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
}
Q[F.ARMIES_LEGIONFALL] = {
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
}
Q[F.ARMY_OF_LIGHT] = {
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
}
Q[F.ARGUSSIAN_REACH] = {
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
}
Q[F.TALONS_VENGEANCE] = {
	MarkOfPrey = {
		value = 100,
		items = {
			[142363] = 1, -- Mark of Prey
		}
	},
}
Q[F.CONJURER_MARGOSS] = {
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
}
Q[F.FISHERFRIEND_ILYSSIA] = {
	FragmentedEnchantment_01 = {
		value = 75,
		items = {
			[146848] = 1, -- Fragmented Enchantment
		}
	},
}
Q[F.FISHERFRIEND_RAYNAE] = {
	CorruptedGlobule_01 = {
		value = 75,
		items = {
			[146959] = 1, -- Corrupted Globule
		}
	},
}
Q[F.FISHERFRIEND_AKULE] = {
	AncientTotemFragment_01 = {
		value = 75,
		items = {
			[146960] = 1, -- Ancient Totem Fragment
		}
	},
}
Q[F.FISHERFRIEND_CORBYN] = {
	ShinyBauble_01 = {
		value = 75,
		items = {
			[146961] = 1, -- Shiny Bauble
		}
	},
}
Q[F.FISHERFRIEND_SHALETH] = {
	GoldenMinnow_01 = {
		value = 75,
		items = {
			[146962] = 1, -- Golden Minnow
		}
	},
}
Q[F.FISHERFRIEND_IMPUS] = {
	DesecratedSeaweed_01 = {
		value = 75,
		items = {
			[146963] = 1, -- Desecrated Seaweed
		}
	},
}

------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.STEAMWHEEDLE_SOCIETY = 1711
F.ARAKKOA_OUTCASTS = 1515
F.AWAKENED_ORDER = 1849
F.SABERSTALKERS = 1850
F.NAT_PAGLE_GARRISON = 1358

local H = DB.ID.Horde

H.VOLJIN_HEADHUNTERS = 1848
H.VOLJINS_SPEAR = 1681
H.FROSTWOLF_ORCS = 1445
H.LAUGHING_SKULL = 1708

local A = DB.ID.Alliance

A.COUNCIL_OF_EXARCHS = 1731
A.HAND_OF_PROPHET = 1847
A.SHATARI_DEFENSE = 1710
A.WRYNNS_VANGUARD = 1682

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.STEAMWHEEDLE_SOCIETY] = {
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
}
Q[F.ARAKKOA_OUTCASTS] = {
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
}
Q[F.AWAKENED_ORDER] = {
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
}
Q[F.SABERSTALKERS] = {
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
}
Q[F.NAT_PAGLE_GARRISON] = {
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
}
Q[H.VOLJIN_HEADHUNTERS] = {
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
}
Q[H.VOLJINS_SPEAR] = {
	MedallionOfLegion = {
		value = 1000,
		useItem = 1,
		items = {
			[128315] = 1, -- Medallion of the Legion
		}
	}
}
Q[H.FROSTWOLF_ORCS] = {
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
}
Q[H.LAUGHING_SKULL] = {
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
}
Q[A.COUNCIL_OF_EXARCHS] = {
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
}
Q[A.HAND_OF_PROPHET] = {
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
}
Q[A.SHATARI_DEFENSE] = {
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
}
Q[A.WRYNNS_VANGUARD] = {
	MedallionOfLegion = {
		value = 1000,
		useItem = 1,
		items = {
			[128315] = 1, -- Medallion of the Legion
		}
	}
}

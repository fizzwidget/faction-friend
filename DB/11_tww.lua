------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
local DB = _G[addonName.."_DB"]

------------------------------------------------------
-- Faction IDs
------------------------------------------------------

local F = DB.ID.Neutral

F.GENERAL = 2605
F.VIZIER = 2607
F.WEAVER = 2601

------------------------------------------------------
-- For item tooltips and potential rep gain calculation
-- Quest names starting with ZZ_ are order dependent; 
-- check for creatable items before checking what those items are worth
------------------------------------------------------
local Q = DB.TurninsByQuest
	
Q[F.GENERAL] = {
	Commendation = {
		value = 1500,
		items = {
			[237014] = 1, -- Severed Threads Commendation
		}
	},
}
Q[F.VIZIER] = {
	Commendation = {
		value = 1500,
		items = {
			[237014] = 1, -- Severed Threads Commendation
		}
	},
}
Q[F.WEAVER] = {
	Commendation = {
		value = 1500,
		items = {
			[237014] = 1, -- Severed Threads Commendation
		}
	},
}

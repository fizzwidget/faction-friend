------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (any localized names are all in comments)
------------------------------------------------------

local addonName, _ = ...
_G[addonName.."_DB"] = {}
local DB = _G[addonName.."_DB"]
DB.ID = {}
DB.ID.Neutral = {}
DB.ID.Horde = {}
DB.ID.Alliance = {}
DB.TurninsByQuest = {}

------------------------------------------------------
-- For bodyguard switching option
------------------------------------------------------
DB.BodyguardFactionID = {
	[1739] = 1, -- Vivianne
	[1736] = 1, -- Tormmok
	[1737] = 1, -- Ishaal
	[1741] = 1, -- Leorajh
	[1733] = 1, -- Ironfist
	[1738] = 1, -- Illona
	[1740] = 1, -- Brightdawn
}

------------------------------------------------------
-- For currency ignore option
------------------------------------------------------
DB.TimeLimitedPurchase = {
	["currency:1166"] = 1, -- Timewarped Badge
	["currency:2588"] = 1, -- Riders of Azeroth Badge
}

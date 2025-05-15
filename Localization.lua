------------------------------------------------------
-- Localization.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------
-- This file contains strings shown in FactionFriend's UI; all features still work if these aren't localized.
------------------------------------------------------
-- Setup for shorthand when defining strings and automatic lookup in settings
local addonName = ...
_G[addonName.."_Locale"] = {}
local Locale = _G[addonName.."_Locale"]
Locale.Text = {}
Locale.Setting = {}
Locale.SettingTooltip = {}
local L = Locale.Text
local S = Locale.Setting
local T = Locale.SettingTooltip
------------------------------------------------------

FFF_UNKNOWN_ITEM				= "(Item #%d)"
FFF_REPUTATION_TICK_TOOLTIP		= "%d reputation points available:"
FFF_AFTER_TURNINS_LABEL			= "After turnins:"
FFF_STANDING_VALUES 			= "%s (%d/%d)"			-- e.g. "Friendly (2150/6000)"

FFF_FACTION_STANDING			= "%s (%s)" -- e.g. "Ratchet (Neutral)"
FFF_REPEAT_TURNINS				= "(%.1f more times to %s.)"
FFF_MAXIMUM						= "maximum"
FFF_NEXT_RANK					= "next rank"
FFF_PARAGON_REWARD				= "reward"
FFF_AT_MAXIMUM					= "(At maximum.)"
FFF_TOOLTIP_CLICK_FOR_DETAILS	= "<Click to view details>"
FFF_TOOLTIP_DONT_CLICK			= "<Unavailable while in combat>"
FFF_REPORT_LINE_ITEM			= "%dx %s"				-- C in example below
FFF_REPORT_NUM_TURNINS			= " (%d turnins)"		-- B in example below
FFF_REPORT_NUM_POINTS			= "%d points"			-- A in example below
FFF_COUNT_IN_BANK				= "%d in bank"			-- D in example below
FFF_COUNT_IN_REAGENTS			= "%d in reagent bank"	-- D in example below
FFF_COUNT_IN_WARBAND			= "%d in warband"		-- D in example below
FFF_COUNT_CREATED				= "%d from turnins"		-- E in example below
FFF_ALL_CREATED					= "from turnins"		-- F in example below
FFF_REPORT_PURCHASE				= "Buy %dx %s"
FFF_COUNT_PURCHASED				= "%d purchased"
FFF_ALL_PURCHASED				= "purchased" 

-- example 1:
--	100 points (2 turnins):		20x [Invader's Scourgestone] (13 in bank)
--  |---A----||----B-----|		|------------C-------------|  |---D----|
--	300 points:		3x [Argent Dawn Valor Token] (1 in bank, 2 from turnins)
--  |---A----|		|------------C-------------|  |---D---|  |-----E------|
-- example 2:
--	150 points:		2x [Blue Hakkari Bijou]
--  |---A----|		|----------C----------|
--	100 points:		2x [Zandalar Honor Token] (from turnins)
--  |---A----|		|------------C----------|  |----F-----|

-- Item Tooltip
FFF_FACTION_TURNIN				= "Reputation turnin for"

-- ReputationWatchBar menu
FFF_RECENT_FACTIONS				= "Recent factions"
FFF_SHOW_REPUTATION_PANE		= "Show Reputation Pane"
FFF_SHOW_OPTIONS				= "Show FactionFriend Settings"

-- Reputation frame additions
FFF_EXPAND_ALL					= "Expand All Headers"
FFF_COLLAPSE_ALL				= "Collapse All Headers"
FFF_EXPAND_SUBHEADERS_HINT		= "<Hold %s to expand subheaders>"
FFF_COLLAPSE_SUBHEADERS_HINT	= "<Hold %s to collapse subheaders>"
FFF_EXPAND_INACTIVE_HINT		= "<Hold %s to expand Inactive>"
FFF_CLEAN_UP_FACTIONS			= "Clean Up Completed Factions"
FFF_CLEAN_UP_FACTIONS_TIP		= "Moves factions with maximum reputation to Inactive"
FFF_CLEAN_UP_FACTIONS_LIST		= "%d factions to clean up:"


-- Settings panel

S.Tooltip				= "Enhance item tooltips"
T.Tooltip				= "Adds info to tooltips for items that can be turned in or used to gain reputation"
S.ModifyChat			= "Enhance chat window output"
T.ModifyChat			= "Adds info to reputation messages in chat windows, including an estimated number of repeated reputation gains until the next rank/reward. (Use chat window settings to enable reputation messages.) "
S.CleanUpOnComplete		= "Hide factions when completed"
T.CleanUpOnComplete		= "Automatically moves factions to Inactive upon reaching maximum reputation, friendship, or renown (excludes “paragon” factions with repeatable rewards for continued gains at maximum rank)" 
S.HighlightItems		= "Highlight reputation items"
T.HighlightItems		= "Makes items that can be turned in or used for reputation gain more visible in the default UI's bag, bank, and loot frames (similar to the default highlight for quest items)" 

S.Heading_Potential		= "Potential reputation gain" 
T.Heading_Potential		= "Estimated amount of reputation possible from items and currency in your inventory, visible in the Character window's Reputation pane and faction tooltips"
	
S.ShowPotential			= "Show on reputation watch bar"
T.ShowPotential			= "Adds shading to the reputation watch bar indicating potential gain with the watched faction"
S.IncludeTimewarped		= "Include time-limited purchases"
T.IncludeTimewarped		= "Uncheck to ignore reputation from purchasing faction items that are available only during recurring events (Timewalking, Riders of Azeroth)"

S.Heading_RepPane		= "Reputation pane"
T.Heading_RepPane		= "Settings related to the Character window's Reputation pane"
	
S.AddRepPaneControls	= "Enhanced faction list controls"
T.AddRepPaneControls	= "Adds a cleanup button, search bar, and expand/collapse-all buttons to the top of the Reputation pane." 
S.HighlightFactions		= "Highlight exploitable factions"
T.HighlightFactions		= "Shows an icon next to factions you can increase using items and currency in your inventory. (Also applies to the reputation watch bar context menu.)" 

S.Heading_Watchbar		= "Reputation watch bar" 
T.Heading_Watchbar		= "Settings related to the default UI's reputation tracking bar (enabled through “%s” in the Character window's Reputation pane)"
-- Quoted substitution is base UI localized string MAJOR_FACTION_WATCH_FACTION_BUTTON_LABEL

S.RepGained				= "Update for reputation gains"
T.RepGained				= "When gaining reputation, switches the reputation watch bar to the affected faction (and shows it if hidden)"
S.IncludeGuild			= "Include guild"
T.IncludeGuild			= "Uncheck to disable automatic watch bar switching for guild reputation. (Useful if you're gaining other reputations at the same time as guild reputation.)"
S.IncludeBodyguards		= "Include bodyguards"
T.IncludeBodyguards		= "Uncheck to disable automatic watch bar switching for Barracks Bodyguards reputations in Warlords of Draenor. (Useful if you're gaining other reputations at the same time as bodyguard reputation.)"
S.EnableMenu			= "Right-click for menu"
T.EnableMenu			= "Adds a context menu to the reputation watch bar allowing you to quickly switch which faction it tracks."
S.MenuContent_Both		= "Recent factions + faction list"
T.MenuContent_Both		= "Shows factions recently tracked or with recent reputation changes, plus all factions currently visible in the Reputation pane. (For a simpler menu, collapse headers or move factions to Inactive.)"
S.MenuContent_Recent	= "Recent factions"
T.MenuContent_Recent	= "Shows factions recently tracked or with recent reputation changes."
S.MenuContent_List		= "Faction list"
T.MenuContent_List		= "Shows all factions currently visible in the Reputation pane. (For a simpler menu, collapse headers or move factions to Inactive.)"
S.MenuContent_None		= "No factions"
T.MenuContent_None		= "Shows only commands."

------------------------------------------------------

if (GetLocale() == "deDE") then
	
FFF_UNKNOWN_ITEM				= "(Unbekannter Gegenstand #%d)"
FFF_REPUTATION_TICK_TOOLTIP		= "%d Rufpunkte möglich:"
FFF_AFTER_TURNINS_LABEL			= "Nach Abgabe:"
FFF_AFTER_TURNINS_INFO			= "%s (%d/%d)"			-- e.g. "Friendly (2150/6000)"

FFF_REPORT_LINE_ITEM			= "%dx %s"				-- C in example below
FFF_REPORT_NUM_TURNINS			= " (%d Abgaben)"		-- B in example below
FFF_REPORT_NUM_POINTS			= "%d Punkte"			-- A in example below 
FFF_COUNT_IN_BANK				= " (%d auf der Bank)"	-- D in example below
FFF_COUNT_CREATED				= "%d von Abgaben"		-- E in example below
FFF_ALL_CREATED					= "von Abgaben"			-- F in example below

-- Item Tooltip
FFF_FACTION_TURNIN				= "Ruf-Abgabe für"

-- ReputationWatchBar menu
FFF_SHOW_REPUTATION_PANE		= "Zeige Ruf Balken"
FFF_SHOW_OPTIONS				= "Zeige FactionFriend Optionen"

end

------------------------------------------------------

if (GetLocale() == "frFR") then

FFF_UNKNOWN_ITEM					= "(Objet inconnu #%d)"
FFF_REPUTATION_TICK_TOOLTIP			= "%d points de réputation disponibles:"
FFF_AFTER_TURNINS_LABEL				= "Après retour:"
FFF_AFTER_TURNINS_INFO				= "%s (%d/%d)"
FFF_REPEAT_TURNINS					= "(%.1f gains équivalents pour atteindre le rang %s.)"
FFF_MAXIMUM							= "maximum";
FFF_NEXT_RANK						= "suivant"

FFF_REPORT_LINE_ITEM				= "%dx %s"
FFF_REPORT_NUM_TURNINS				= " (%d retours)"
FFF_REPORT_NUM_POINTS				= "%d points"
FFF_COUNT_IN_BANK					= "%d en banque"
FFF_COUNT_CREATED					= "%d en retour"
FFF_ALL_CREATED						= "en retour"
FFF_REPORT_PURCHASE					= "Achat %dx %s avec"
FFF_COUNT_PURCHASED					= "%d acheté"
FFF_ALL_PURCHASED					= "acheté" 

-- Item Tooltip
FFF_FACTION_TURNIN					= "Gain de réputation envers"

-- ReputationWatchBar menu

FFF_RECENT_FACTIONS					= "Dernières factions affichées"
FFF_SHOW_REPUTATION_PANE			= "Affiche l'onglet des réputations"
FFF_SHOW_OPTIONS					= "Options de FactionFriend"

end

------------------------------------------------------

if (GetLocale() == "esES" or GetLocale() == "esMX") then

-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH   = "No cambie de barras para la reputación guardaespaldas"

-- localizers: copy the rest from enUS at the top
	
end

------------------------------------------------------

if (GetLocale() == "ptBR") then

-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH 			= "Não ligue bar para a reputação guarda-costas"

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

if (GetLocale() == "ruRU") then

-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH 			= "Не включайте планку для телохранителя репутации"

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

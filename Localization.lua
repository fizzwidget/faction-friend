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

L.RankWithValues 		= "%s (%d/%d)"			-- e.g. "Friendly (2150/6000)"

-- Chat message repeat gains estimate
L.RepeatTurnins			= "(%d more times to %s.)"
L.Maximum				= "maximum"
L.NextRank				= "next rank"
L.ParagonReward			= "reward"
L.AtMaximum				= "(At maximum.)"

-- HoverTips faction tooltip integration
L.ClickForDetails		= "<Click to view details>"
L.NoClickInCombat		= "<Unavailable while in combat>"

-- Potential gains report in faction tooltips
L.UnknownItem			= "(Item #%d)"
L.TotalPotentialLabel	= "%d reputation points available:"
L.AfterTurninsLabel		= "After turnins:"
L.ReportLineItem		= "%dx %s"				-- C in example below
L.ReportNumTurnins		= " (%d turnins)"		-- B in example below
L.ReportPoints			= "%d points"			-- A in example below
L.CountInBank			= "%d in bank"			-- D in example below
L.CountInReagents		= "%d in reagent bank"	-- D in example below
L.CountInWarband		= "%d in warband"		-- D in example below
L.CountCreated			= "%d from turnins"		-- E in example below
L.AllCreated			= "from turnins"		-- F in example below
L.ReportPurchase		= "Buy %dx %s"
L.CountPurchased		= "%d purchased"
L.AllPurchased			= "purchased" 

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
L.TurninForFaction		= "Reputation turnin for"

-- ReputationWatchBar menu
L.RecentFactions		= "Recent factions"
L.ShowReputation		= "Show Reputation Pane"
L.ShowSettings			= "Show FactionFriend Settings"

-- Reputation frame additions
L.ExpandAll				= "Expand All Headers"
L.CollapseAll			= "Collapse All Headers"
L.ExpandSubheaders		= "<Hold %s to expand subheaders>"
L.CollapseSubheaders	= "<Hold %s to collapse subheaders>"
L.ExpandInactive		= "<Hold %s to expand Inactive>"
L.CleanUpButtonLabel	= "Clean Up Completed Factions"
L.CleanUpButtonTip		= "Moves factions with maximum reputation to Inactive"
L.CleanUpSummary		= "%d factions to clean up:"


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
	
L.UnknownItem			= "(Unbekannter Gegenstand #%d)"
L.TotalPotentialLabel	= "%d Rufpunkte möglich:"
L.AfterTurninsLabel		= "Nach Abgabe:"
L.RankWithValues		= "%s (%d/%d)"			-- e.g. "Friendly (2150/6000)"

L.ReportLineItem		= "%dx %s"				-- C in example below
L.ReportNumTurnins		= " (%d Abgaben)"		-- B in example below
L.ReportPoints			= "%d Punkte"			-- A in example below 
L.CountInBank			= " (%d auf der Bank)"	-- D in example below
L.CountCreated			= "%d von Abgaben"		-- E in example below
L.AllCreated			= "von Abgaben"			-- F in example below

-- Item Tooltip
L.TurninForFaction		= "Ruf-Abgabe für"

-- ReputationWatchBar menu
L.ShowReputation		= "Zeige Ruf Balken"
L.ShowSettings			= "Zeige FactionFriend Optionen"

end

------------------------------------------------------

if (GetLocale() == "frFR") then

L.UnknownItem			= "(Objet inconnu #%d)"
L.TotalPotentialLabel	= "%d points de réputation disponibles:"
L.AfterTurninsLabel		= "Après retour:"
L.RankWithValues		= "%s (%d/%d)"
L.RepeatTurnins			= "(%d gains équivalents pour atteindre le rang %s.)"
L.Maximum				= "maximum";
L.NextRank				= "suivant"

L.ReportLineItem		= "%dx %s"
L.ReportNumTurnins		= " (%d retours)"
L.ReportPoints			= "%d points"
L.CountInBank			= "%d en banque"
L.CountCreated			= "%d en retour"
L.AllCreated			= "en retour"
L.ReportPurchase		= "Achat %dx %s avec"
L.CountPurchased		= "%d acheté"
L.AllPurchased			= "acheté" 

-- Item Tooltip
L.TurninForFaction		= "Gain de réputation envers"

-- ReputationWatchBar menu

L.RecentFactions		= "Dernières factions affichées"
L.ShowReputation		= "Affiche l'onglet des réputations"
L.ShowSettings			= "Options de FactionFriend"

end

------------------------------------------------------

if (GetLocale() == "esES" or GetLocale() == "esMX") then

-- localizers: copy the rest from enUS at the top
	
end

------------------------------------------------------

if (GetLocale() == "ptBR") then

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

if (GetLocale() == "ruRU") then

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

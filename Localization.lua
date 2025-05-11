------------------------------------------------------
-- Localization.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------
-- This file contains strings shown in FactionFriend's UI; all features still work if these aren't localized.
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

-- Settings panel

FFF_OPTION_TOOLTIP				= "Enhance item tooltips"
FFF_OPTION_TOOLTIP_TIP			= "Adds info to tooltips for items that can be turned in or used to gain reputation"
FFF_OPTION_MODIFY_CHAT			= "Enhance chat window output"
FFF_OPTION_MODIFY_CHAT_TIP		= "Adds info to reputation messages in chat windows, including an estimated number of repeated reputation gains until the next rank/reward. (Use chat window settings to enable reputation messages.) "
FFF_OPTION_MOVE_EXALTED			= "Hide factions when completed"
FFF_OPTION_MOVE_EXALTED_TIP		= "Automatically moves factions to Inactive upon reaching maximum reputation, friendship, or renown (excludes “paragon” factions with repeatable rewards for continued gains at maximum rank)" 
FFF_OPTION_HIGHLIGHT_ITEMS		= "Highlight reputation items"
FFF_OPTION_HIGHLIGHT_ITEMS_TIP	= "Makes items that can be turned in or used for reputation gain more visible in the default UI's bag, bank, and loot frames (similar to the default highlight for quest items)" 


FFF_OPTIONS_POTENTIAL			= "Potential reputation gain"
FFF_OPTIONS_POTENTIAL_TIP		= "Estimated amount of reputation possible from items and currency in your inventory, visible in the Character window's Reputation pane and faction tooltips"

FFF_OPTION_SHOW_POTENTIAL		= "Show on reputation watch bar"
FFF_OPTION_SHOW_POTENTIAL_TIP	= "Adds shading to the reputation watch bar indicating potential gain with the watched faction"
FFF_OPTION_TIMEWARPED			= "Include time-limited purchases"
FFF_OPTION_TIMEWARPED_TIP		= "Uncheck to ignore reputation from purchasing faction items that are available only during recurring events (Timewalking, Riders of Azeroth)"


FFF_OPTIONS_REP_PANE			= "Reputation pane"
FFF_OPTIONS_REP_PANE_TIP		= "Settings related to the Character window's Reputation pane"

FFF_OPTION_ADD_CONTROLS			= "Enhanced faction list controls"
FFF_OPTION_ADD_CONTROLS_TIP		= "Adds a cleanup button, search bar, and expand/collapse-all buttons to the top of the Reputation pane." 
FFF_OPTION_HIGHLIGHT			= "Highlight exploitable factions"
FFF_OPTION_HIGHLIGHT_TIP		= "Shows an icon next to factions you can increase using items and currency in your inventory. (Also applies to the reputation watch bar context menu.)" 


FFF_OPTIONS_WATCHBAR			= "Reputation watch bar"
FFF_OPTIONS_WATCHBAR_TIP		= "Settings related to the default UI's reputation tracking bar (enabled through “%s” in the Character window's Reputation pane)"
-- quoted substitution is base UI localized string MAJOR_FACTION_WATCH_FACTION_BUTTON_LABEL

FFF_OPTION_REP_GAINED			= "Update for reputation gains"
FFF_OPTION_REP_GAINED_TIP		= "When gaining reputation, switches the reputation watch bar to the affected faction (and shows it if hidden)"
FFF_OPTION_GUILD_SWITCH			= "Include guild"
FFF_OPTION_GUILD_SWITCH_TIP		= "Uncheck to disable automatic watch bar switching for guild reputation. (Useful if you're gaining other reputations at the same time as guild reputation.)"
FFF_OPTION_BODYGUARD_SWITCH 	= "Include bodyguards"
FFF_OPTION_BODYGUARD_SWITCH_TIP	= "Uncheck to disable automatic watch bar switching for Barracks Bodyguards reputations in Warlords of Draenor. (Useful if you're gaining other reputations at the same time as bodyguard reputation.)"
FFF_OPTION_ENABLE_MENU			= "Right-click for menu"
FFF_OPTION_ENABLE_MENU_TIP		= "Adds a context menu to the reputation watch bar allowing you to quickly switch which faction it tracks."
FFF_OPTION_MENU_FULL_RECENT		= "Recent factions + faction list"
FFF_OPTION_MENU_FULL_RECENT_TIP	= "Shows factions recently tracked or with recent reputation changes, plus all factions currently visible in the Reputation pane. (For a simpler menu, collapse headers or move factions to Inactive.)"
FFF_OPTION_MENU_RECENT			= "Recent factions"
FFF_OPTION_MENU_RECENT_TIP		= "Shows factions recently tracked or with recent reputation changes."
FFF_OPTION_MENU_FULL			= "Faction list"
FFF_OPTION_MENU_FULL_TIP		= "Shows all factions currently visible in the Reputation pane. (For a simpler menu, collapse headers or move factions to Inactive.)"
FFF_OPTION_MENU_NONE			= "No factions"
FFF_OPTION_MENU_NONE_TIP		= "Shows only commands."

FFF_OPTIONS_TIPS				= "Tip: For a simpler menu, use the Reputation pane to mark factions as inactive."

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
-- example usage:
--    100 points (4 turnins):        40x [Invader's Scourgestone] (13 in bank)
--  |---A----||----B-----|        |------------C-------------||-----D-----| 

-- Options panel

FFF_OPTIONS						= "FactionFriend Optionen"
FFF_OPTIONS_SWITCHBAR			= "Zeige/wechsel die Rufleiste:"
FFF_OPTION_ZONES				= "Wenn man Gebiete mit Fraktionsaufgaben betritt."
FFF_OPTION_REP_GAINED			= "Wenn man Ruf bei einer Fraktion erhält."
FFF_OPTION_SHOW_POTENTIAL		= "Zeige geschätzten Rufgewinn durch Abgaben."
FFF_OPTION_TOOLTIP				= "Zeige Ruf-Abgabe Informationen im Tooltip"
-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH = "Nicht bar für Leibwächter Ruf wechseln"

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

-- Options panel

FFF_OPTIONS_GENERAL					= "Options générales"
FFF_OPTIONS_PROFILE					= "Options du profil"
FFF_OPTIONS_SWITCHBAR				= "Montrer/Changer de barre de réputation :"
FFF_OPTION_ZONES					= "Dans une zone avec des objectifs de faction"
FFF_OPTION_REP_GAINED				= "En gagnant de la réputation avec une faction"
FFF_OPTION_TABARD					= "En équipant un tabard de faction"
-- FFF_OPTION_NO_GUILD_AUTOSWITCH		= "Cacher la barre de réputation de guilde"
-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH 	= "Cacher la barre de réputation de garde du corps"
FFF_OPTION_SHOW_POTENTIAL			= "Gain de réputation pour les retours d'objets"
FFF_OPTION_SHOW_POTENTIAL_TIP		= "Ajoute un indicateur à la barre de réputation affichée montrant le gain de réputation gagné en utilisant les objets en sa possession."
FFF_OPTION_USE_CURRENCY				= "Ajoute les gains potentiels de réputation via les achats"
FFF_OPTION_TOOLTIP					= "Informations de réputation sur les objets"
FFF_OPTION_REPEAT_GAINS				= "Réputation manquante pour changer de niveau"
FFF_OPTION_REPEAT_GAINS_TIP			= "Affiche les messages de gain de réputation dans la fenêtre de chat. Affiche également le nombre de gains de réputation équivalente pour atteindre le niveau de réputation suivant."
FFF_OPTION_MOVE_EXALTED       		= "Marque les factions exaltées comme inactives"
FFF_OPTION_REPUTATION_COLORS		= "Couleurs distinctes pour chaque rang de réputation"
FFF_OPTION_COMBAT_DISABLE          	= "Désactive le menu des réputations en combat"
FFF_OPTION_COMBAT_DISABLE_TIP 		= "Clic-droit sur la barre de réputation permet de faire apparaître un menu servant à changer la faction affichée, cette option permet de le désactiver lorsque le personnage est en combat."
FFF_OPTIONS_TIPS					= "Astuce:  Pour un menu simplifié, utilisez le panneau de réputations pour marquer les réputations inactives ne devant pas s'afficher."

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

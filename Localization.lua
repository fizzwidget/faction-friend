------------------------------------------------------
-- Localization.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------
-- This file contains strings shown in FactionFriend's UI; all features still work if these aren't localized.
------------------------------------------------------

FFF_UNKNOWN_ITEM				= "(Item #%d)"
FFF_REPUTATION_TICK_TOOLTIP		= "%d reputation points available:"
FFF_AFTER_TURNINS_LABEL			= "After turnins:"
FFF_AFTER_TURNINS_INFO			= "%s (%d/%d)"			-- e.g. "Friendly (2150/6000)"

FFF_FACTION_STANDING			= "%s (%s)" -- e.g. "Ratchet (Neutral)"
FFF_REPEAT_TURNINS				= "(%.1f more times to %s.)"
FFF_MAXIMUM						= "maximum"
FFF_NEXT_RANK					= "next rank"
FFF_PARAGON_REWARD				= "reward"
FFF_AT_MAXIMUM					= "(At maximum.)"
FFF_TOOLTIP_CLICK_FOR_DETAILS	= "<Click to view details>"
FFF_TOOLTIP_DONT_CLICK			= "<Cannot click while in combat>"
FFF_REPORT_LINE_ITEM			= "%dx %s"				-- C in example below
FFF_REPORT_NUM_TURNINS			= " (%d turnins)"		-- B in example below
FFF_REPORT_NUM_POINTS			= "%d points"			-- A in example below
FFF_COUNT_IN_BANK				= "%d in bank"			-- D in example below
FFF_COUNT_CREATED				= "%d from turnins"		-- E in example below
FFF_ALL_CREATED					= "from turnins"		-- F in example below
FFF_REPORT_PURCHASE				= "Purchase %dx %s with"
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

-- Options panel

FFF_OPTIONS_GENERAL				= "General Options"
FFF_OPTIONS_PROFILE				= "Options Profile"
FFF_OPTIONS_SWITCHBAR			= "Show/switch the reputation watch bar:"
FFF_OPTION_ZONES				= "When entering certain zones"
FFF_OPTION_ZONES_TIP			= "Applies to places with closely associated reputation, like certain dungeons, raids, and battlegrounds"
FFF_OPTION_REP_GAINED			= "When gaining reputation"
FFF_OPTION_TABARD				= "When equipping tabards"
FFF_OPTION_TABARD_TIP			= "Applies to factions whose tabard provides reputation gain in dungeons"
FFF_OPTION_GUILD_AUTOSWITCH		= "Include guild reputation"
FFF_OPTION_BODYGUARD_AUTOSWITCH = "Include bodyguard reputations"
FFF_OPTION_SHOW_POTENTIAL		= "Show potential reputation gain"
FFF_OPTION_SHOW_POTENTIAL_TIP	= "Adds an indicator to the reputation watch bar showing the amount of reputation to be gained by turning in or using items"
FFF_OPTION_USE_CURRENCY			= "Include potential reputation gains from currency"
FFF_OPTION_TOOLTIP				= "Enhance item tooltips"
FFF_OPTION_TOOLTIP_TIP			= "Adds info to tooltips for items that can be turned in or used to gain reputation"
FFF_OPTION_MODIFY_CHAT			= "Enhance chat window output"
FFF_OPTION_MODIFY_CHAT_TIP		= "Adds info to reputation messages in chat windows, including an estimated number of repeated reputation gains until the next rank/reward. (Use chat window settings to enable reputation messages.) "
FFF_OPTION_MOVE_EXALTED			= "Hide Exalted factions"
FFF_OPTION_MOVE_EXALTED_TIP		= "Automatically move faction to Inactive after reaching Exalted standing" 
FFF_OPTION_REPUTATION_COLORS	= "Use distinct colors for reputation standings"
FFF_OPTION_COMBAT_DISABLE		= "Disable reputation bar menu in combat"
FFF_OPTION_COMBAT_DISABLE_TIP	= "Right-click the reputation watch bar for a menu to change which faction it shows"
FFF_OPTIONS_TIPS				= "Tip: For a simpler menu, use the Reputation pane to mark factions as inactive."

-- Item Tooltip
FFF_FACTION_TURNIN				= "Reputation turnin for"

-- ReputationWatchBar menu
FFF_RECENT_FACTIONS				= "Recent factions"
FFF_SHOW_REPUTATION_PANE		= "Show Reputation Pane"
FFF_SHOW_OPTIONS				= "Show FactionFriend Options"

-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_AD_TOKEN				= "Argent Dawn Valor Token"
FFF_ITEM_ZG_TOKEN				= "Zandalar Honor Token"
FFF_ITEM_KIRIN_TOR_BADGE             = "Kirin Tor Commendation Badge"
FFF_ITEM_WYRMREST_BADGE              = "Wyrmrest Commendation Badge"
FFF_ITEM_ARGENT_CRUSADE_BADGE        = "Argent Crusade Commendation Badge"
FFF_ITEM_EBON_BLADE_BADGE            = "Ebon Blade Commendation Badge"
FFF_ITEM_NELF_BADGE                  = "Darnassus Commendation Badge"
FFF_ITEM_DRAENEI_BADGE               = "Exodar Commendation Badge"
FFF_ITEM_GNOME_BADGE                 = "Gnomeregan Commendation Badge"
FFF_ITEM_DWARF_BADGE                 = "Ironforge Commendation Badge"
FFF_ITEM_HUMAN_BADGE                 = "Stormwind Commendation Badge"
FFF_ITEM_ORC_BADGE                   = "Orgrimmar Commendation Badge"
FFF_ITEM_TROLL_BADGE                 = "Sen'jin Commendation Badge"
FFF_ITEM_BELF_BADGE                  = "Silvermoon Commendation Badge"
FFF_ITEM_TAUREN_BADGE                = "Thunder Bluff Commendation Badge"
FFF_ITEM_FORSAKEN_BADGE              = "Undercity Commendation Badge"
FFF_ITEM_SONS_HODIR_BADGE            = "Sons of Hodir Commendation Badge"
FFF_ITEM_BARADIN_COMMENDATION        = "Baradin's Wardens Commendation"
FFF_ITEM_HELLSCREAM_COMMENDATION	 = "Hellscream's Reach Commendation"
FFF_ITEM_NELF_WRIT                   = "Darnassus Writ of Commendation"
FFF_ITEM_DRAENEI_WRIT                = "Exodar Writ of Commendation"
FFF_ITEM_GNOME_WRIT                  = "Gnomeregan Writ of Commendation"
FFF_ITEM_DWARF_WRIT                  = "Ironforge Writ of Commendation"
FFF_ITEM_ORC_WRIT                    = "Orgrimmar Writ of Commendation"
FFF_ITEM_TROLL_WRIT                  = "Sen'jin Writ of Commendation"
FFF_ITEM_BELF_WRIT                   = "Silvermoon Writ of Commendation"
FFF_ITEM_HUMAN_WRIT                  = "Stormwind Writ of Commendation"
FFF_ITEM_TAUREN_WRIT                 = "Thunder Bluff Writ of Commendation"
FFF_ITEM_FORSAKEN_WRIT               = "Undercity Writ of Commendation"
FFF_ITEM_WORGEN_WRIT                 = "Gilneas Writ of Commendation"
FFF_ITEM_GOBLIN_WRIT                 = "Bilgewater Writ of Commendation"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Sunreaver Onslaught Insignia" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Greater Sunreaver Onslaught Insignia"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Kirin Tor Offensive Insignia" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Greater Kirin Tor Offensive Insignia"

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
	
-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_AD_TOKEN					= "Ehrenmarke der Argentumdämmerung"
FFF_ITEM_ZG_TOKEN					= "Ehrenmünze der Zandalari"
FFF_ITEM_KIRIN_TOR_BADGE             = "Belobigungsabzeichen der Kirin Tor"
FFF_ITEM_WYRMREST_BADGE              = "Belobigungsabzeichen des Wyrmruhpakts"
FFF_ITEM_ARGENT_CRUSADE_BADGE        = "Belobigungsabzeichen des Argentumkreuzzugs"
FFF_ITEM_EBON_BLADE_BADGE            = "Belobigungsabzeichen der Schwarzen Klinge"
FFF_ITEM_NELF_BADGE                  = "Belobigungsabzeichen von Darnassus"
FFF_ITEM_DRAENEI_BADGE               = "Belobigungsabzeichen der Exodar"
FFF_ITEM_GNOME_BADGE                 = "Belobigungsabzeichen von Gnomeregan"
FFF_ITEM_DWARF_BADGE                 = "Belobigungsabzeichen von Eisenschmiede"
FFF_ITEM_HUMAN_BADGE                 = "Belobigungsabzeichen von Sturmwind"
FFF_ITEM_ORC_BADGE                   = "Belobigungsabzeichen von Orgrimmar"
FFF_ITEM_TROLL_BADGE                 = "Belobigungsabzeichen von Sen'jin"
FFF_ITEM_BELF_BADGE                  = "Belobigungsabzeichen von Silbermond"
FFF_ITEM_TAUREN_BADGE                = "Belobigungsabzeichen von Donnerfels"
FFF_ITEM_FORSAKEN_BADGE              = "Belobigungsabzeichen von Unterstadt"
FFF_ITEM_SONS_HODIR_BADGE            = "Belobigungsabzeichen der Söhne von Hodir"
FFF_ITEM_BARADIN_COMMENDATION        = "Belobigungsabzeichen der Wächter von Baradin"
FFF_ITEM_HELLSCREAM_COMMENDATION	 = "Belobigungsabzeichen von Höllschreis Hand"
FFF_ITEM_NELF_WRIT                   = "Empfehlungsschreiben von Darnassus"
FFF_ITEM_DRAENEI_WRIT                = "Empfehlungsschreiben der Exodar"
FFF_ITEM_GNOME_WRIT                  = "Empfehlungsschreiben von Gnomeregan"
FFF_ITEM_DWARF_WRIT                  = "Empfehlungsschreiben von Eisenschmiede"
FFF_ITEM_ORC_WRIT                    = "Empfehlungsschreiben von Orgrimmar"
FFF_ITEM_TROLL_WRIT                  = "Empfehlungsschreiben von Sen'jin"
FFF_ITEM_BELF_WRIT                   = "Empfehlungsschreiben von Silbermond"
FFF_ITEM_HUMAN_WRIT                  = "Empfehlungsschreiben von Sturmwind"
FFF_ITEM_TAUREN_WRIT                 = "Empfehlungsschreiben von Donnerfels"
FFF_ITEM_FORSAKEN_WRIT               = "Empfehlungsschreiben von Unterstadt"
FFF_ITEM_WORGEN_WRIT                 = "Empfehlungsschreiben von Gilneas"
FFF_ITEM_GOBLIN_WRIT                 = "Empfehlungsschreiben von Bilgewasser"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Insigne des Sonnenhäscheransturms" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Großes Insigne des Sonnenhäscheransturms"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Insigne der Offensive der Kirin Tor" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Großes Insigne der Offensive der Kirin Tor"

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
	
-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_AD_TOKEN							= "Marque de valeur de l'Aube d'Argent"
FFF_ITEM_ZG_TOKEN							= "Marque d'honneur Zandalar"
FFF_ITEM_KIRIN_TOR_BADGE					= "Ecusson de mérite du Kirin Tor"
FFF_ITEM_WYRMREST_BADGE						= "Ecusson de mérite du Repos du ver"
FFF_ITEM_ARGENT_CRUSADE_BADGE				= "Ecusson de mérite de la Croisade d'argent"
FFF_ITEM_EBON_BLADE_BADGE					= "Ecusson de mérite de la Lame d'ébène"
FFF_ITEM_NELF_BADGE							= "Ecusson de mérite de Darnassus"
FFF_ITEM_DRAENEI_BADGE						= "Ecusson de mérite de l'Exodar"
FFF_ITEM_GNOME_BADGE						= "Ecusson de mérite de Gnomeregan"
FFF_ITEM_DWARF_BADGE						= "Ecusson de mérite de Forgefer"
FFF_ITEM_HUMAN_BADGE						= "Ecusson de mérite de Hurlevent"
FFF_ITEM_ORC_BADGE							= "Ecusson de mérite d'Orgrimmar"
FFF_ITEM_TROLL_BADGE						= "Ecusson de mérite de Sen'jin"
FFF_ITEM_BELF_BADGE							= "Ecusson de mérite de Lune-d’Argent"
FFF_ITEM_TAUREN_BADGE						= "Ecusson de mérite des Pitons-du-Tonnerre"
FFF_ITEM_FORSAKEN_BADGE						= "Ecusson de mérite de Fossoyeuse"
FFF_ITEM_SONS_HODIR_BADGE					= "Ecusson de mérite des Fils de Hodir"
FFF_ITEM_BARADIN_COMMENDATION				= "Recommandation des Gardiens de Baradin"
FFF_ITEM_HELLSCREAM_COMMENDATION			= "Recommandation du Poing de Hurlenfer"
FFF_ITEM_NELF_WRIT							= "Commission de recommandation de Darnassus"
FFF_ITEM_DRAENEI_WRIT						= "Commission de recommandation de l’Exodar"
FFF_ITEM_GNOME_WRIT							= "Commission de recommandation de Gnomeregan"
FFF_ITEM_DWARF_WRIT							= "Commission de recommandation de Forgefer"
FFF_ITEM_ORC_WRIT							= "Commission de recommandation d’Orgrimmar"
FFF_ITEM_TROLL_WRIT							= "Commission de recommandation de Sen’jin"
FFF_ITEM_BELF_WRIT							= "Commission de recommandation de Lune-d’Argent"
FFF_ITEM_HUMAN_WRIT							= "Commission de recommandation de Hurlevent"
FFF_ITEM_TAUREN_WRIT						= "Commission de recommandation des Pitons-du-Tonnerre"
FFF_ITEM_FORSAKEN_WRIT						= "Commission de recommandation de Fossoyeuse"
FFF_ITEM_WORGEN_WRIT						= "Commission de recommandation de Gilnéas"
FFF_ITEM_GOBLIN_WRIT						= "Commission de recommandation de Baille-Fonds"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Insigne de l’assaut des Saccage-soleil" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Insigne supérieur de l’assaut des Saccage-soleil"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Insigne de l’offensive du Kirin Tor" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Insigne supérieur de l’offensive du Kirin Tor"

end

------------------------------------------------------

if (GetLocale() == "esES" or GetLocale() == "esMX") then

-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_AD_TOKEN					= "Muestra de valor de El Alba Argenta"
FFF_ITEM_ZG_TOKEN					= "Muestra de honor Zandalar"
FFF_ITEM_KIRIN_TOR_BADGE             = "Distintivo de mención del Kirin Tor"
FFF_ITEM_WYRMREST_BADGE              = "Distintivo de mención del Reposo del Dragón"
FFF_ITEM_ARGENT_CRUSADE_BADGE        = "Distintivo de mención de la Cruzada Argenta"
FFF_ITEM_EBON_BLADE_BADGE            = "Distintivo de mención de la Espada de Ébano"
FFF_ITEM_NELF_BADGE                  = "Distintivo de mención de Darnassus"
FFF_ITEM_DRAENEI_BADGE               = "Distintivo de mención de El Exodar"
FFF_ITEM_GNOME_BADGE                 = "Distintivo de mención de Gnomeregan"
FFF_ITEM_DWARF_BADGE                 = "Distintivo de mención de Forjaz"
FFF_ITEM_HUMAN_BADGE                 = "Distintivo de mención de Ventormenta"
FFF_ITEM_ORC_BADGE                   = "Distintivo de mención de Orgrimmar"
FFF_ITEM_TROLL_BADGE                 = "Distintivo de mención de Sen'jin"
FFF_ITEM_BELF_BADGE                  = "Distintivo de mención de Lunargenta"
FFF_ITEM_TAUREN_BADGE                = "Distintivo de mención de Cima del Trueno"
FFF_ITEM_FORSAKEN_BADGE              = "Distintivo de mención de Entrañas"
FFF_ITEM_SONS_HODIR_BADGE            = "Distintivo de mención de los Hijos de Hodir"
FFF_ITEM_BARADIN_COMMENDATION        = "Mención de honor de los celadores de Baradin"
FFF_ITEM_HELLSCREAM_COMMENDATION	 = "Mención de honor del Mando de Grito Infernal"
FFF_ITEM_NELF_WRIT                   = "Carta de recomendación de Darnassus"
FFF_ITEM_DRAENEI_WRIT                = "Carta de recomendación de El Exodar"
FFF_ITEM_GNOME_WRIT                  = "Carta de recomendación de Gnomeregan"
FFF_ITEM_DWARF_WRIT                  = "Carta de recomendación de Forjaz"
FFF_ITEM_ORC_WRIT                    = "Carta de recomendación de Orgrimmar"
FFF_ITEM_TROLL_WRIT                  = "Carta de recomendación de Sen'jin"
FFF_ITEM_BELF_WRIT                   = "Carta de recomendación de Lunargenta"
FFF_ITEM_HUMAN_WRIT                  = "Carta de recomendación de Ventormenta"
FFF_ITEM_TAUREN_WRIT                 = "Carta de recomendación de Cima del Trueno"
FFF_ITEM_FORSAKEN_WRIT               = "Carta de recomendación de Entrañas"
FFF_ITEM_WORGEN_WRIT                 = "Carta de recomendación de Gilneas"
FFF_ITEM_GOBLIN_WRIT                 = "Carta de recomendación de Pantoque"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Insignia del Embate de los Atracasol" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Insignia superior del Embate de los Atracasol"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Insignia de la Ofensiva del Kirin Tor" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Insignia superior de la Ofensiva del Kirin Tor"
-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH   = "No cambie de barras para la reputación guardaespaldas"

-- localizers: copy the rest from enUS at the top
	
end

------------------------------------------------------

if (GetLocale() == "ptBR") then

-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_KIRIN_TOR_BADGE             = "Comenda do Kirin Tor"
FFF_ITEM_WYRMREST_BADGE              = "Comenda do Repouso das Serpes"
FFF_ITEM_ARGENT_CRUSADE_BADGE        = "Comenda da Cruzada Argêntea"
FFF_ITEM_EBON_BLADE_BADGE            = "Comenda da Lâmina de Ébano"
FFF_ITEM_NELF_BADGE                  = "Comenda de Darnassus"
FFF_ITEM_DRAENEI_BADGE               = "Comenda de Exodar"
FFF_ITEM_GNOME_BADGE                 = "Comenda de Gnomeregan"
FFF_ITEM_DWARF_BADGE                 = "Comenda de Altaforja"
FFF_ITEM_HUMAN_BADGE                 = "Comenda de Ventobravo"
FFF_ITEM_ORC_BADGE                   = "Comenda de Orgrimmar"
FFF_ITEM_TROLL_BADGE                 = "Comenda de Sen'jin"
FFF_ITEM_BELF_BADGE                  = "Comenda de Luaprata"
FFF_ITEM_TAUREN_BADGE                = "Comenda do Penhasco do Trovão"
FFF_ITEM_FORSAKEN_BADGE              = "Comenda da Cidade Baixa"
FFF_ITEM_SONS_HODIR_BADGE            = "Comenda dos Filhos de Hodir"
FFF_ITEM_BARADIN_COMMENDATION        = "Comenda dos Protetores de Baradin"
FFF_ITEM_HELLSCREAM_COMMENDATION	 = "Comenda do Punho de Grito Infernal"
FFF_ITEM_NELF_WRIT                   = "Comenda Oficial de Darnassus"
FFF_ITEM_DRAENEI_WRIT                = "Comenda Oficial da Exodar"
FFF_ITEM_GNOME_WRIT                  = "Comenda Oficial de Gnomeregan"
FFF_ITEM_DWARF_WRIT                  = "Comenda Oficial de Altaforja"
FFF_ITEM_ORC_WRIT                    = "Comenda Oficial de Orgrimmar"
FFF_ITEM_TROLL_WRIT                  = "Comenda Oficial de Sen'jin"
FFF_ITEM_BELF_WRIT                   = "Comenda Oficial de Luaprata"
FFF_ITEM_HUMAN_WRIT                  = "Comenda Oficial de Ventobravo"
FFF_ITEM_TAUREN_WRIT                 = "Comenda Oficial do Penhasco do Trovão"
FFF_ITEM_FORSAKEN_WRIT               = "Comenda Oficial da Cidade Baixa"
FFF_ITEM_WORGEN_WRIT                 = "Comenda Oficial de Guilnéas"
FFF_ITEM_GOBLIN_WRIT                 = "Comenda Oficial de Borraquilha"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Insígnia da Investida Fendessol" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Insígnia Maior da Investida Fendessol"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Insígnia da Ofensiva do Kirin Tor" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Insígnia Maior da Ofensiva do Kirin Tor"
-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH 			= "Não ligue bar para a reputação guarda-costas"

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

if (GetLocale() == "ruRU") then

-- We keep the names of these items because it's quite possible for them to show up without being cached by the WoW client.
FFF_ITEM_AD_TOKEN					= "Знак доблести Серебряного Рассвета"
FFF_ITEM_ZG_TOKEN					= "Почетный знак Зандалара"
FFF_ITEM_KIRIN_TOR_BADGE             = "Рекомендательный значок Кирин-Тора"
FFF_ITEM_WYRMREST_BADGE              = "Рекомендательный значок Храма Драконьего Покоя"
FFF_ITEM_ARGENT_CRUSADE_BADGE        = "Рекомендательный значок Серебряного Авангарда"
FFF_ITEM_EBON_BLADE_BADGE            = "Рекомендательный значок Черного Клинка"
FFF_ITEM_NELF_BADGE                  = "Рекомендательный значок Дарнаса"
FFF_ITEM_DRAENEI_BADGE               = "Рекомендательный значок Экзодара"
FFF_ITEM_GNOME_BADGE                 = "Рекомендательный значок Гномрегана"
FFF_ITEM_DWARF_BADGE                 = "Рекомендательный значок Стальгорна"
FFF_ITEM_HUMAN_BADGE                 = "Рекомендательный значок Штормграда"
FFF_ITEM_ORC_BADGE                   = "Рекомендательный значок Оргриммара"
FFF_ITEM_TROLL_BADGE                 = "Рекомендательный значок Сен'джина"
FFF_ITEM_BELF_BADGE                  = "Рекомендательный значок Луносвета"
FFF_ITEM_TAUREN_BADGE                = "Рекомендательный значок Громового Утеса"
FFF_ITEM_FORSAKEN_BADGE              = "Рекомендательный значок Подгорода"
FFF_ITEM_SONS_HODIR_BADGE            = "Рекомендательный значок Сынов Ходира"
FFF_ITEM_BARADIN_COMMENDATION        = "Рекомендательный значок защитников Тол Барада"
FFF_ITEM_HELLSCREAM_COMMENDATION	 = "Заслуги перед батальоном Адского Крика"
FFF_ITEM_NELF_WRIT                   = "Рекомендательное письмо Дарнаса"
FFF_ITEM_DRAENEI_WRIT                = "Рекомендательное письмо Экзодара"
FFF_ITEM_GNOME_WRIT                  = "Рекомендательное письмо Гномрегана"
FFF_ITEM_DWARF_WRIT                  = "Рекомендательное письмо Стальгорна"
FFF_ITEM_ORC_WRIT                    = "Рекомендательное письмо Оргриммара"
FFF_ITEM_TROLL_WRIT                  = "Рекомендательное письмо Сен'джина"
FFF_ITEM_BELF_WRIT                   = "Рекомендательное письмо Луносвета"
FFF_ITEM_HUMAN_WRIT                  = "Рекомендательное письмо Штормграда"
FFF_ITEM_TAUREN_WRIT                 = "Рекомендательное письмо Громового Утеса"
FFF_ITEM_FORSAKEN_WRIT               = "Рекомендательное письмо Подгорода"
FFF_ITEM_WORGEN_WRIT                 = "Рекомендательное письмо Гилнеаса"
FFF_ITEM_GOBLIN_WRIT                 = "Рекомендательное письмо картеля Трюмных Вод"
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA			= "Знак отличия Войск Похитителей Солнца" 
FFF_SUNREAVER_ONSLAUGHT_INSIGNIA_GREATER	= "Большой знак отличия Войск Похитителей Солнца"
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA			= "Знак отличия Армии Кирин-Тора" 
FFF_KIRIN_TOR_OFFENSIVE_INSIGNIA_GREATER	= "Большой знак отличия Армии Кирин-Тора"
-- FFF_OPTION_NO_BODYGUARD_AUTOSWITCH 			= "Не включайте планку для телохранителя репутации"

-- localizers: copy the rest from enUS at the top

end

------------------------------------------------------

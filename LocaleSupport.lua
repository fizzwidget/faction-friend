------------------------------------------------------
-- LocaleSupport.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------
-- This file contains strings which must be localized in order for FactionFriend features to work in other locales.
-- Note: strings which are the same as in the enUS version needn't be localized; they can be commented out.
------------------------------------------------------

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV             			= "Alterac Valley"
ZONE_AB             			= "Arathi Basin"
ZONE_WSG            			= "Warsong Gulch"
ZONE_SILITHUS       			= "Silithus"
ZONE_AQ20           			= "Ruins of Ahn'Qiraj"
ZONE_AQ40           			= "Ahn'Qiraj" -- TODO: temple?
ZONE_FELWOOD					= "Felwood"
ZONE_WINTERSPRING				= "Winterspring"
ZONE_WESTERN_PLAGUELANDS        = "Western Plaguelands"
ZONE_EASTERN_PLAGUELANDS        = "Eastern Plaguelands"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS					= "Ghostlands"
ZONE_ISLE_QUELDANAS				= "Isle of Quel'Danas"
ZONE_HELLFIRE_RAMPARTS			= "Hellfire Ramparts"
ZONE_BLOOD_FURNACE				= "The Blood Furnace"
ZONE_SHATTERED_HALLS			= "The Shattered Halls"
ZONE_AUCHENAI_CRYPTS			= "Auchenai Crypts"
ZONE_MANA_TOMBS					= "Mana-Tombs"
ZONE_SETHEKK_HALLS				= "Sethekk Halls"
ZONE_SHADOW_LABYRINTH			= "Shadow Labyrinth"
ZONE_OLD_HILLSBRAD				= "Old Hillsbrad Foothills"
ZONE_BLACK_MORASS				= "The Black Morass"
ZONE_SLAVE_PENS					= "The Slave Pens"
ZONE_STEAMVAULT					= "The Steamvault"
ZONE_UNDERBOG					= "The Underbog"
ZONE_MAGISTERS_TERRACE			= "Magisters' Terrace"
ZONE_ARCATRAZ					= "The Arcatraz"
ZONE_BOTANICA					= "The Botanica"
ZONE_MECHANAR					= "The Mechanar"
ZONE_KARAZHAN					= "Karazhan"
ZONE_HYJAL_SUMMIT				= "Hyjal Summit"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Strand of the Ancients"
ZONE_ICECROWN_CITADEL			= "Icecrown Citadel"
-- Warlords of Draenor zones
ZONE_FANGRILA					= "Fang'rila"

------------------------------------------------------

if (GetLocale() == "ptBR") then

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV             			= "Vale Alterac"
ZONE_AB             			= "Bacia Arathi"
ZONE_WSG            			= "Ravina Brado Guerreiro"
-- ZONE_SILITHUS       			= "Silithus"	-- same as enUS
ZONE_AQ20           			= "Ruínas de Ahn'Qiraj"
-- ZONE_AQ40           			= "Ahn'Qiraj"	-- same as enUS
ZONE_FELWOOD					= "Selva Maleva"
ZONE_WINTERSPRING				= "Hibérnia"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS					= "Terra Fantasma"
ZONE_ISLE_QUELDANAS				= "Ilha de Quel'Danas"
ZONE_HELLFIRE_RAMPARTS			= "Muralha Fogo do Inferno"
ZONE_BLOOD_FURNACE				= "Fornalha de Sangue"
ZONE_SHATTERED_HALLS			= "Salões Despedaçados"
ZONE_AUCHENAI_CRYPTS			= "Catacumbas Auchenai"
ZONE_MANA_TOMBS					= "Tumbas de Mana"
ZONE_SETHEKK_HALLS				= "Salões dos Sethekk"
ZONE_SHADOW_LABYRINTH			= "Labirinto Soturno"
ZONE_OLD_HILLSBRAD				= "Antigo Contraforte de Eira dos Montes"
ZONE_BLACK_MORASS				= "Lamaçal Negro"
ZONE_SLAVE_PENS					= "Pátio dos Escravos"
ZONE_STEAMVAULT					= "Câmara dos Vapores"
ZONE_UNDERBOG					= "Brejo Oculto"
ZONE_MAGISTERS_TERRACE			= "Terraço dos Magísteres"
ZONE_ARCATRAZ					= "Arcatraz"
ZONE_BOTANICA					= "Jardim Botânico"
ZONE_MECHANAR					= "Mecanar"
-- ZONE_KARAZHAN					= "Karazhan"	-- same as enUS
ZONE_HYJAL_SUMMIT				= "Pico Hyjal"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Baía dos Ancestrais"
ZONE_ICECROWN_CITADEL			= "Cidadela da Coroa de Gelo"

end

------------------------------------------------------

if (GetLocale() == "deDE") then

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV             			= "Alteractal"
ZONE_AB             			= "Arathibecken"
ZONE_WSG            			= "Kriegshymnenschlucht"
--ZONE_SILITHUS       			= "Silithus"	-- same as enUS
ZONE_AQ20           			= "Ruinen von Ahn'Qiraj"
--ZONE_AQ40						= "Ahn'Qiraj"	-- same as enUS
ZONE_FELWOOD        			= "Teufelswald"
ZONE_WINTERSPRING   			= "Winterquell"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS     			= "Geisterlande"
ZONE_ISLE_QUELDANAS				= "Insel von Quel'Danas"
ZONE_HELLFIRE_RAMPARTS			= "Höllenfeuerbollwerk"
ZONE_BLOOD_FURNACE				= "Der Blutkessel"
ZONE_SHATTERED_HALLS			= "Die zerschmetterten Hallen"
ZONE_AUCHENAI_CRYPTS			= "Auchenaikrypta"
ZONE_MANA_TOMBS					= "Managruft"
ZONE_SETHEKK_HALLS				= "Sethekkhallen"
ZONE_SHADOW_LABYRINTH			= "Schattenlabyrinth"
ZONE_OLD_HILLSBRAD				= "Vorgebirge des Alten Hügellands"
ZONE_BLACK_MORASS				= "Der schwarze Morast"
ZONE_SLAVE_PENS					= "Die Sklavenunterkünfte"
ZONE_STEAMVAULT					= "Die Dampfkammer"
ZONE_UNDERBOG					= "Der Tiefensumpf"
ZONE_MAGISTERS_TERRACE			= "Terrasse der Magister"
ZONE_ARCATRAZ					= "Die Arkatraz"
ZONE_BOTANICA					= "Die Botanika"
ZONE_MECHANAR					= "Die Mechanar"
--ZONE_KARAZHAN					= "Karazhan"	-- same as enUS
ZONE_HYJAL_SUMMIT				= "Hyjalgipfel"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Strand der Uralten"
ZONE_ICECROWN_CITADEL			= "Eiskronenzitadelle"

end

------------------------------------------------------

if (GetLocale() == "frFR") then

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV							= "Vallée d'Alterac"
ZONE_AB							= "Bassin d'Arathi"
ZONE_WSG						= "Goulet des Chanteguerres"
--ZONE_SILITHUS					= "Silithus"	-- same as enUS
ZONE_AQ20						= "Ruines d'Ahn'Qiraj"
--ZONE_AQ40						= "Ahn'Qiraj"	-- same as enUS
ZONE_FELWOOD					= "Gangrebois"
ZONE_WINTERSPRING				= "Berceau-de-l'Hiver"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS					= "Les Terres fantômes"
ZONE_ISLE_QUELDANAS				= "Île de Quel'Danas"
ZONE_HELLFIRE_RAMPARTS			= "Remparts des Flammes infernales"
ZONE_BLOOD_FURNACE				= "La Fournaise du sang"
ZONE_SHATTERED_HALLS			= "Les Salles brisées"
ZONE_AUCHENAI_CRYPTS			= "Cryptes Auchenaï"
ZONE_MANA_TOMBS					= "Tombes-mana"
ZONE_SETHEKK_HALLS				= "Les salles des Sethekk"
ZONE_SHADOW_LABYRINTH			= "Labyrinthe des ombres"
ZONE_OLD_HILLSBRAD				= "Contreforts de Hautebrande d'antan"
ZONE_BLACK_MORASS				= "Le Noir Marécage"
ZONE_SLAVE_PENS					= "Les enclos aux esclaves"
ZONE_STEAMVAULT					= "Le Caveau de la vapeur"
ZONE_UNDERBOG					= "La Basse-tourbière"
ZONE_MAGISTERS_TERRACE			= "Terrasse des Magistères"
ZONE_ARCATRAZ					= "L'Arcatraz"
ZONE_BOTANICA					= "La Botanica"
ZONE_MECHANAR					= "Le Méchanar"
--ZONE_KARAZHAN					= "Karazhan"	-- same as enUS
ZONE_HYJAL_SUMMIT				= "Sommet d'Hyjal"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Rivage des Anciens"
ZONE_ICECROWN_CITADEL			= "Citadelle de la Couronne de glace"

end

------------------------------------------------------

if (GetLocale() == "esES" or GetLocale() == "esMX") then

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV							= "Valle de Alterac"
ZONE_AB							= "Cuenca de Arathi"
ZONE_WSG						= "Garganta Grito de Guerra"
--ZONE_SILITHUS					= "Silithus"	-- same as enUS
ZONE_AQ20						= "Ruinas de Ahn'Qiraj"
--ZONE_AQ40						= "Ahn'Qiraj"	-- same as enUS
ZONE_FELWOOD					= "Frondavil"
ZONE_WINTERSPRING				= "Cuna del Invierno"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS					= "Tierras Fantasma"
ZONE_ISLE_QUELDANAS				= "Isla de Quel'Danas"
ZONE_HELLFIRE_RAMPARTS			= "Murallas del Fuego Infernal"
ZONE_BLOOD_FURNACE				= "El Horno de Sangre"
ZONE_SHATTERED_HALLS			= "Las Salas Arrasadas"
ZONE_AUCHENAI_CRYPTS			= "Criptas Auchenai"
ZONE_MANA_TOMBS					= "Tumbas de Maná"
ZONE_SETHEKK_HALLS				= "Salas Sethekk"
ZONE_SHADOW_LABYRINTH			= "Laberinto de las Sombras"
ZONE_OLD_HILLSBRAD				= "Antiguas Laderas de Trabalomas"
ZONE_BLACK_MORASS				= "La Ciénaga Negra"
ZONE_SLAVE_PENS					= "Recinto de los Esclavos"
ZONE_STEAMVAULT					= "La Cámara de Vapor"
ZONE_UNDERBOG					= "La Sotiénaga"
ZONE_MAGISTERS_TERRACE			= "Terrasse des Magistères"
ZONE_ARCATRAZ					= "El Arcatraz"
ZONE_BOTANICA					= "El Invernáculo"
ZONE_MECHANAR					= "El Mechanar"
--ZONE_KARAZHAN					= "Karazhan"	-- same as enUS
ZONE_HYJAL_SUMMIT				= "La Cima Hyjal"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Playa de los Ancestros"
ZONE_ICECROWN_CITADEL			= "Ciudadela de la Corona de Hielo"

end

------------------------------------------------------

if (GetLocale() == "ruRU") then

------------------------------------------------------
-- Zone names must be localized to support automatic rep-watch-bar switching by zone
-- These must use the zone names as returned from GetRealZoneText(), 
--		or as seen in /who; zone names seen elsewhere in the UI won't necessarily work.
------------------------------------------------------
ZONE_AV							= "Альтеракская долина"
ZONE_AB							= "Низина Арати"
ZONE_WSG						= "Ущелье Песни Войны"
ZONE_SILITHUS					= "Силитус"
ZONE_AQ20						= "Руины Ан'Киража"
ZONE_AQ40						= "Ан'Кираж"
ZONE_FELWOOD					= "Оскверненный лес"
ZONE_WINTERSPRING				= "Зимние Ключи"
-- Burning Crusade zones & instances
ZONE_GHOSTLANDS					= "Призрачные земли"
ZONE_ISLE_QUELDANAS				= "Остров Кель'Данас"
ZONE_HELLFIRE_RAMPARTS			= "Бастионы Адского Пламени"
ZONE_BLOOD_FURNACE				= "Кузня Крови"
ZONE_SHATTERED_HALLS			= "Разрушенные залы"
ZONE_AUCHENAI_CRYPTS			= "Аукенайские гробницы"
ZONE_MANA_TOMBS					= "Гробницы Маны"
ZONE_SETHEKK_HALLS				= "Сетеккские залы"
ZONE_SHADOW_LABYRINTH			= "Темный Лабиринт"
ZONE_OLD_HILLSBRAD				= "Старые предгорья Хилсбрада"
ZONE_BLACK_MORASS				= "Черные топи"
ZONE_SLAVE_PENS					= "Узилище"
ZONE_STEAMVAULT					= "Паровое Подземелье"
ZONE_UNDERBOG					= "Нижетопь"
ZONE_MAGISTERS_TERRACE			= "Терраса Магистров"
ZONE_ARCATRAZ					= "Аркатрац"
ZONE_BOTANICA					= "Ботаника"
ZONE_MECHANAR					= "Механар"
ZONE_KARAZHAN					= "Каражан"
ZONE_HYJAL_SUMMIT				= "Вершина Хиджала"
-- Wrath of the Lich King zones & instances
ZONE_SOTA						= "Берег Древних"
ZONE_ICECROWN_CITADEL			= "Цитадель Ледяной Короны"

end

------------------------------------------------------

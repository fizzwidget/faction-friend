------------------------------------------------------
Fizzwidget FactionFriend
by Gazmik Fizzwidget
http://www.fizzwidget.com/factionfriend
gazmik@fizzwidget.com
------------------------------------------------------

It's amazing the lengths some will go to to win friends. Gaining the trust of furbolg tribes, mushroom men, frost giants, and other organizations of demi-goblinoid races can be a lot of work, and it can be easy sometimes to lose track of one's progress. That's where Fizzwidget Industries comes in! Our newest gadget not only helps you keep tabs on whose respect you're earning, but also how much more you could earn by turning in certain items you're carrying.

------------------------------------------------------

INSTALLATION: Put the GFW_FactionFriend folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: 
	- Automatically switches the Blizzard builtin reputation watch bar (i.e. the "Show as experience bar" option in the Reputation pane)...
		- When entering certain zones. (Argent Dawn in Plaguelands, Cenarion Expedition in Coilfang Reservoir instances, etc.)
		- When gaining reputation. (If gaining reputation with multiple factions at once, the bar will switch for only the first.)
		- When equipping a faction's tabard (i.e. tabards which apply reputation gains in dungeons to that faction).
	- Factions marked as "Inactive" in the reputation pane won't be automatically switched to.
	
	- Enhances the reputation watch bar with extra shading and a marker to show how much reputation you can readily gain by turning in and/or using items in your bags or bank.
		- Mousing over the reputation watch bar (or the aforementioned marker) will show a summary of the reputation points that can be earned through turning in or consuming items.
		- If your potential reputation gain from turnins is enough to reach a new standing (e.g. Friendly vs. Honored), the "empty" part of the bar will be shaded differently, and the tooltip will show your new standing (and how many points into it you'd be) after all turnins.
		
	- Adds an icon to the builtin UI's Reputation panel for factions you can readily increase -- mouse over it for details. Didn't know your bank was full of stuff you could gain reputation from? Now you do! 

	- Right-clicking the reputation watch bar will open a menu allowing you to quickly switch which faction it shows. (TIP: For a shorter / less complex menu, mark factions as "Inactive" in the reputation window to hide them.)
	
	
CHAT COMMANDS:
	/factionfriend (or /ff): shows or hides the options window.

CAVEATS, KNOWN BUGS, ETC.: 
	- The potential reputation gain shown on the bar is just an estimate: actual reputation gain may vary. (This is especially true in cases where racial abilities, guild perks, or other factors increase reputation gain: FactionFriend's rounding may not match Blizzard's.)
	- Some repeatable faction turnins offer an increased amount of reputation the first time they're completed; FactionFriend can't readily tell whether you've done a turnin before, so it always assumes the smaller amount.
	- Some repeatable faction turnins only become available at a certain reputation level, or once prerequisite quests are completed. FactionFriend can't keep track of all the reasons a turnin might or might not be available; it just shows how much reputation you'd be able to earn if the turnins are possible. 
	- FactionFriend only enhances the default Blizzard UI's reputation panel and reputation watch bar. However, we provide API hooks so that makers of replacement reputation bar addons can more easily provide similar enhancements. For details, see the readme-API.txt file. 

------------------------------------------------------
VERSION HISTORY

v. 7.0 - 2016/08/18
- Updated for WoW Patch 7.0 and Legion. (Thanks Dragonwolf!)

v. 6.0 - 2014/10/14
- Updated for WoW Patch 6.0 and Warlords of Draenor.
	- Added turnin info for the Steamwheedle Preservation Society.
	- Removed info for reputation boosts purchasable with Justice Points, as Justice Points are no longer in the game.

v. 5.2.1 - 2013/03/08
- Fixed an error when mousing over the reputation bar for friendship factions in certain circumstances.

v. 5.2 - 2013/03/05
- Updated for WoW Patch 5.2.
	- FactionFriend no longer needs to observe an increase in reputation to detect whether a faction has a Grand Commendation bonus.
	- Added turnin information for Sunreaver Onslaught and Kirin Tor Offensive (Tattered Historical Documents -> faction-specific insignia)
- The Klaxxi turnin "Seeds of Fear" requires 5 Dread Amber Shards, not 20.
- The feature that recolors reputation bars and related UI (such that, e.g. Friendly through Exalted use distinct colors instead of the same green) is now optional and disabled by default. It was causing "taint" and "blocked action" errors for some users, but if it causes you no trouble you're welcome to enable it.

v. 5.1.1 - 2013/01/14
- More handling of "friendship" factions (Tillers/Anglers NPCs and the Brawler's Guild factions):
	- Friendship ranks appear appropriately on the reputation watch bar and in its tooltip.
	- Chat-window messages correctly reflect the amount of reputation until the next friendship rank.
	- The indicator for additional reputation available from turnins is correctly placed.
- We now detect when you gain reputation with the bonus from a Grand Commendation; thereafter, estimates of reputation gain for that faction reflect the bonus.
- Fixed an error that could occur when showing a faction report tooltip including info on purchasable tokens (e.g. [Sons of Hodir Commendation Badge]) when info for said tokens is not yet available to the WoW client. The names of such items are now in FactionFriend's database (for English, German, French, Spanish, Portuguese and Russian locales), and if we still don't have the name for an item we'll show its numeric ID instead of throwing an error.
- Fixed an issue where we'd fail to detect the "Mr. Popularity" guild perk (which increases reputation gain) as intended.
- Fixed an issue where we'd fail to recognize a reputation gain message for a faction to which a Grand Commendation bonus applies, and thus not do things we're supposed to, like automatically switching the reputation bar. (This issue didn't surface in English clients, but would on German and possibly other locales.)
- Better late than never: we now track Writs of Commendation purchasable at the Molten Front. (So if you're still sitting on some Marks of the World Tree, your Reputation window will tell you how much reputation you can gain with your faction's racial cities.)
- Some internal architecture improvements.

v. 5.1 - 2012/12/19
- Updated TOC to indicate compatibility with WoW Patch 5.1.
- Added Huojin and Tushui for automatically switching the rep bar when the appropriate tabard is equipped.
- Added turnin info for the following Mists of Pandaria factions:
	- Onyx Eggs for Order of the Cloud Serpent
	- Dread Amber Shards for The Klaxxi
	- Relics of Guo-Lai and the Thunder King for Golden Lotus
	- Favorite foods and gifts for each of the ten Tillers NPCs you can befriend
- Fixed an issue where "gibberish" (color codes) could appear before text.
- The reputation watch bar menu uses friendship-level names for friendship factions.
	
v. 5.0 - 2012/08/28
- Updated for WoW Patch 5.0 and Mists of Pandaria.
- Fixes errors which could appear when playing a Pandaren character who has not yet chosen a faction.
- Fixes error when attempting to apply a glyph.

v. 4.3.3 - 2012/08/03
- Fixed an error that could occur when gaining/losing guild reputation while not in a guild.

v. 4.3.2 - 2012/06/18
- When calculating potential reputation gain, we now ignore rep gain from items purchased with currency unless no other turnins are available. 
	- For example, if you are farming Relics of Ulduar for Sons of Hodir reputation, the reputation bar will show only the gains you can make by turning in those items, instead of obscuring that information by showing that you can gain lots of reputation by spending Justice Points on Commendation Badges. Once you run out of Relics, the bar will show how much further you can get using Justice Points. 
	- Better customization and reporting for this feature will come in a future update.

v. 4.3.1 - 2012/01/04
- Now supports the Brazilian Portuguese localization of the WoW client thanks to data from pt.wowhead.com. (Only the client-specific strings needed for full functionality under Portuguese are translated; if you'd like to help provide a translation for FactionFriend's own UI text, see the localization.lua file.)
- Removed the Coilfang Armaments turnin for Cenarion Expedition, as WoW Patch 4.3 removed the turnin quest. (The items still drop and are still white, so maybe this is a bug and the turnin will come back later?)
- Removed turnins from the old (before Patch 4.3) Darkmoon Faire as they are no longer available. You can get rid of your Evil Bat Eyes now.
- Fixed database entry for Oshu'gun Crystal Fragments so that those items are properly counted for potential reputation gains.
- Fixed an issue where certain kinds of turnins (including some from the old Darkmoon Faire) could be incorrectly counted as providing negative reputation.

v. 4.3 - 2011/11/29
- Updated TOC to indicate compatibility with WoW Patch 4.3.

v. 4.2.3 - 2011/07/07
- Fixed error on login introduced in 4.2.2. (I don't know how I managed to end up with the entire contents of FactionFriend.lua duplicated -- probably gnome sabotage or something-- but it's back to normal now.)

v. 4.2.2 - 2011/07/06
- Fixed incorrect numbers shown on the reputation watch bar (bug introduced in 4.2.1).

v. 4.2.1 - 2011/07/03
- Fixed an error when using zone-based switching of the reputation watch bar.
- Fixed strange behaviors related to the quest log.
- The text on the reputation watch bar (when moused over, or shown by the default UI in various other circumstances) now displays your current standing (Hated, Neutral, Friendly, etc) with the watched faction.

v. 4.2 - 2011/06/28 - Big Update!

New Features & Bug Fixes:

- Updated TOC to indicate compatibility with WoW Patch 4.2.
- Now adds an icon to the builtin UI's Reputation panel for each faction you can readily increase -- mouse over it for details. Didn't know your bank was full of stuff you could gain reputation from? Now you do! 
- Improved item info caching, so tooltips indicating which items can be used to gain reputation should always have the actual item name.
- Altered FactionFriend counts reputation gains which are available up through Exalted standing:
	- If your current reputation is below Exalted, we indicate only the number of gains (turnins / item uses / etc) required to raise the reputation into Exalted.
	- If your current reputation is Exalted, we indicate the number of gains required to max out at 999/1000.
	- (Fixed issue where we'd say you could turn in / use more items than were needed to max out.)
- The tooltip detailing reputation gains (now visible both from the reputation panel and reputation watch bar) now always shows the amount of reputation you'll have after all applicable gains (instead of only showing such if you have enough to reach a new standing).
- Fixes an error which could appear when we try to draw the reputation watch bar menu.
- Options now default to being shared across all characters; see the Options Profile panel if you'd prefer per-character, per-server, or per-class settings. (This change may not take effect if you already have saved options; choose the Default options profile if you'd prefer this behavior)

Content Updates:

- Potential reputation gains are displayed for Baradin's Wardens / Hellscream's Reach Commendations purchasable with Tol Barad currency.
- Some overdue additions regarding Wrath of the Lich King content:
	- Icecrown Citadel / Ashen Verdict is now included for zone-based switching of the reputation watch bar.
	- Potential reputation gains are displayed for racial faction Commendation Badges and [Champion's Writ] from the Argent Tournament.
	- Potential gains are also displayed for Northrend faction Commendation Badges purchasable via Justice Points.
- Further updates of turnin info to match post-Shattering changes to Classic quests:
	- Thorium Brotherhood: removed Fiery Flux quests, changed availability of [Dark Iron Residue] turnin, increased reputation from various turnins
	- Zandalar Tribe: no longer associated with Zul'Gurub for zone-based switching of the reputation watch bar.
	- Argent Dawn: no longer associated with Plaguelands, Stratholme, or Scholomance for zone-based switching of the reputation watch bar.

Stuff For Localizers & Other Addon Authors:

- Redesigned internals for better locale support: most of FactionFriend's feature set is now available in all WoW locales. (Now, the only feature that requires explicit localization is zone-based switching of the reputation watch bar. If you'd like to help provide such support for languages other than English, Spanish, German, French, and Russian, see the LocaleSupport.lua file.)
- The API we provide (so that other reputation bar addons can make use of FactionFriend's features) has been expanded and better documented. See readme-API.txt for details.


See http://fizzwidget.com/notes/factionfriend/ for older release notes.

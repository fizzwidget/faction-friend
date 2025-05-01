------------------------------------------------------
Fizzwidget FactionFriend
by Gazmik Fizzwidget
http://www.fizzwidget.com/factionfriend
gazmik@fizzwidget.com
------------------------------------------------------

It's amazing the lengths some will go to to win friends. Gaining the trust of furbolg tribes, mushroom men, frost giants, and other organizations of demi-goblinoid races can be a lot of work, and it can be easy sometimes to lose track of one's progress. That's where Fizzwidget Industries comes in! Our most famous gadget not only helps you keep tabs on whose respect you're earning, but also how much more you could earn by turning in certain items you're carrying.

------------------------------------------------------

INSTALLATION: Put the GFW_FactionFriend folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: 
	- Automatically switches the Blizzard builtin reputation watch bar (i.e. the "Show as experience bar" option in the Reputation pane) when you gain reputation.
		- If gaining reputation with multiple factions at once, the bar will switch to whichever faction gained the most.
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

v. 11.xxxx - 2025/xxxx/xxxx - Major Update!

TODO for rewrite
- faction report in special paragon tooltip, major faction renown tooltip
- potential gains for friendship, paragon, major faction renown
- faction report tooltip for friendship, paragon, major faction renown
- generalize timewarped badge setting to "seasonal currency" and include dragon racing badges?
- BUG? potential gains counts exalted factions
- content updates
	- Classic
		- Argent Dawn scourgestones quests returned
	- War Within
		- severed threads commendation (for multiple possible factions)
	- Shadowlands
		- stolen korthian supplies
		- helsworn battle plans
		- more?
	- Battle for azeroth
		- champions: azeroth's tear
		- unshackled / ankoan: abyssal conch
			- creatable with shadow cloaked shell?
		- nazjatar bodyguards?
		- honeyback hive?
			- thin / rich / royal jelly
	- ???
	- profit!

Remodeled from a fresh start for current WoW (11.x and The War Within), gaining efficiency, eliminating fragile dependencies, and using modern WoW UI infrastructure. Some benefits from the refurbishing:
	- Modern WoW menu system eliminates a lot of custom code and avoids "action blocked because of an addon" errors. (Related: the "Show Reputation Pane" action in the reputation watch bar context menu is disabled during combat and shows a tooltip to explain this.)
	- Modern WoW settings system gets rid of bulky library dependencies and provides for searchable settings.
	- More efficient, locale-independent handling of faction and item data should improve reliability and performance.
	- TODO All relevant features support major faction renown, friendship factions, and paragon factions (those which provide repeatable rewards for continued reputation gain past Exalted), and correctly handle the change (from several expansions ago) where regular factions no longer earn up to 999 points of reputation at Exalted status.

New Features

- Adds a few widgets to the default UI's Reputation pane:
	- A button to move all completed (exalted, max friendship, max renown) factions to Inactive
	- A search field -- find a faction by part of its name and select it, expand any headers needed to make it visible, and scroll to it
	- Buttons to expand/collapse all top-level headers (with modifier key options to expand/collapse more)
	
- Modifies the default UI's reputation-related chat messages to add a hyperlink for the relevant faction.
	- Click to open the default UI's Reputation pane and reveal that faction.
	- If you also have Fizzwidget HoverTips installed, mousing over the link shows a tooltip with reputation info.
	
Other Improvements & Bug Fixes

- Calculating potential reputation gains counts items in the reagent bank and warband bank, and warband transferable currency on other characters.
- Added an setting to ignore potential reputation gain from buying items with Timewarped Badges, since the vendors offering such are available only during Timewalking events. (Also, the list of factions you can gain reputation with can get noisy, making it harder to see which factions you can improve without spending currency.)
- When gaining reputation with multiple factions at once, switches the reputation watch bar to whichever faction gained the most.
- Always shows a tooltip with at least basic reputation info when mousing over the reputation watch bar, since the default UI doesn't provide for easily distinguishing renown levels / reputation standings.
- Warlords of Draenor: Fixed a bug that prevented showing item tooltip info for Horde- or Alliance-only factions.
- Cataclysm: Previously tracked Writs of Commendation for racial factions, but didn't track that they can be purchased with Marks of the World Tree; fixed.

Content Updates

- Timewalking: Commendations and Insignia purchaseable with Timewarped Badges for Classic, Warlords of Draenor, and Legion factions (in addition to Burning Crusade, Wrath of the Lich King, Cataclysm, and Mists of Pandaria commendations already tracked).
- Dragonflight: Treasure collection turnins for the four major Patch 10.0 renown factions, Vault Artifacts, reputation items for certain past expansions' factions from Paracausal Flakes vendors, Insignia for the six major renown factions (some purchaseable with Flightstones if somehow you still have any)
- Shadowlands:
- Battle for Azeroth: Treasures for Rustbolt Resistance, Island Expedition items for major Zandalar and Kul Tiras factions (dubloon purchase, turnin purchased item)
- Legion: Patch 7.3 Argus factions, Talon's Vengeance faction, more Greater Insignia items and Demon's Soulstone for all factions
- Warlords of Draenor:
- Mists of Pandaria: Hozen Peace Pipe

Legacy

- Removed some older features for which it's cumbersome to maintain support:
	- Switching reputation watch bar when entering certain zones
	- Switching reputation watch bar when equipping certain tabards
	- Customizing the color of reputation bars (caused taint errors, no longer works with some bars)
	
- Some changes have disrupted existing localizations:
	- New Settings UI may truncate settings text
	- Many new or changed text strings not localized
	- If you'd like to help with localization, visit https://github.com/fizzwidget/faction-friend


See http://fizzwidget.com/notes/factionfriend/ for older release notes.

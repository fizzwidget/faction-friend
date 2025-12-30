# Fizzwidget FactionFriend
- by Gazmik Fizzwidget
- http://github.com/fizzwidget/factionfriend

## Introduction 

It's amazing the lengths some will go to to win friends. Gaining the trust of furbolg tribes, mushroom men, frost giants, and other organizations of demi-goblinoid races can be a lot of work, and it can be easy sometimes to lose track of one's progress. That's where Fizzwidget Industries comes in! Our most famous gadget not only helps you keep tabs on whose respect you're earning, but also how much more you could earn by turning in certain items you're carrying.

## Features 

### Tracks when you gain reputation with a faction.
- If your chat windows are set to show reputation gains, modifies the message to show how many times you'll need to repeat similar gains to reach the next standing/rank with that faction.
- Adds faction hyperlinks to reputation-related chat messages -- click to open the Reputation pane to that faction. (If you also have Fizzwidget HoverTips installed, mouse over the link to see faction information.)
- Automatically switches the reputation watch bar ("Show as experience bar" in the Reputation pane) when you gain reputation.
- If gaining reputation with multiple factions at once, the bar will switch to whichever faction gained the most.
- Factions marked as Inactive in the reputation pane won't automatically switch the bar.
- (Optional) Automatically moves factions to Inactive when reaching maximum standing/rank.

### Estimates the amount of reputation you can gain from items in your bags or bank.
- Item tooltips show if the item can be consumed or turned in for gaining reputation, with which factions, and your current standing with those factions.
- Highlights item icons in the default UIs for loot, bag inventory, and bank / reagent bank / warband bank for reputation-related items.
- Adds extra shading to the reputation watch bar showing the total amount of reputation you can gain by turning in and/or using items in your bags or bank.
- Shows a tooltip on reputation bars summarizing how many reputation points are available, which items to turn in or use, and how many of those items are required for the estimated reputation gain.
- If an item or currency can be exchanged for another item that increases reputation, FactionFriend shows the amount of reputation to gain based on the quantity you have of the first item/currency.
	
### Enhances the Character window's Reputation pane.
- A button to move all completed (exalted, max friendship, max renown) factions to Inactive
- A search field -- find a faction by part of its name and select it, expand any headers needed to make it visible, and scroll to it
- Buttons to expand/collapse all top-level headers (with modifier key options to expand/collapse more)
- Icons next to factions you can improve using items or currency you have (mouse over the faction for details). Didn't know your bank was full of stuff you could gain reputation from? Now you do! 

### Adds a right-click menu to the reputation watch bar for switching watched factions.
- Includes a list of several factions you've recently gained/lost reputation with or watched using the bar.
- Also includes a full menu showing the set of factions visible in the Character window's Reputation pane.
- Hovering on a faction in the menu shows the same tooltip as in the Reputation pane, including information about potential gains; icons in the menu indicate factions you have enough items to gain reputation with.
- TIP: The menu honors filters set in the Reputation pane and doesn't include collapsed headings or factions marked as Inactive, so you can deactivate/collapse/filter factions there to simplify the menu.
	

## Caveats, Known Bugs, Etc
- The potential reputation gain shown is just an estimate: actual gains may vary. (This is especially true in cases where buffs or other factors increase reputation gain: FactionFriend's rounding may not match Blizzard's.)
- Some repeatable faction turnins offer an increased amount of reputation the first time they're completed; FactionFriend can't readily tell whether you've done a turnin before, so it always assumes the smaller amount.
- Some repeatable faction turnins become available only once prerequisite quests are completed. FactionFriend can't keep track of all the reasons a turnin might or might not be available; it just shows how much reputation you'd be able to earn if the turnins are possible. (It does track reputation requirements for some turnins; for example, you can't turn in Aldor/Scryers items unless you're at least Neutral with the appropriate faction.)
- For "friendship" factions (Pandaria Halfhill citizens, Draenor bodyguards, Legion fishing NPCs, Shadowlands Ember Court, Dragonflight Valdrakken Accord members, etc), information about ranks other than the one you're currently progressing through isn't available to the UI, so FactionFriend can't indicate what rank you'll be after completing available turnins or estimate the maximum number of items to turn in.

## Version History

### v. 11.2 - 2025/12/30 - Revived

Remodeled from a fresh start for current WoW (11.x and The War Within), gaining efficiency, eliminating fragile dependencies, and using modern WoW UI infrastructure. Some benefits from the refurbishing:
	- New WoW menu system eliminates a lot of custom code and avoids "action blocked because of an addon" errors. (Related: the "Show Reputation Pane" action in the reputation watch bar context menu is disabled during combat and shows a tooltip to explain this.)
	- New WoW settings system gets rid of bulky library dependencies and provides for searchable settings.
	- More efficient, locale-independent handling of faction and item data should improve reliability and performance.
	- All relevant features support major faction renown, friendship factions, and paragon factions (those which provide repeatable rewards for continued reputation gain past Exalted). Correctly handles Exalted status no longer (as of a few expansions ago) having 999 points of reputation available to earn.

#### New Features

- Adds a few widgets to the default UI's Reputation pane:
	- A button to move all completed (exalted, max friendship, max renown) factions to Inactive
	- A search field -- find a faction by part of its name and select it, expand any headers needed to make it visible, and scroll to it
	- Buttons to expand/collapse all top-level headers (with modifier key options to expand/collapse more)
	
- Modifies the default UI's reputation-related chat messages to add a hyperlink for the relevant faction.
	- Click to open the default UI's Reputation pane and reveal that faction.
	- If you also have Fizzwidget HoverTips installed, mousing over the link shows a tooltip with reputation info.

- Highlights reputation-increasing items in the default loot window, bag, and bank / reagent bank / warband bank UIs.

#### Other Improvements & Bug Fixes

- Calculating potential reputation gains counts items in the reagent bank and warband bank, and warband transferable currency on other characters.
- Added an setting to ignore potential reputation gain from items purchasable only during certain time-limited recurring events: includes Timewarped Badge purchases (Timewalking / Turbulent Timeways events) and Riders of Azeroth Badge purchases (Skyriding Cup events). Since these cover a large number of factions, ignoring them reduces noise in the list of factions you can readily increase reputation with.
- When gaining reputation with multiple factions at once, switches the reputation watch bar to whichever faction gained the most.
- Always shows a tooltip with at least basic reputation info when mousing over the reputation watch bar, since the default UI doesn't provide for easily distinguishing renown levels / reputation standings / friendship ranks.
- Chat window message parsing is now more locale-independent: actions that triggered from system messages should work properly in more languages.
- Warlords of Draenor: Fixed a bug that prevented showing item tooltip info for Horde- or Alliance-only factions.
- Cataclysm: Previously tracked Writs of Commendation for racial factions, but didn't track that they can be purchased with Marks of the World Tree; fixed.

#### Content Updates

- Timewalking: Commendations and Insignia purchasable with Timewarped Badges for Classic, Warlords of Draenor, and Legion factions (in addition to Burning Crusade, Wrath of the Lich King, Cataclysm, and Mists of Pandaria commendations already tracked).
- The War Within: Severed Threads Commendation. (Is this the only item-based repeatable reputation gain this expansion so far? Let me know if you've found others!)
- Dragonflight: Treasure collection turnins for the four Season 1 renown factions, Vault Artifacts, reputation items for certain past expansions' factions from Paracausal Flakes vendors, Insignia for the six major renown factions (some purchasable with Flightstones if somehow you still have any), plus Signets for your favorite black dragon friend and Marks for his annoying buddy
- Shadowlands: This place is dead to me. (Actually, I couldn't find any item-based repeatable reputation gains in this whole expansion. Let me know if I've missed any?)
- Battle for Azeroth: Treasures for Rustbolt Resistance, Island Expedition items for major Zandalar and Kul Tiras factions, Honorbound / 7th Legion, and Champions of Azeroth (turnin for an item that drops in expeditions or for some factions can be purchased with dubloons), various items for Nazjatar factions, jelly for Honeyback Hive
- Legion: Patch 7.3 Argus factions, Talon's Vengeance faction, more Greater Insignia items and Demon's Soulstone for all factions
- Mists of Pandaria: Hozen Peace Pipe
- Classic: Somehow, Scourgestones have returned...

#### Legacy

- Removed some older features for which it's cumbersome to maintain support:
	- Switching reputation watch bar when entering certain zones
	- Switching reputation watch bar when equipping certain tabards
	- Customizing the color of reputation bars (caused taint errors, no longer works with some bars)
	
- Some changes have disrupted existing localizations:
	- Settings UI completely revamped; removed old localization strings that are no longer valid
	- Many new or changed text strings not localized
	- If you'd like to help with localization, visit https://github.com/fizzwidget/faction-friend

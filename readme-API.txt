------------------------------------------------------
Fizzwidget FactionFriend
by Gazmik Fizzwidget
http://www.fizzwidget.com/factionfriend
gazmik@fizzwidget.com
------------------------------------------------------

FactionFriend only enhances the default Blizzard UI's reputation panel and reputation watch bar. However, we provide API hooks so that makers of replacement reputation bar addons can more easily provide similar enhancements. 

Full details are provided below, but here's a quick run-through:
	- For drawing an addition to a reputation bar the way FactionFriend does, call FFF_GetFactionPotential(faction) to get the amount of potential rep gain available. (Then you can add that to the current reputation and draw an extra bar fill however is appropriate for your addon.)
	- For showing a tooltip summarizing available reputation gains, call FFF_FactionReportTooltip(faction).

------------------------------------------------------
API NOTES
---------

FFF_GetFactionPotential:
	Gets info on potential reputation gain from turnins for a given faction

potential, reportLines = FFF_GetFactionPotential(faction, withReport)

Parameters:
	faction:
		String, Number, or nil - The faction to calculate potential rep gain for; can be be a string (localized name of the faction), number (index of the faction as used by GetFactionInfo and other faction-related Blizzard API functions), or nil (in which case we default to the faction currently set as "watched" in the Blizzard UI).
	withReport:
		Boolean - Pass a non-nil, non-false value to get a report summarizing available turnins (a la FactionFriend's tooltips). Omit if you're not interested in such and we won't waste time and resources preparing the report. You should only ask for this if you want to customize the report or display it in another setting -- to just show FactionFriend's tooltip, call FFF_FactionReportTooltip(faction).
	
Returns:
	potential:
		Number - The amount of reputation gain available from turnins for the specified faction. (e.g. If you're looking at one of the racial factions and have enough Runecloth for one turnin, this value will be 75.)
	reportLines:
		Table - If requested, a table containing the information used to construct FactionFriend's tooltip on the Blizzard reputation bar. Example:
			reportLines = {
				["75 points (3 turnins):"] = {
					"12x[Iron Bar]",
					"6x[Incendosaur Scale] (4 in bank)",
				},
			}

---------
FFF_FactionReportTooltip:
	Shows a tooltip summarizing the available reputation gains for a faction. You'll need to call GameTooltip:SetAnchor() first to position the tooltip appropriately -- then we'll fill it in and show it.

FFF_FactionReportTooltip(faction)

Parameters:
	faction:
		String, Number, or nil - The faction to calculate potential rep gain for; can be be a string (localized name of the faction), number (index of the faction as used by GetFactionInfo and other faction-related Blizzard API functions), or nil (in which case we default to the faction currently set as "watched" in the Blizzard UI).

Returns:
	none

---------

FFF_StandingForValue:
	Gets standing (e.g. Friendly vs. Honored) information for a given absolute reputation value.

standing, pointsInto, max = FFF_StandingForValue(absoluteReputation)

Parameters:
	absoluteReputation:
		Number - An absolute reputation value -- such as returned by GetFactionInfo, not the standing-relative values you see in the UI. (e.g. 0 = 0/3000 Neutral, -2800 = 200/3000 Unfriendly, 9100 = 100/12000 Honored)
	
Returns:
	standing:
		Number - The standingID (http://www.wowwiki.com/API_TYPE_StandingId) represented by the input value.
	pointsInto:
		Number - The relative reputation value (as seen in the Blizzard reputation UI) within the given standing.
	max:
		Number - The maximum relative value within the given standing (e.g. 12000 for Honored).

---------

FFF_GetFactionInfoByName:
	A wrapper for the Blizzard API function GetFactionInfo that lets you query by name (which is localized, but constant for a given faction) instead of by index (which can change as the player expands or collapses headings in the Reputation window or moves factions to the "Inactive" group).

... = FFF_GetFactionInfoByName(factionName)

Parameters:
	factionName:
		String - Localized name of a faction.
	
Returns:
	Same as for the Blizzard API function GetFactionInfo (http://wowprogramming.com/docs/api/GetFactionInfo), or nil if no faction by the given name is found. See also the Blizzard API function GetFactionInfoByID (http://wowprogramming.com/docs/api/GetFactionInfoByID) for querying faction info by non-localized numeric IDs. (See the FFF_FactionIDs table in FFF_ItemInfo.lua for a handy list of several faction's IDs.)


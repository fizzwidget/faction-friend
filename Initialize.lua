local addonName, addonTable = ...; 

-- TODO: do something about fancy colors for friendship levels?
FFF_FACTION_BAR_COLORS = {
    [1] = {r = 1, g = 0.1, b = 0.05},   -- Hated
    [2] = {r = 0.8, g = 0.3, b = 0.22}, -- Hostile      }
    [3] = {r = 0.75, g = 0.27, b = 0},  -- Unfriendly   } same as default
    [4] = {r = 0.9, g = 0.7, b = 0},    -- Neutral      }
    [5] = {r = 0, g = 0.6, b = 0.1},    -- Friendly     }
    [6] = {r = 0, g = 0.6, b = 0.4},    -- Honored
    [7] = {r = 0, g = 0.7, b = 0.6},    -- Revered
    [8] = {r = 0, g = 0.7, b = 0.8},    -- Exalted
};

------------------------------------------------------
-- Ace3 options panel stuff
------------------------------------------------------

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")

-- AceAddon Initialization
GFW_FactionFriend = LibStub("AceAddon-3.0"):NewAddon(addonName);
GFW_FactionFriend.date = gsub("$Date: 2013-03-07 22:32:45 -0800 (Thu, 07 Mar 2013) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1");

function GFW_FactionFriend:OnProfileChanged(event, database, newProfileKey)
    -- this is called every time our profile changes (after the change)
    FFF_Config = database.profile
end

local function getProfileOption(info)
    return FFF_Config[info.arg]
end

local function setProfileOption(info, value)
    FFF_Config[info.arg] = value
    FFF_ReputationWatchBar:Update();
    if (FFF_Config.MoveExaltedInactive) then
        -- move any already exalted factions when the preference is first enabled
        FFF_MoveExaltedFactionsInactive();
    end
    if (FFF_Config.CountRepeatGains) then
        -- TODO: check whether reputation messages are set to show in chat windows, warn if not
        
    end
    if (info.arg == "ReputationColors") then
        if (value) then
            FACTION_BAR_COLORS = FFF_FACTION_BAR_COLORS;
        else
            -- TODO: prompt for UI reload
        end
    end
end

local titleText = GetAddOnMetadata(addonName, "Title");
local version = GetAddOnMetadata(addonName, "Version");
titleText = titleText .. " " .. version;

function FFF_ColorsOptionTipText(
)    local text = ""
    for standing = 1, 8 do
        local colorCode = GFWUtils.ColorToCode(FFF_FACTION_BAR_COLORS[standing]);
        text = text .. colorCode .. _G["FACTION_STANDING_LABEL"..standing] .. FONT_COLOR_CODE_CLOSE;
        if standing < 8 then
            text = text .. " ";
        end
    end
    return text;
end

local options = {
    type = 'group',
    name = titleText,
    args = {
        general = {
            type = 'group',
            cmdInline = true,
            order = -1,
            get = getProfileOption,
            set = setProfileOption,
            name = FFF_OPTIONS_GENERAL,
            args = {
                showPotential = {
                    type = 'toggle',
                    order = 10,
                    width = "double",
                    name = FFF_OPTION_SHOW_POTENTIAL,
                    desc = FFF_OPTION_SHOW_POTENTIAL_TIP,
                    arg = "ShowPotential",
                },
                -- useCurrency = {
                --  type = 'toggle',
                --  order = 15,
                --  width = "double",
                --  name = FFF_OPTION_USE_CURRENCY,
                --  desc = FFF_OPTION_USE_CURRENCY_TIP,
                --  arg = "UseCurrency",
                -- },
                tooltip = {
                    type = 'toggle',
                    order = 20,
                    width = "double",
                    name = FFF_OPTION_TOOLTIP,
                    arg = "Tooltip",
                },
                countRepeatGains = {
                    type = 'toggle',
                    order = 30,
                    width = "double",
                    name = FFF_OPTION_REPEAT_GAINS,
                    desc = FFF_OPTION_REPEAT_GAINS_TIP,
                    arg = "CountRepeatGains",
                },
                moveExaltedInactive = {
                    type = 'toggle',
                    order = 40,
                    width = "double",
                    name = FFF_OPTION_MOVE_EXALTED,
                    arg = "MoveExaltedInactive",
                },
                reputationColors = {
                    type = 'toggle',
                    order = 40,
                    width = "double",
                    name = FFF_OPTION_REPUTATION_COLORS,
                    desc = FFF_ColorsOptionTipText(),
                    arg = "ReputationColors",
                },
                switchBar = {
                    type = "group",
                    name = FFF_OPTIONS_SWITCHBAR,
                    order = 50,
                    inline = true,
                    args = {
                        zones = {
                            type = 'toggle',
                            order = 10,
                            width = "double",
                            name = FFF_OPTION_ZONES,
                            arg = "Zones",
                        },
                        repGained = {
                            type = 'toggle',
                            order = 20,
                            width = "double",
                            name = FFF_OPTION_REP_GAINED,
                            arg = "RepGained",
                        },
                        --tabard = {
                        --    type = 'toggle',
                        --    order = 30,
                        --    width = "double",
                        --    name = FFF_OPTION_TABARD,
                        --    arg = "Tabard",
                        --},
                        --guild = {
                        --    type = 'toggle',
                        --    order = 40,
                        --    width = "double",
                        --    name = FFF_OPTION_NO_GUILD_AUTOSWITCH,
                        --    arg = "NoGuildAutoswitch",
                        --},
                        --bodyguard = {
                        --    type = 'toggle',
                        --    order = 50,
                        --    width = "double",
                        --    name = FFF_OPTION_NO_BODYGUARD_AUTOSWITCH,
                        --    arg = "NoBodyguardAutoswitch",
                        --}
                    },
                },
                combatDisableMenu = {
                    type = 'toggle',
                    order = 60,
                    width = "double",
                    name = FFF_OPTION_COMBAT_DISABLE,
                    desc = FFF_OPTION_COMBAT_DISABLE_TIP,
                    arg = "CombatDisableMenu",
                },
                tips = {
                    type = "description",
                    name = FFF_OPTIONS_TIPS,
                    order = 100,
                },
            },
        },
    },
}
local profileDefault = {
    ShowPotential = true,
    Tooltip = true,
    CountRepeatGains = false,
    MoveExaltedInactive = false,
    ReputationColors = true,
    Zones = true,
    RepGained = true,
    --Tabard = true,
    CombatDisableMenu = false,
    NoGuildAutoswitch = false,
    --NoBodyguardAutoswitch = true,
}
local defaults = {}
defaults.profile = profileDefault

function GFW_FactionFriend:SetupOptions()
    -- Inject profile options
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    options.args.profile.order = -2
    
    -- Register options table
    AceConfig:RegisterOptionsTable(addonName, options)
    
    local titleText = GetAddOnMetadata(addonName, "Title");
    titleText = string.gsub(titleText, "Fizzwidget", "GFW");        -- shorter so it fits in the list width

    -- Setup Blizzard option frames
    self.optionsFrames = {}
    -- The ordering here matters, it determines the order in the Blizzard Interface Options
    self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(addonName, titleText, nil, "general")
    self.optionsFrames.profile = AceConfigDialog:AddToBlizOptions(addonName, FFF_OPTIONS_PROFILE, titleText, "profile")
end

function GFW_FactionFriend:OnInitialize()

    -- Create DB
    self.db = AceDB:New("GFW_FactionFriend_DB", defaults, "Default")
    self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
    
    FFF_Config = self.db.profile

    self:SetupOptions()
    
    --TEMP
    --FFF_NewMenuTest()
    
end

function GFW_FactionFriend:ShowConfig()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
    -- Fix for bug where calling it the first time doesn't actually open to the addon options
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

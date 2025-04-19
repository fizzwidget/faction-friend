local addonName, T = ...

function T:SetupSettings()
    local category, layout = Settings.RegisterVerticalLayoutCategory(T.Title)
    local settingsTable = T.Settings
    T.SettingsCategoryID = category:GetID()
    
    -- TODO: setup factories for other settings control types as needed
    -- TODO: shorter label locale-lookup keys, derive tooltip key from label
    local function Checkbox(settingKey, defaultValue, labelText, tooltipText, parentInit)
        local setting = Settings.RegisterAddOnSetting(
            category, 
            addonName .. "_" .. settingKey, 
            settingKey, 
            settingsTable,
            type(defaultValue), 
            labelText, 
            defaultValue
        )
        local init = Settings.CreateCheckbox(category, setting, tooltipText)
        if parentInit then
            init:Indent()
            init:SetParentInitializer(parentInit)
        end
        return init
    end
    
    Checkbox("ShowPotential", true, FFF_OPTION_SHOW_POTENTIAL, FFF_OPTION_SHOW_POTENTIAL_TIP)
    -- Checkbox("UseCurrency", true, FFF_OPTION_USE_CURRENCY, FFF_OPTION_USE_CURRENCY_TIP)
    Checkbox("Tooltip", true, FFF_OPTION_TOOLTIP, FFF_OPTION_TOOLTIP_TIP)
    Checkbox("ModifyChat", false, FFF_OPTION_MODIFY_CHAT, FFF_OPTION_MODIFY_CHAT_TIP)
    Checkbox("MoveExaltedInactive", false, FFF_OPTION_MOVE_EXALTED, FFF_OPTION_MOVE_EXALTED_TIP)
    -- Checkbox("ReputationColors", false, FFF_OPTION_REPUTATION_COLORS)

    -- TODO: header for menu settings?
    -- Checkbox("CombatDisableMenu", true, FFF_OPTION_COMBAT_DISABLE, FFF_OPTION_COMBAT_DISABLE_TIP)
    -- TODO: non-settings text for FFF_OPTIONS_TIPS
    
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(FFF_OPTIONS_SWITCHBAR))

    local repGainParent = Checkbox("RepGained", true, FFF_OPTION_REP_GAINED)
    Checkbox("IncludeGuild", false, FFF_OPTION_GUILD_AUTOSWITCH, FFF_OPTION_GUILD_AUTOSWITCH_TIP, repGainParent)
    Checkbox("IncludeBodyguards", true, FFF_OPTION_BODYGUARD_AUTOSWITCH, FFF_OPTION_BODYGUARD_AUTOSWITCH_TIP, repGainParent)
    
    Settings.RegisterAddOnCategory(category)

end
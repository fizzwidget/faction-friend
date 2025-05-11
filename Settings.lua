local addonName, T = ...

function T:SetupSettings()
    local category, layout = Settings.RegisterVerticalLayoutCategory(T.Title)
    local settingsTable = T.Settings
    T.SettingsCategoryID = category:GetID()
    
    -- TODO: setup factories for other settings control types as needed
    -- TODO: shorter label locale-lookup keys, derive tooltip key from label
    local function Checkbox(settingKey, defaultValue, labelText, tooltipText, parentInit, onValueChanged)
        local variable = addonName .. "_" .. settingKey
        local setting = Settings.RegisterAddOnSetting(
            category, 
            variable, 
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
        if onValueChanged then
            Settings.SetOnValueChangedCallback(variable, onValueChanged)
        end
        return init
    end
    
    Checkbox("Tooltip", true, FFF_OPTION_TOOLTIP, FFF_OPTION_TOOLTIP_TIP)
    Checkbox("ModifyChat", true, FFF_OPTION_MODIFY_CHAT, FFF_OPTION_MODIFY_CHAT_TIP)
    Checkbox("MoveInactiveOnComplete", false, FFF_OPTION_MOVE_EXALTED, FFF_OPTION_MOVE_EXALTED_TIP)
    Checkbox("HighlightItems", true, FFF_OPTION_HIGHLIGHT_ITEMS, FFF_OPTION_HIGHLIGHT_ITEMS_TIP)

    ------------------------------------------------------
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(FFF_OPTIONS_POTENTIAL, FFF_OPTIONS_POTENTIAL_TIP))

    Checkbox("IncludeTimewarped", false, FFF_OPTION_TIMEWARPED, FFF_OPTION_TIMEWARPED_TIP, nil, T.ReputationStatusBarUpdate)
    Checkbox("ShowPotential", true, FFF_OPTION_SHOW_POTENTIAL, FFF_OPTION_SHOW_POTENTIAL_TIP, nil, T.ReputationStatusBarUpdate)
    
    ------------------------------------------------------
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(FFF_OPTIONS_WATCHBAR, FFF_OPTIONS_WATCHBAR_TIP:format(MAJOR_FACTION_WATCH_FACTION_BUTTON_LABEL)))

    local repGainParent = Checkbox("RepGained", true, FFF_OPTION_REP_GAINED, FFF_OPTION_REP_GAINED_TIP)
    Checkbox("IncludeGuild", false, FFF_OPTION_GUILD_SWITCH, FFF_OPTION_GUILD_SWITCH_TIP, repGainParent)
    Checkbox("IncludeBodyguards", true, FFF_OPTION_BODYGUARD_SWITCH, FFF_OPTION_BODYGUARD_SWITCH_TIP, repGainParent)
    
    Checkbox("EnableMenu", true, FFF_OPTION_ENABLE_MENU, FFF_OPTION_ENABLE_MENU_TIP, nil, T.ReputationStatusBarUpdate)
    -- TODO popup menu
    -- TODO: some place to put FFF_OPTIONS_TIPS about organizing menu


    ------------------------------------------------------
    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(FFF_OPTIONS_REP_PANE, FFF_OPTIONS_REP_PANE_TIP))
    
    Checkbox("AddRepPaneControls", true, FFF_OPTION_ADD_CONTROLS, FFF_OPTION_ADD_CONTROLS_TIP, nil, T.UpdateReputationPaneControls)
    Checkbox("HighlightFactions", true, FFF_OPTION_HIGHLIGHT, FFF_OPTION_HIGHLIGHT_TIP, nil)

    Settings.RegisterAddOnCategory(category)

end
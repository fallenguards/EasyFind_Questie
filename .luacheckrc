std = "lua51"
max_line_length = false

-- Suppress warnings that are standard WoW addon patterns, not real issues
ignore = {
    "431",  -- shadowing upvalue (self in nested callbacks is standard WoW pattern)
    "432",  -- shadowing upvalue argument
}

-- Globals this addon sets
globals = {
    "EasyFind",
    "EasyFindQuestieDB",
    "EasyFindDB",
    "EasyNotesDB",
    "EasyFind_OnAddonCompartmentClick",
    "SlashCmdList",
    "StaticPopupDialogs",
    "SLASH_EASYFIND1",
    "SLASH_EASYFINDCLEARCHAT1",
    "SLASH_EASYFINDNOTES1",
    "BINDING_NAME_EASYFIND_TOGGLE_FOCUS",
    "BINDING_NAME_EASYFIND_CLEAR",
    "BINDING_NAME_EASYFIND_MAP_FOCUS",
    "EncounterJournal",
    "TransmogFrame",
    "SettingsPanel",
    "TokenFrame",
    "QuickKeybindFrame",
    "SetItemRef",
}

-- WoW API globals (read-only)
read_globals = {
    "Questie", "QuestieLoader", "QuestieDB", "QuestiePlayer", "QuestieCompat",
    "QUESTS_LABEL", "QUEST_OBJECTIVES", "QUEST_LOG", "TRACK_QUEST", "UNTRACK_QUEST", "ABANDON_QUEST",
    "GetQuestLink", "QuestMapFrame_OpenToQuestDetails", "QuestMapQuestOptions_AbandonQuest", "GetQuestDifficultyColor",
    -- WoW Lua extensions
    "bit",
    "debugstack", "debugprofilestart", "debugprofilestop", "strsplit", "strtrim", "wipe", "hooksecurefunc",
    "format", "time", "date", "C_EventUtils", "GREEN_FONT_COLOR", "ItemRefTooltip",

    -- Alerts
    "C_SummonInfo", "C_UnitAuras", "UnitXPMax", "RequestRaidInfo", "issecretvalue", "IsResting", "StartDuel",
    "GetXPExhaustion", "GetWeaponEnchantInfo", "GetSavedInstanceInfo", "GetNumSavedInstances",
    "GetMaxPlayerLevel", "GetInboxNumItems", "GetInboxHeaderInfo", "UnitIsDead", "UnitClassification",
    -- Notes capture: the open mail and the selected quest
    "GetInboxText", "GetInboxItem", "GetInboxItemLink", "InboxFrame", "OpenMailFrame", "ATTACHMENTS_MAX_RECEIVE",
    "GetNumQuestLogRewards", "GetQuestLogRewardInfo", "GetNumQuestLogChoices", "GetQuestLogChoiceInfo",
    "GetQuestLogItemLink", "GetQuestLogRewardMoney", "GetQuestLogRewardXP", "GetCoinTextureString",
    "LOCALIZED_CLASS_NAMES_MALE", "LOCALIZED_CLASS_NAMES_FEMALE", "GetSubZoneText", "GetInventoryItemID",
    "GetCurrentRegion", "GetFactionInfoByID", "GetQuestResetTime",

    -- Menus
    "MenuUtil",
    "ColorPickerFrame", "TooltipDataProcessor", "tContains", "GetInstanceInfo",
    "UnitIsUnit", "C_PvP", "C_ChallengeMode", "GetNumClasses", "GetClassInfo", "GetNormalizedRealmName",

    -- Clock
    "FlashClientIcon", "GameTime_GetFormattedTime", "UnitAffectingCombat",

    -- ClassicUI Forever's public API (nil when that addon is not loaded)
    "ClassicUIForeverAPI",

    -- GPS: travel, taxi, character state
    "GetBindLocation", "UnitOnTaxi", "GetTaxiMapID", "IsMounted", "IsFlying", "IsSwimming", "UnitIsGhost", "C_DeathInfo",
    "UnitLevel", "UnitRace", "C_QuestLog", "C_Covenants", "MenuResponse",
    "SEARCH", "QUEST_DASH", "IN_GAME_NAVIGATION_RANGE",
    "GetRealZoneText", "EventRegistry", "C_EncodingUtil", "GetServerTime",

    -- Core API
    "DEFAULT_CHAT_FRAME", "DoEmote", "GetScreenWidth", "GetScreenHeight", "GetPhysicalScreenSize",
    "CreateFrame", "CreateFont", "CreateVector2D", "CreateColor",
    "GetTime", "GetLocale", "GetCVar", "SetCVar", "GetCursorPosition", "GetMouseButtonClicked", "GetRealmName",
    "SecondsToTime", "MacroFrameText", "ChatFrame1EditBox", "strlenutf8", "AddonCompartmentFrame",
    "GetAddOnMetadata", "GetAtlasInfo", "GetMinimapShape",
    "GetBindingKey", "GetBindingAction", "GetCurrentBindingSet", "SaveBindings", "SetBinding",
    "GetNumBindings", "GetBinding",
    "BattlefieldMapFrame", "MinimapCluster",
    "ToggleBag", "ToggleBackpack", "ToggleAllBags", "ToggleSheath",
    "ToggleCharacter", "ToggleAchievementFrame", "ToggleQuestLog", "ToggleFriendsFrame",
    "ToggleCollectionsJournal", "ToggleEncounterJournal", "ToggleGuildFrame",
    "TogglePVPUI", "PVEFrame_ToggleFrame", "C_VoiceChat",
    "GetBuildInfo", "WOW_PROJECT_ID", "WOW_PROJECT_CAMELOT", "WOW_PROJECT_CLASSIC", "WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
    "WOW_PROJECT_MISTS_CLASSIC", "RED_FONT_COLOR",
    "ToggleMinimap", "ToggleBattlefieldMap", "Sound_ToggleMusic", "Sound_ToggleSound",
    "ToggleChannelFrame", "ToggleQuickJoinPanel", "ToggleRaidFrame", "HousingFramesUtil",
    "VoiceChat_ToggleMutedFromUserAction", "VoiceChat_ToggleDeafenedFromUserAction",
    "GetCategoryInfo", "GetPlayerFacing",
    "SetPortraitTexture", "ShowUIPanel", "HideUIPanel", "ToggleWorldMap", "ToggleDropDownMenu",
    "InterfaceOptions_AddCategory", "InCombatLockdown",
    "IsShiftKeyDown", "IsMouseButtonDown", "IsAltKeyDown", "IsControlKeyDown",
    "IsInGroup", "IsInInstance", "IsIndoors", "UnitIsGroupLeader",
    "IsInRaid", "IsInGuild", "UnitExists", "UnitIsPlayer", "SendChatMessage",
    "ChatEdit_GetActiveWindow", "ChatEdit_InsertLink", "ChatEdit_ChooseBoxForSend",
    "ChatEdit_UpdateHeader", "ChatEdit_ActivateChat", "ChatEdit_OnTextChanged",
    "ChatFrameUtil", "NUM_CHAT_WINDOWS", "CHAT_FRAMES", "FCF_OpenTemporaryWindow", "STATICPOPUP_NUMDIALOGS",
    "SELECTED_CHAT_FRAME", "COMBATLOG", "CombatLogClearEntries",
    "ChatFrame_OpenChat", "DEFAULT_CHAT_FRAME",
    "UnitFactionGroup", "IsSpellKnown", "PlayerHasToy", "IsFlyableArea", "IsAdvancedFlyableArea", "geterrorhandler", "IsPlayerMoving", "IsFalling", "UnitPosition",
    "StaticPopup_Show", "GameTooltip_Hide", "PlaySound", "ReloadUI",
    "GetSpellInfo", "GetItemInfo", "UseToyByItemID", "GetItemClassInfo", "CreateAtlasMarkup",
    "GetSpellLink", "GetAchievementLink",
    "GetMacroSpell", "GetMacroItem",
    "PanelTemplates_GetSelectedTab", "CollectionsJournal_GetTab", "C_HeirloomInfo",
    "INVSLOT_MAINHAND", "INVSLOT_OFFHAND", "INVSLOT_RANGED",

    -- Frames and UI objects
    "UIParent", "GameTooltip", "WorldMapFrame", "WorldFrame", "Minimap", "MinimapCluster",
    "CharacterFrame", "PaperDollFrame", "AchievementFrame",
    "CharacterStatsPane", "PaperDollTitlesPane", "PaperDollEquipmentManagerPane",
    "CurrencyFrame",
    "SpellBookFrame", "PlayerSpellsFrame", "CollectionsJournal",
    "PVEFrame", "ReputationFrame", "TokenFramePopup",
    "GroupFinderFrame", "LFGListFrame", "HelpFrame", "ClassTalentFrame",
    "GameMenuFrame", "MacroFrame",
    "GuildMicroButton", "StoreMicroButton", "PlayerFrame", "StoreFrame",
    "LFDParentFrame", "RaidFinderFrame",
    "LFGListPVEStub", "LFGListPVPStub",
    "HonorFrame", "ConquestFrame", "TrainingGroundsFrame",
    "PVPQueueFrame",
    "AchievementFrameCategories_ExpandToCategory",
    "AchievementFrameCategories_UpdateDataProvider",
    "AchievementFrame_LoadUI", "AchievementFrame_SelectAchievement",
    "OpenAchievementFrameToAchievement",
    "AchievementFrame", "GetCategoryList", "GetCategoryNumAchievements",
    "GetStatisticsCategoryList", "GetStatistic",
    "GetAchievementInfo", "GetAchievementNumCriteria", "GetAchievementCriteriaInfo",
    "GetPreviousAchievement",
    "SetAchievementSearchString", "GetNumFilteredAchievements",
    "GetFilteredAchievementID",
    "AddTrackedAchievement", "RemoveTrackedAchievement",
    "IsTrackedAchievement", "AchievementFrame_ToggleTracking",
    "C_ContentTracking",
 "Transmog_LoadUI",
    "EncounterJournal_LoadUI", "EncounterJournal_DisplayInstance",
    "EncounterJournal_DisplayEncounter", "PanelTemplates_SetTab",
    "Menu", "ScrollBoxConstants",

    -- C_* namespaces
    "C_AddOns", "EventUtil", "C_AchievementInfo", "C_AreaPoiInfo", "C_ClassTalents",
    -- Clients differ: Caps.lua probes these and every one may be nil.
    "C_GameRules", "C_Housing", "GetTalentInfo", "GetNumTalentTabs", "C_DelvesUI", "C_PerksProgram", "C_EditMode", "C_WarbandScene",
    "C_ChatInfo", "C_CurrencyInfo", "C_EquipmentSet", "C_Item",
    "C_EncounterJournal", "C_GossipInfo", "C_Heirloom", "C_HousingCatalog", "C_HousingDecor", "C_LFGList", "C_MajorFactions", "C_Map",
    "C_Minimap", "C_MountJournal", "C_Navigation", "C_PetJournal",
    "C_Reputation", "C_SuperTrack", "C_TaxiMap", "C_Texture", "C_Timer",
    "C_ToyBox", "C_Traits", "C_TransmogCollection", "C_TransmogOutfitInfo",
    "C_TransmogSets", "C_VignetteInfo", "C_XMLUtil",

    -- UI utility functions
    "UIFrameFadeIn", "UIFrameFadeOut", "UIFrameFadeRemoveFrame",
    "AchievementFrameCategories_SelectElementData",
    "UnitPopup_ShowMenu", "BattlePetToolTip_ShowLink", "BattlePetTooltip",
    "GetUnitSpeed", "GetItemCooldown", "EJ_GetInstanceInfo", "UnitName",
    "GetItemInfoInstant", "GetItemStats", "GetSpecialization", "GetSpecializationInfo",
    "C_SpecializationInfo", "SetSpecialization",
    "GetNumSpecializations",
    "GetNumTitles", "GetTitleName", "IsTitleKnown", "GetCurrentTitle", "SetCurrentTitle",
    "GetNumSkillLines", "GetSkillLineInfo", "ExpandSkillHeader", "CollapseSkillHeader",
    "FauxScrollFrame_GetOffset", "SKILLS_TO_DISPLAY", "SKILLFRAME_SKILL_HEIGHT",
    "UnitClass", "UnitGUID", "GetLootSpecialization", "DressUpItemLink", "DressUpTransmogSet",
    "GetNumClasses", "GetClassInfo", "GetNumSpecializationsForClassID",
    "GetSpecializationInfoForClassID", "RAID_CLASS_COLORS", "GetNumExpansions",
    -- Inline answers (Search/Answers.lua): gold, item level, durability,
    -- keystone, rating.
    "GetMoney", "GetCoinTextureString", "GetAverageItemLevel",
    "COPPER_PER_SILVER", "COPPER_PER_GOLD",
    "GetInventoryItemDurability", "C_MythicPlus", "C_ChallengeMode",
    "UnitFullName", "GetNormalizedRealmName", "GetUnitName", "CopyTable",
    "GetProfessions", "GetProfessionInfo", "C_TradeSkillUI", "EnumerateFrames",
    "IsPlayerSpell",
    "EJ_GetCurrentTier", "EJ_SelectTier", "EJ_GetInstanceByIndex",
    "EJ_SelectInstance", "EJ_GetEncounterInfoByIndex", "EJ_SelectEncounter",
    "EJ_SetDifficulty", "EJ_SetLootFilter", "EJ_SetSlotFilter",
    "EJ_GetNumLoot", "EJ_GetLootInfoByIndex",
    "HasAction", "PlaceAction", "PickupAction", "ClearCursor", "GetActionCooldown",
    "CursorHasItem", "DeleteCursorItem",
    "PickupSpell", "PickupItem", "PickupMacro", "C_Spell",
    "GetCursorInfo", "GetMouseFoci", "GetMouseFocus",
    "SetCursor", "ResetCursor",
    "ACCEPT", "CANCEL", "StaticPopup_Show",
    "C_SpellBook", "C_Container", "C_Bank", "GetNumSpellTabs", "GetSpellTabInfo",
    "GetSpellBookItemInfo", "GetSpellBookItemName", "GetSpellBookItemTexture",
    "GetFlyoutInfo", "GetFlyoutSlotInfo",
    "GetContainerNumSlots", "GetContainerItemInfo", "PickupContainerItem",
    "NUM_BAG_SLOTS", "NUM_TOTAL_EQUIPPED_BAG_SLOTS",
    "GetNumMacros", "GetMacroInfo", "GetMacroIndexByName", "EditMacro", "MAX_ACCOUNT_MACROS",
    "ShowMacroFrame", "MacroFrame", "MacroFrame_SelectMacro", "MacroFrame_Update",
    "MacroFrame_OnTabChanged", "PanelTemplates_SetTab", "C_AddOns", "LoadAddOn",
    "CreateMacro",
    "SetOverrideBindingClick", "ClearOverrideBindings",

    -- Data types
    "UiMapPoint",

    -- Blizzard settings frames
    "InterfaceOptionsFrame",

    -- Constants, Enums, Mixins
    "Enum", "Settings", "BackdropTemplateMixin", "Mixin",
    "SOUNDKIT", "UIDROPDOWNMENU_OPEN_MENU", "UISpecialFrames",
    "FACTION_BAR_COLORS", "ITEM_QUALITY_COLORS",
    "LE_PET_JOURNAL_FILTER_COLLECTED", "LE_PET_JOURNAL_FILTER_NOT_COLLECTED",
    "LE_PARTY_CATEGORY_INSTANCE",

    -- Font objects
    "Game15Font_Shadow", "GameFontNormal", "GameFontNormalSmall",
    "GameFontHighlight", "GameFontHighlightSmall", "GameFontHighlightLarge",
    "GameFontDisable", "GameFontDisableSmall", "GameFontNormalLarge",

    -- Misc WoW API
    "securecallfunction", "GetCVarBool", "GetCurrentKeyBoardFocus",
    "IsKeyDown", "OpenBackpack", "OpenBag", "GetItemSpell",
    "StaticPopup_Visible", "IsGraphicsSettingValueSupported",
    "QuestScrollFrame", "LibStub",

    -- Localization / faction strings
    "FACTION_ALLIANCE", "FACTION_HORDE",
    "SETTINGS_CONFIRM_DISCARD", "SETTINGS_UNAPPLIED_EXIT",
    "SETTINGS_UNAPPLIED_APPLY_AND_EXIT", "SETTINGS_UNAPPLIED_CANCEL",

    -- Currency filter enums
    "CURRENCY_FILTER_TYPE_TRANSFERABLE", "CURRENCY_FILTER_TYPE_CHARACTER",
}

-- WoW callbacks have fixed signatures; unused args are normal
unused_args = false
self = false

exclude_files = {
    "dev/tests/vendor/*",
    -- The developer docs: annotations for editors and an example addon.
    "API/**",
    -- Local tooling under junctions that a checkout lacks.
    "dev/tools/roads/**",
}

-- The tests run on the lua in PATH (5.4): table.unpack, coroutine.isyieldable.
files["tests"] = { std = "max" }

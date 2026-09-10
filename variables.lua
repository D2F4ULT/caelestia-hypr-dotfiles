local scheme = require("scheme.current")

return {
    ------------------
    ---- HYPRLAND ----
    ------------------

    terminal = "foot",
    browser = "librewolf",
    editor = "codium",
    fileExplorer = "thunar",
    audioSettings = "pavucontrol",
    messenger = "Telegram",
    gitClient = "github-desktop",
    processViewer = "qps",

    -- Prefix graphical apps with app2unit so UWSM tracks them.
    appLauncher = "app2unit -- ",

    touchpadDisableTyping = true,
    touchpadScrollFactor = 0.3,
    gestureFingers = 3,
    workspaceSwipeFingers = 4,
    gestureFingersMore = 4,

    blurEnabled = true,
    blurSpecialWs = false,
    blurPopups = true,
    blurInputMethods = true,
    blurSize = 8,
    blurPasses = 2,
    blurXray = false,

    shadowEnabled = true,
    shadowRange = 15,
    shadowRenderPower = 4,
    shadowColour = "rgba(" .. scheme.inversePrimary .. "10)",

    workspaceGaps = 20,
    windowGapsIn = 5,
    windowGapsOut = 10,
    singleWindowGapsOut = 20,

    windowOpacity = 0.95,
    windowRounding = 15,
    windowBorderSize = 1,
    activeWindowBorderColour = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    volumeStep = 10,
    volumeMax = 100,
    cursorTheme = "sweet-cursors",
    cursorSize = 24,
    sleepGestureCmd = "systemctl suspend-then-hibernate",

    kbLayout = "us,ru",
    kbOptions = "grp:win_space_toggle",

    ------------------
    ---- KEYBINDS ----
    ------------------

    kbGoToWs = "SUPER",
    kbGoToWsGroup = "CTRL + SUPER",
    kbMoveWinToWs = "SUPER + ALT",
    kbMoveWinToWsGroup = "CTRL + SUPER + ALT",

    kbMoveWinToWsSpecial = { "SUPER + ALT + S", "CTRL + SUPER + SHIFT + Up" },
    kbMoveWinFromWsSpecial = "CTRL + SUPER + SHIFT + Down",
    kbMoveWinToWsNext = { "SUPER + ALT + mouse_down", "SUPER + ALT + Page_Down", "CTRL + SUPER + SHIFT + Right" },
    kbMoveWinToWsPrev = { "SUPER + ALT + mouse_up", "SUPER + ALT + Page_Up", "CTRL + SUPER + SHIFT + Left" },
    kbNextWs = { "SUPER + mouse_down", "CTRL + SUPER + Right", "SUPER + Page_Down" },
    kbPrevWs = { "SUPER + mouse_up", "CTRL + SUPER + Left", "SUPER + Page_Up" },
    kbNextWsGroup = "CTRL + SUPER + mouse_down",
    kbPrevWsGroup = "CTRL + SUPER + mouse_up",

    kbWindowCycleNext = "ALT + TAB",
    kbWindowCyclePrev = "SHIFT + ALT + TAB",
    kbWindowGroupCycleNext = "CTRL + ALT + TAB",
    kbWindowGroupCyclePrev = "CTRL + SHIFT + ALT + TAB",
    kbUngroup = "SUPER + U",
    kbToggleGroup = "SUPER + Comma",
    kbGroupLockActive = "SUPER + SHIFT + Comma",

    kbWindowDecreaseWidth = { "SUPER + Minus", "SUPER + ALT + Left" },
    kbWindowIncreaseWidth = { "SUPER + Equal", "SUPER + ALT + Right" },
    kbWindowDecreaseHeight = { "SUPER + SHIFT + Minus", "SUPER + ALT + Up" },
    kbWindowIncreaseHeight = { "SUPER + SHIFT + Equal", "SUPER + ALT + Down" },

    kbMoveWindow = "SUPER + Z",
    kbResizeWindow = "SUPER + X",
    kbCenterWindow = "CTRL + SUPER + Backslash",
    kbNormalizeWindow = "CTRL + SUPER + ALT + Backslash",
    kbWindowPip = "SUPER + ALT + Backslash",
    kbPinWindow = "SUPER + P",
    kbWindowFullscreen = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + ALT + F",
    kbToggleWindowFloating = "SUPER + ALT + Space",
    kbCloseWindow = "SUPER + Q",

    kbSpecialWs = "SUPER + S",
    kbSystemMonitorWs = "CTRL + SHIFT + Escape",
    kbMusicWs = "SUPER + M",
    kbCommunicationWs = "SUPER + D",
    kbTodoWs = "SUPER + R",

    kbTerminal = "SUPER + T",
    kbBrowser = "SUPER + W",
    kbEditor = "SUPER + CTRL + C",
    kbFileExplorer = "SUPER + E",
    kbAudioSettings = "CTRL + ALT + V",
    kbTelegram = "SUPER + SHIFT + T",
    kbGithub = "SUPER + G",
    kbProcessViewer = "CTRL + ALT + Escape",

    kbScreenshot = "Print",
    kbScreenshotClipboard = { "SUPER + SHIFT + S", "CTRL + SHIFT + S" },
    kbScreenshotRegion = "SUPER + SHIFT + ALT + S",
    kbRecord = "CTRL + ALT + R",
    kbRecordSound = "SUPER + ALT + R",
    kbRecordRegion = "SUPER + SHIFT + ALT + R",
    kbColorPicker = "SUPER + SHIFT + C",

    kbMediaToggle = "CTRL + SUPER + Space",
    kbMediaNext = "CTRL + SUPER + Equal",
    kbMediaPrev = "CTRL + SUPER + Minus",
    kbMediaStop = "CTRL + SUPER + Backspace",
    kbVolumeMute = "SUPER + SHIFT + M",

    -- Super tap. Release-bind + IPC; GlobalShortcut is broken for lone Super on 0.56.
    kbLauncher = { "SUPER + SUPER_L", "SUPER + SUPER_R" },
    kbSession = "CTRL + ALT + Delete",
    kbShowSidebar = "SUPER + N",
    kbClearNotifs = "SUPER + C",
    kbShowPanels = "SUPER + K",
    kbLock = "SUPER + L",
    kbRestoreLock = "SUPER + ALT + L",
    kbSleep = "SUPER + SHIFT + L",

    kbClipboard = "SUPER + V",
    kbClipboardDel = "SUPER + ALT + V",
    kbClipboardPasteLatest = "CTRL + SHIFT + ALT + V",
    kbEmoji = "SUPER + Period",
}

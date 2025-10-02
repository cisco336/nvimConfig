local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font_size = 14
config.font = wezterm.font("JetBrains Mono")

-- Theme
config.color_scheme = "tokyonight"

-- Window
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.window_padding = {
    left = "2cell",
    right = "2cell",
    top = "1cell",
    bottom = "1cell"
}
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Keys
config.keys = {
    {
        key = "d",
        mods = "CMD",
        action = wezterm.action.SplitVertical(
            {
                domain = "CurrentPaneDomain"
            }
        )
    }, {
        key = "d",
        mods = "SHIFT|CMD",
        action = wezterm.action.SplitHorizontal(
            {
                domain = "CurrentPaneDomain"
            }
        )
    }, {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane(
            {
                confirm = false
            }
        )
    }, {
        key = "w",
        mods = "SHIFT|CMD",
        action = wezterm.action.CloseCurrentTab(
            {
                confirm = false
            }
        )
    }, {
        key = "LeftArrow",
        mods = "SHIFT|CTRL",
        action = wezterm.action.SendString("\x1b\x5b1;5D")
    }, {
        key = "RightArrow",
        mods = "SHIFT|CTRL",
        action = wezterm.action.SendString("\x1b\x5b1;5C")
    }, {
        key = "UpArrow",
        mods = "SHIFT|CTRL",
        action = wezterm.action.SendString("\x1b\x5b1;5A")
    }, {
        key = "DownArrow",
        mods = "SHIFT|CTRL",
        action = wezterm.action.SendString("\x1b\x5b1;5B")
    }, -- Show the selector, using the quick_select_alphabet
    {
        key = "o",
        mods = "CTRL",
        action = wezterm.action(
            {
                PaneSelect = {}
            }
        )
    }, -- Show the selector, using your own alphabet
    {
        key = "p",
        mods = "CTRL",
        action = wezterm.action(
            {
                PaneSelect = {
                    alphabet = "0123456789"
                }
            }
        )
    }}

return config

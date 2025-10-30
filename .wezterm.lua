local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font_size = 14
config.font = wezterm.font("JetBrains Mono")

-- Theme
-- config.color_scheme = "tokyonight"
-- config.color_scheme = "Batman"
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Catppuccin Mocha (Gogh)'
-- config.color_scheme = 'matrix'
-- config.color_scheme = 'SynthwaveAlpha'
-- config.color_scheme = 'Synthwave Alpha (Gogh)'
config.color_scheme = 'synthwave'

-- Window
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
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

-- Tabs
config.colors = {
    tab_bar = {
        background = '#0b0022',
        active_tab = {
            bg_color = '#2b2042',
            fg_color = '#c0c0c0',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false
        },
        inactive_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080'
        },
        inactive_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true
        },
        new_tab = {
            bg_color = '#1b1032',
            fg_color = '#808080'
        },
        new_tab_hover = {
            bg_color = '#3b3052',
            fg_color = '#909090',
            italic = true
        }
    }
}

-- Inactive Panes
config.inactive_pane_hsb = {
    saturation = 0.6,
    brightness = 0.5
}

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
    }, {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action(
            {
                SendString = "\x1bf"
            }
        )
    }, {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action(
            {
                SendString = "\x1bb"
            }
        )
    }, {
        key = "k",
        mods = "CMD",
        action = wezterm.action.ClearScrollback("ScrollbackAndViewport")
    }}

return config

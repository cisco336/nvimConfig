local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- local theme = "tokyonight"
-- local theme = "Batman"
-- local theme = 'Catppuccin Mocha'
-- local theme = 'Catppuccin Mocha (Gogh)'
-- local theme = 'matrix'
local theme = 'SynthwaveAlpha'
-- local theme = 'Synthwave Alpha (Gogh)'
-- local theme = 'synthwave'

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup(
    {
        options = {
            icons_enabled = true,
            theme = theme,
            tabs_enabled = true,
            theme_overrides = {},
            section_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider
            },
            component_separators = {
                left = wezterm.nerdfonts.pl_left_soft_divider,
                right = wezterm.nerdfonts.pl_right_soft_divider
            },
            tab_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider
            }
        },
        sections = {
            tabline_a = {'mode'},
            tabline_b = {'workspace'},
            tabline_c = {' '},
            tab_active = {
                'index', {
                    'parent',
                    padding = 0
                }, '/', {
                    'cwd',
                    padding = {
                        left = 0,
                        right = 1
                    }
                }, {
                    'zoomed',
                    padding = 0
                }},
            tab_inactive = {
                'index', {
                    'process',
                    padding = {
                        left = 0,
                        right = 1
                    }
                }},
            tabline_x = {'ram', 'cpu'},
            tabline_y = {'datetime', 'battery'},
            tabline_z = {'domain'}
        },
        extensions = {}
    }
)

-- Font
config.font_size = 14
config.font = wezterm.font("JetBrains Mono")

-- Theme
config.color_scheme = theme

-- This should be after setting color_scheme
-- bar.apply_to_config(config)
tabline.apply_to_config(config)

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

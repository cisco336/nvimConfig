local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- local theme = "tokyonight"
-- local theme = "Batman"
-- local theme = 'Catppuccin Mocha'
-- local theme = 'Catppuccin Mocha (Gogh)'
-- local theme = 'matrix'
local theme = "SynthwaveAlpha"
-- local theme = 'Synthwave Alpha (Gogh)'
-- local theme = 'synthwave'

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

-- Font
config.font_size = 14
config.font = wezterm.font("JetBrains Mono")

-- Theme
config.color_scheme = theme

-- This should be after setting color_scheme
bar.apply_to_config(config, {
	padding = {
		left = 2,
		right = 3,
	},
	modules = {
		username = {
			enabled = false,
		},
		hostname = {
			enabled = false,
		},
	},
})

-- Window
config.window_close_confirmation = "NeverPrompt"
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
	bottom = "1cell",
}
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Inactive Panes
config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.5,
}

-- Keys
config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "d",
		mods = "SHIFT|CMD",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({
			confirm = false,
		}),
	},
	{
		key = "w",
		mods = "SHIFT|CMD",
		action = wezterm.action.CloseCurrentTab({
			confirm = false,
		}),
	},
	{
		key = "o",
		mods = "CTRL",
		action = wezterm.action({
			PaneSelect = {},
		}),
	}, -- Show the selector, using your own alphabet
	{
		key = "p",
		mods = "CTRL",
		action = wezterm.action({
			PaneSelect = {
				alphabet = "0123456789",
			},
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action({
			SendString = "\x1bf",
		}),
	},
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action({
			SendString = "\x1bb",
		}),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}

return config

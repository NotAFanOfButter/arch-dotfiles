local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config (config)

	config.font = wezterm.font_with_fallback {
		"Iosevka Term Slab Nerd Font",
		"IPAexGothic"
	}
	config.font_size = 20.0

	config.colors = {
		foreground = "#ff1300",
		background = "#040301",
		cursor_bg = "#fbeb96",
		cursor_fg = "#1a0c0c",
		cursor_border = "#fbf8f1",
		selection_fg = "#ff1300",
		selection_bg = "#fbf8f1",
		scrollbar_thumb = "#12183a",
		split = "#12183a",
		ansi = {
			"#1a0c0c", -- black:0
			"#f20f09", -- red:1
			"#ff5c39", -- green:2
			"#fbeb96", -- yellow:3
			"#c94a27", -- blue:4
			"#de4035", -- magenta:5
			"#ec8737", -- cyan:6
			"#80b1bf", -- white:7
		},
		brights = {
			"#51100c", -- black:8
			"#f20f09", -- red:9
			"#fd693b", -- green:A
			"#fcf5ad", -- yellow:B
			"#d14f35", -- blue:C
			"#de4035", -- magenta:D
			"#fc9052", -- cyan:E
			"#fbf8f1", -- white:F
		}
	}

	config.background = {
		{
			source = {File="/home/huginn/.config/leftwm/themes/eclipse/accent.png"},
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			vertical_align = "Middle",
			horizontal_align = "Center",
			opacity = .9,
		}
	}

end
return module

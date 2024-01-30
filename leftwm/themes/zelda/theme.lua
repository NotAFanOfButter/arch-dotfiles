local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config (config)

	config.font = wezterm.font "Iosevka Term Slab Nerd Font"
	config.font_size = 20.0

	config.colors = {
		foreground = "#f7f6cb",
		background = "#30504b",
		cursor_bg = "#f7f6cb",
		cursor_fg = "#30504b",
		cursor_border = "#061c17",
		selection_fg = "#061c17",
		selection_bg = "#5e8a74",
		scrollbar_thumb = "#12183a",
		split = "#12183a",
		ansi = {
			"#061c17", -- black:0
			"#f46221", -- red:1
			"#66bc34", -- green:2
			"#d79c20", -- yellow:3
			"#06aee0", -- blue:4
			"#b3789f", -- magenta:5
			"#4ecac6", -- cyan:6
			"#7f9b73", -- white:7
		},
		brights = {
			"#5e8a74", -- black:8
			"#f0101b", -- red:9
			"#91db6d", -- green:A
			"#fcce5e", -- yellow:B
			"#5eb5fc", -- blue:C
			"#f96d98", -- magenta:D
			"#a4e0e4", -- cyan:E
			"#a39d5d", -- white:F
		}

	}

end
return module

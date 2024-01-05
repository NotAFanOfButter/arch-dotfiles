local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config (config)

	config.font = wezterm.font "Iosevka Term Slab Nerd Font"
	config.font_size = 20.0

	config.colors = {
		foreground = "#fdffb1",
		background = "#0e0e26",
		cursor_bg = "#fdfbb1",
		cursor_fg = "#0e0e26",
		cursor_border = "#fdfbb1",
		selection_fg = "#2e5857",
		selection_bg = "#3dde76",
		scrollbar_thumb = "#12183a",
		split = "#12183a",
		ansi = {
			"#0e0e26",--"#7e837c",
			"#eb544d",
			"#b5eace",
			"#f1a780",
			"#4f6e82",
			"#92878d",
			"#fbfdfc",
			"#8c613e",
		},
		brights = {
			"#82b1a9",
			"#c83933",
			"#3dde76",
			"#f9a54f",
			"#2e5857",
			"#ffb3fe",
			"#89fcff",
			"#49283b",
		}

	}

end
return module

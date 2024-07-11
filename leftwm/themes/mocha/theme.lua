local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config (config)

	config.font = wezterm.font "Iosevka Term Slab Nerd Font"
	config.font_size = 20.0

	config.color_scheme = "Catppuccin Mocha"

end
return module

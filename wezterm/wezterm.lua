local wezterm = require 'wezterm'
local theme = require 'theme'
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_prog = { "/usr/bin/nu" }
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{
		key = "Enter",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "t",
		mods = "SUPER",
		action = wezterm.action.Nop,
	}
}
config.front_end = "WebGpu"

theme.apply_to_config(config)

return config

local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font("CommitMono Nerd Font Mono", { weight = "Regular" })
	config.font_size = 16.0
	config.line_height = 1.35

	-- Enable ligatures
	config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
end

return module

local config = {}
local general = require("config.general")
local appearance = require("config.appearance")
local font = require("config.font")
local keybinds = require("config.keybinds")

general.apply_to_config(config)
appearance.apply_to_config(config)
font.apply_to_config(config)
keybinds.apply_to_config(config)

return config

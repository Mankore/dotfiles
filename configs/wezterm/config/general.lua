local module = {}

function module.apply_to_config(config)
	config.max_fps = 120
	-- config.front_end = "WebGpu"

	-- behaviours
	config.automatically_reload_config = true
	config.exit_behavior = "CloseOnCleanExit" -- if the shell program exited with a successful status
	config.exit_behavior_messaging = "Verbose"
	config.status_update_interval = 1000

	config.scrollback_lines = 20000
end

return module

local module = {}

function module.apply_to_config(config)
	-- cursor
	config.animation_fps = 120
	config.cursor_blink_ease_in = "EaseOut"
	config.cursor_blink_ease_out = "EaseOut"
	config.default_cursor_style = "BlinkingBlock"
	config.cursor_blink_rate = 650

	-- tab bar
	config.hide_tab_bar_if_only_one_tab = true
	config.switch_to_last_active_tab_when_closing_tab = true

	-- Set window appearance
	config.window_background_opacity = 0.90 -- Slight transparency
	config.window_decorations = "RESIZE"

	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}

	-- Open WezTerm with a specific initial size
	config.initial_rows = 200
	config.initial_cols = 150

	config.inactive_pane_hsb = {
		saturation = 1,
		brightness = 1,
	}

	config.visual_bell = {
		fade_in_function = "EaseIn",
		fade_in_duration_ms = 250,
		fade_out_function = "EaseOut",
		fade_out_duration_ms = 250,
		target = "CursorColor",
	}
end

return module

-- Remove border, shadow, and modifications for Ulauncher
hl.window_rule({
	match = { class = "ulauncher" },
	name = "hide Ulauncher border",
	border_size = 0,
	no_shadow = true,
	no_blur = true,
	rounding = 0,
	focus_on_activate = true,
	stay_focused = true,
})

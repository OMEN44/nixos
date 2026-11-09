local config = require("contants")

hl.config({
	general = {
		border_size = math.floor(config.spacing.gap / 2),
		gaps_out = {
			bottom = config.spacing.gap,
			top = config.spacing.gap,
			left = config.spacing.gap,
			right = config.spacing.gap,
		},
		resize_on_border = true,
		col = {
			active_border = config.color.primary,
			inactive_border = config.color.secondary,
		},
	},
	decoration = {
		rounding = config.spacing.gap,
	},
	group = {
		auto_group = false, -- new windows don't get swallowed into the focused group
		col = {
			border_active = config.color.primary,
			border_inactive = config.color.secondary,
			border_locked_active = config.color.primary,
			border_locked_inactive = config.color.secondary,
		},
		groupbar = {
			-- No filled tabs: each tab is a thin line in the border colour with its title in
			-- the same colour, and a gap before the window.
			gradients = false, -- no background fill
			render_titles = true,
			height = 18,
			font_size = 11,
			text_color = config.color.primary, -- focused tab
			text_color_inactive = config.color.secondary, -- other tabs
			indicator_height = 2, -- the border line, same thickness as your window border
			indicator_gap = 2, -- space between the line and the title
			gaps_in = 2, -- space between tabs
			gaps_out = config.spacing.gap, -- space between the bar and the window
			keep_upper_gap = false,
			rounding = 12,
			col = {
				active = config.color.primary,
				inactive = config.color.secondary,
				locked_active = config.color.primary,
				locked_inactive = config.color.secondary,
			},
		},
	},
})

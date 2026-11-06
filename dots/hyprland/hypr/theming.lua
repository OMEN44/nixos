local config = require("contants")

hl.config({
	general = {
		border_size = math.floor(config.spacing.gap / 2),
		gaps_out = config.spacing.gap,
		resize_on_border = true,
		col = {
			active_border = config.color.primary,
			inactive_border = config.color.secondary,
		},
	},
	decoration = {
		rounding = config.spacing.gap,
	},
})

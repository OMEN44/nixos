local constants = require("contants")

local mod = "SUPER"
local terminal = "alacritty"
local menu = "ulauncher-toggle"
local vivaldi = "vivaldi"

--------------< Applications >--------------

hl.bind(mod .. "+Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. "+Q", hl.dsp.window.close())
hl.bind(mod .. "+Shift+Return", hl.dsp.exec_cmd(vivaldi))
hl.bind("Menu", hl.dsp.exec_cmd(menu))

--------------< Utilities >--------------

hl.bind(mod .. "+v", hl.dsp.exec_cmd("cursor-clip")) -- clipboard manager
hl.bind(mod .. "+Shift+c", hl.dsp.exec_cmd('color=$(hyprpicker -a) && wl-copy "$color"')) -- colour picker

--------------< Window management >--------------

hl.bind(mod .. "+Space", hl.dsp.window.float())
-- Move active window to another monitor using SUPER + SHIFT + Arrow keys
if constants.monitors.left or constants.monitors.right then
	hl.bind(mod .. "+SHIFT+left", hl.dsp.window.move({ monitor = "left", follow = true }))
	hl.bind(mod .. "+SHIFT+right", hl.dsp.window.move({ monitor = "right", follow = true }))
end
if constants.monitors.top or constants.monitors.bottom then
	hl.bind(mod .. "+SHIFT+up", hl.dsp.window.move({ monitor = "up", follow = true }))
	hl.bind(mod .. "+SHIFT+down", hl.dsp.window.move({ monitor = "down", follow = true }))
end
-- floating by default
hl.window_rule({
	match = { class = ".*" },
	float = true,
})
-- drag with SUPER + left mouse button
hl.bind(mod .. "+mouse:272", hl.dsp.window.drag())
local double_click_time = 0.3 -- seconds
local last_click_time = 0
hl.bind(mod .. "+mouse:272", function()
	local current_time = os.clock()
	if current_time - last_click_time <= double_click_time then
		hl.dsp.window.float()
	end
	last_click_time = current_time
end)

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
local hyprcapture = hl.plugin.hyprcapture
if hyprcapture then
	hl.bind("Print", hyprcapture.open_editor)
	hl.bind("SHIFT+Print", function()
		hyprcapture.open("fullscreen")
	end)
	hl.bind("ALT+Print", hyprcapture.record_toggle)
end

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
-- resize with SUPER + right mouse button
hl.bind(mod .. "+mouse:273", hl.dsp.window.resize())
-- move with SUPER + arrow keys
hl.bind(mod .. "+left", hl.dsp.window.move({ x = -50, y = 0, relative = true }))
hl.bind(mod .. "+right", hl.dsp.window.move({ x = 50, y = 0, relative = true }))
hl.bind(mod .. "+up", hl.dsp.window.move({ x = 0, y = -50, relative = true }))
hl.bind(mod .. "+down", hl.dsp.window.move({ x = 0, y = 50, relative = true }))
-- resize with SUPER + ALT + arrow keys
hl.bind(mod .. "+ALT+left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(mod .. "+ALT+right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mod .. "+ALT+up", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
hl.bind(mod .. "+ALT+down", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
-- minimise a window
hl.bind(mod .. "+X", function()
	if hl.get_workspace("special:minimized") then
		hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
		hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
	else
		hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
		hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
	end
end)
-- alt + tab to switch between windows
hl.bind("ALT+Tab", hl.dsp.window.cycle_next())
hl.bind("ALT+Shift+Tab", hl.dsp.window.cycle_next({ reverse = true }))

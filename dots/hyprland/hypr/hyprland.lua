local config = require("contants")

for position_name, monitor in pairs(config.monitors) do
	local position = ""
	if position_name == "center" then
		position = "0x0"
	elseif position_name == "left" then
		position = "-" .. tostring(monitor.width) .. "x0"
	elseif position_name == "right" then
		position = tostring(config.monitors.center.width) .. "x0"
	elseif position_name == "top" then
		position = "0x-" .. tostring(monitor.height)
	elseif position_name == "bottom" then
		position = "0x" .. tostring(config.monitors.center.height)
	end
	hl.monitor({
		output = monitor.name,
		mode = tostring(monitor.width) .. "x" .. tostring(monitor.height) .. "@" .. tostring(monitor.refresh),
		position = position,
		scale = monitor.scale,
	})
end
hl.env("XCURSOR_SIZE", "24")

local hyprcapture_plugin = os.getenv("HYPRCAPTURE_PLUGIN")
if hyprcapture_plugin then
	hl.plugin.load(hyprcapture_plugin)
end

-- Bring focused floating window to the top of the stack
hl.on("window.active", function(win)
	if win then
		hl.dsp.window.alter_zorder({ mode = "top" })
	end
end)

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 1,
		layout = "dwindle",
	},
	dwindle = {
		preserve_split = true,
		precise_mouse_move = true,
	},
	input = {
		kb_layout = "au",
		follow_mouse = 2,
		repeat_rate = 35,
		repeat_delay = 200,
		float_switch_override_focus = 0,
		touchpad = { natural_scroll = true },
	},
	debug = {
		disable_logs = false,
	},
	misc = {
		disable_splash_rendering = true,
		disable_hyprland_logo = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("cursor-clip --daemon")
	hl.exec_cmd("mako")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("quickshell")
	hl.exec_cmd("hyprpaper")
	if hyprcapture_plugin then
		os.execute("hyprctl reload")
	end
end)

-- Include additional configuration files
require("theming")
require("binds")
require("minimise")
require("window_snap")
require("window_rules")

local mod = "SUPER"
local M = {}

local function center(w)
	return w.at.x + w.size.x / 2, w.at.y + w.size.y / 2
end

-- The window on the same workspace that `w` overlaps the most (nil if none).
local function most_overlapped(w)
	local best, best_area = nil, 0
	for _, o in ipairs(hl.get_windows()) do
		if
			o.mapped
			and not o.hidden
			and o.workspace
			and o.workspace.name == w.workspace.name
			and o.address ~= w.address
		then
			local ix = math.min(w.at.x + w.size.x, o.at.x + o.size.x) - math.max(w.at.x, o.at.x)
			local iy = math.min(w.at.y + w.size.y, o.at.y + o.size.y) - math.max(w.at.y, o.at.y)
			if ix > 0 and iy > 0 and ix * iy > best_area then
				best, best_area = o, ix * iy
			end
		end
	end
	return best
end

-- Floating window `f` -> tab in the group of tiled window `t`: tile it beside `t`
-- (the cursor picks the tile), then fold it into that tile's group.
function M.stack_onto_tile(f, t)
	local tx, ty = center(t)
	hl.dispatch(hl.dsp.cursor.move({ x = tx, y = ty }))
	hl.dispatch(hl.dsp.layout("preselect r"))
	hl.dispatch(hl.dsp.window.float({ action = "disable" }))
	hl.dispatch(hl.dsp.window.move({ into_or_create_group = "l" }))
end

-- Floating window: stack it with whatever it is mostly over.
local function stack_floating(f)
	local t = most_overlapped(f)
	if not t then
		return
	end

	if t.floating then
		-- Floating onto floating: join the group in the direction of the other window.
		local fx, fy = center(f)
		local tx, ty = center(t)
		local dx, dy = tx - fx, ty - fy
		local dir = math.abs(dx) >= math.abs(dy) and (dx > 0 and "r" or "l") or (dy > 0 and "d" or "u")
		hl.dispatch(hl.dsp.window.move({ into_or_create_group = dir }))
	else
		M.stack_onto_tile(f, t)
	end
end

-- A group with a single tab left is pointless: dissolve it. Hyprland has no "tab left
-- the group" event for Lua, so check whenever focus changes (which is what happens
-- after a tab is pulled out or closed).
local tidying = false
function M.tidy()
	if tidying then
		return
	end
	tidying = true
	for _, w in ipairs(hl.get_windows()) do
		if w.mapped and w.group and w.group.size == 1 then
			hl.dispatch(hl.dsp.group.toggle({ window = w }))
		end
	end
	tidying = false
end

hl.on("window.active", M.tidy)

-- SUPER + G: floating window -> stack with the window under it;
--            tiled window    -> dissolve its whole group.
hl.bind(mod .. "+G", function()
	local w = hl.get_active_window()
	if not w then
		return
	end
	if w.floating then
		stack_floating(w)
	elseif w.group then
		hl.dispatch(hl.dsp.group.toggle())
	end
end)

-- SUPER + CTRL + arrow: floating window -> nudge it; tiled window -> stack it into
-- the window in that direction (creating a group there if needed).
local nudge = { left = { -50, 0 }, right = { 50, 0 }, up = { 0, -50 }, down = { 0, 50 } }
for dir, d in pairs(nudge) do
	hl.bind(mod .. "+CTRL+" .. dir, function()
		local w = hl.get_active_window()
		if not w then
			return
		end
		if w.floating then
			hl.dispatch(hl.dsp.window.move({ x = d[1], y = d[2], relative = true }))
		else
			hl.dispatch(hl.dsp.window.move({ into_or_create_group = dir:sub(1, 1) }))
		end
	end)
end

-- SUPER + Tab / SUPER + SHIFT + Tab: next / previous tab in the focused group.
hl.bind(mod .. "+Tab", hl.dsp.group.next())
hl.bind(mod .. "+SHIFT+Tab", hl.dsp.group.prev())

return M

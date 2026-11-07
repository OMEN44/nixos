local mod = "SUPER"

--------------< Helpers >--------------

-- Usable area of a monitor (excludes the Quickshell border and bar).
local function work_area(m)
	local r = m.reserved
	return { x = m.x + r.left, y = m.y + r.top, w = m.width - r.left - r.right, h = m.height - r.top - r.bottom }
end

-- Tiled windows on a workspace.
local function tiled_windows(ws)
	local list = {}
	for _, o in ipairs(hl.get_windows()) do
		if not o.floating and o.mapped and o.workspace and o.workspace.name == ws.name then
			list[#list + 1] = o
		end
	end
	return list
end

-- The tiled window nearest point `c` (the one Hyprland tiles a new window next to),
-- and its squared distance: 0 means the point is inside it.
local function nearest_tiled(tiled, c)
	local best, best_d
	for _, t in ipairs(tiled) do
		local dx = math.max(t.at.x - c.x, 0, c.x - (t.at.x + t.size.x))
		local dy = math.max(t.at.y - c.y, 0, c.y - (t.at.y + t.size.y))
		local d = dx * dx + dy * dy
		if not best_d or d < best_d then
			best, best_d = t, d
		end
	end
	return best, best_d
end

-- How are the tiled windows arranged? "row" = all full height (side by side),
-- "column" = all full width (stacked), nil = mixed or fewer than two windows.
local function chain_axis(tiled, monitor)
	if #tiled < 2 then
		return nil
	end
	local area = work_area(monitor)
	local row, col = true, true
	for _, t in ipairs(tiled) do
		row = row and t.size.y >= area.h * 0.9
		col = col and t.size.x >= area.w * 0.9
	end
	return (row and "row") or (col and "column") or nil
end

--------------< Snapping >--------------

-- Make the tiled, focused window `w` take the whole `dir` half of its monitor.
-- `total` is the number of tiled windows on the workspace, including `w`.
local function take_half(w, dir, total)
	-- Lift it to be a direct child of the layout root, so it spans a whole half.
	-- With only two windows it already is, and movetoroot would just warn.
	if total > 2 then
		hl.dispatch(hl.dsp.layout("movetoroot"))
	end

	local area = work_area(w.monitor)
	local horizontal = dir == "left" or dir == "right"

	-- Root split orientation: left/right needs side by side, up/down needs stacked.
	-- A window spanning nearly the full width means the split is currently stacked.
	if horizontal == (w.size.x > area.w * 0.75) then
		hl.dispatch(hl.dsp.layout("togglesplit"))
	end

	-- Which side it is on: window centre as a 0..1 position along the split axis.
	local pos = horizontal and (w.at.x + w.size.x / 2 - area.x) / area.w or (w.at.y + w.size.y / 2 - area.y) / area.h
	local wants_first = dir == "left" or dir == "up"
	if (pos < 0.5) ~= wants_first then
		hl.dispatch(hl.dsp.layout("swapsplit"))
	end
end

-- Preselect the split used for the next tiled window: put it on the side of `target`
-- that faces the rest of the row/column, so the original order survives take_half.
local function preselect_along(axis, tiled, target)
	local key = axis == "row" and "x" or "y"
	local first = true -- is the target the first window in the row/column?
	for _, t in ipairs(tiled) do
		if t.at[key] < target.at[key] then
			first = false
			break
		end
	end
	local dir = axis == "row" and (first and "right" or "left") or (first and "down" or "up")
	hl.dispatch(hl.dsp.layout("preselect " .. dir))
end

-- SUPER + arrow:
--   tiled window    -> move it in the layout (crosses to the next monitor at the edge);
--                      in a single row, up/down instead moves it to the top/bottom half
--   floating window -> tile it (alone on the workspace) or snap it to that half
local function snap(dir)
	local w = hl.get_active_window()
	if not w or not w.workspace or w.workspace.special then
		return
	end

	local tiled = tiled_windows(w.workspace)
	local axis = chain_axis(tiled, w.monitor)

	if not w.floating then
		if (dir == "up" or dir == "down") and axis == "row" then
			take_half(w, dir, #tiled)
		else
			hl.dispatch(hl.dsp.window.move({ direction = dir }))
		end
		return
	end

	-- Floating: when the tiled windows form a row or column, insert along it so the
	-- existing arrangement survives take_half.
	if axis then
		preselect_along(axis, tiled, (nearest_tiled(tiled, hl.get_cursor_pos())))
	end

	hl.dispatch(hl.dsp.window.float({ action = "disable" })) -- "disable" = tile
	if #tiled > 0 then
		take_half(w, dir, #tiled + 1)
	end
end

for _, dir in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mod .. "+" .. dir, function()
		snap(dir)
	end)
end

--------------< Drop a floating window into the layout >--------------

-- SUPER + SHIFT + drag a floating window, release over a tiled window: it is tiled
-- into the part of that window nearest the cursor (left, right, top or bottom),
-- like dropping a tab in an editor.
hl.bind(mod .. "+SHIFT+mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "+SHIFT+mouse:272", function()
	local w = hl.get_active_window()
	local c = hl.get_cursor_pos()
	if not w or not w.floating or not w.workspace or not c then
		return
	end

	local target, d = nearest_tiled(tiled_windows(w.workspace), c)
	if not target or d > 0 then
		return -- not dropped on a tiled window
	end

	-- Four triangles: the cursor's offset from the centre picks the side.
	local dx = c.x - (target.at.x + target.size.x / 2)
	local dy = c.y - (target.at.y + target.size.y / 2)
	local dir
	if math.abs(dy) * target.size.x < math.abs(dx) * target.size.y then
		dir = dx > 0 and "right" or "left"
	else
		dir = dy > 0 and "down" or "up"
	end

	hl.dispatch(hl.dsp.layout("preselect " .. dir)) -- one-shot, applies to the window about to be tiled
	hl.dispatch(hl.dsp.window.float({ action = "disable" }))
end, { release = true })

-- Minimise floating windows that overlap a tiled window when it gains focus,
-- plus Windows-style Alt+Tab.

local MINIMIZED = "special:minimized"

-- address -> where the window was before it was hidden
local hidden = {}
-- true while this file is moving or focusing windows, so its own actions
-- don't trigger the focus handler again
local busy = false

local function overlaps(ax, ay, aw, ah, bx, by, bw, bh)
	return ax < bx + bw and bx < ax + aw and ay < by + bh and by < ay + ah
end

local function run_guarded(fn)
	busy = true
	local ok, err = pcall(fn)
	busy = false
	if not ok then
		hl.notification.create({ text = "minimise.lua: " .. tostring(err), timeout = 5000, icon = "error" })
	end
end

--------------< Hide >--------------

hl.on("window.active", function(w)
	if busy or not w or w.floating or not w.workspace or w.workspace.special then
		return
	end

	run_guarded(function()
		for _, f in ipairs(hl.get_windows()) do
			if
				f.floating
				and f.mapped
				and not f.pinned
				and f.workspace
				and f.workspace.name == w.workspace.name
				and overlaps(f.at.x, f.at.y, f.size.x, f.size.y, w.at.x, w.at.y, w.size.x, w.size.y)
			then
				hidden[f.address] = {
					ws = f.workspace.name,
					x = f.at.x,
					y = f.at.y,
					w = f.size.x,
					h = f.size.y,
				}
				hl.dispatch(hl.dsp.window.move({ window = f, workspace = MINIMIZED, follow = false }))
			end
		end

		-- Moving windows away must never steal focus from the tile.
		local a = hl.get_active_window()
		if not a or a ~= w then
			hl.dispatch(hl.dsp.focus({ window = w }))
		end
	end)
end)

--------------< Show >--------------

-- Bring hidden windows back to where they were. `only_overlapping` is a window:
-- when given, only hidden windows whose old position overlaps it come back.
local function restore(only_overlapping)
	local prev = hl.get_active_window()

	run_guarded(function()
		local alive = {}
		for _, f in ipairs(hl.get_windows()) do
			alive[f.address] = true
			local rec = hidden[f.address]
			if
				rec
				and f.workspace
				and f.workspace.special
				and (
					not only_overlapping
					or (
						rec.ws == only_overlapping.workspace.name
						and overlaps(
							rec.x,
							rec.y,
							rec.w,
							rec.h,
							only_overlapping.at.x,
							only_overlapping.at.y,
							only_overlapping.size.x,
							only_overlapping.size.y
						)
					)
				)
			then
				local ws = hl.get_workspace(rec.ws) or hl.get_active_workspace()
				hl.dispatch(hl.dsp.window.move({ window = f, workspace = ws, follow = false }))
				-- Exactly as before: same size, same position, on top.
				hl.dispatch(hl.dsp.window.resize({ window = f, x = rec.w, y = rec.h }))
				hl.dispatch(hl.dsp.window.move({ window = f, x = rec.x, y = rec.y }))
				hl.dispatch(hl.dsp.window.alter_zorder({ window = f, mode = "top" }))
				hidden[f.address] = nil
			end
		end

		-- Forget windows that were closed while hidden.
		for address in pairs(hidden) do
			if not alive[address] then
				hidden[address] = nil
			end
		end

		-- Keep focus exactly where it was.
		local a = hl.get_active_window()
		if prev and (not a or a ~= prev) then
			hl.dispatch(hl.dsp.focus({ window = prev }))
		end
	end)
end

hl.bind("SUPER + SHIFT + F", function()
	restore(nil)
end)

hl.bind("SUPER + F", function()
	local w = hl.get_active_window()
	if w and w.workspace then
		restore(w)
	end
end)

--------------< Alt + Tab >--------------

-- Most recently used first, only windows of the same kind (tiled or floating) as
-- the focused one, only on visible workspaces, never hidden ones.
local function candidates(floating)
	local list = {}
	for _, w in ipairs(hl.get_windows()) do
		if
			w.mapped
			and not w.hidden
			and w.floating == floating
			and w.workspace
			and w.workspace.visible
			and not w.workspace.special
			and not hidden[w.address]
		then
			list[#list + 1] = w
		end
	end
	table.sort(list, function(a, b)
		local ia = a.focus_history_id < 0 and math.huge or a.focus_history_id
		local ib = b.focus_history_id < 0 and math.huge or b.focus_history_id
		return ia < ib
	end)
	return list
end

-- While Alt stays held, repeated Tab presses walk down the list as it was when the
-- first press happened. Releasing Alt ends the session.
local session = nil

local session_timer
session_timer = hl.timer(function()
	if not (hl.is_key_down("Alt_L") or hl.is_key_down("Alt_R")) then
		session = nil
		session_timer:set_enabled(false)
	end
end, { timeout = 80, type = "repeat" })
session_timer:set_enabled(false)

local function cycle(step)
	if not session then
		local a = hl.get_active_window()
		if not a then
			return
		end
		session = { list = candidates(a.floating), idx = 1 }
		for i, w in ipairs(session.list) do
			if w == a then
				session.idx = i
				break
			end
		end
		session_timer:set_enabled(true)
	end

	local n = #session.list
	if n < 2 then
		return
	end

	for _ = 1, n do
		session.idx = (session.idx - 1 + step) % n + 1
		local w = session.list[session.idx]
		if w.mapped then
			hl.dispatch(hl.dsp.focus({ window = w }))
			if w.floating then
				hl.dispatch(hl.dsp.window.alter_zorder({ window = w, mode = "top" }))
			end
			return
		end
	end
end

hl.bind("ALT + Tab", function()
	cycle(1)
end)
hl.bind("ALT + SHIFT + Tab", function()
	cycle(-1)
end)

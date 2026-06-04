local wezterm = require("wezterm")

local direction_keys = {
	LeftArrow = "Left",
	DownArrow = "Down",
	UpArrow = "Up",
	RightArrow = "Right",
}

local function toogle_term()
	return {
		key = ",",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			local tab = pane:tab()
			local panes_with_info = tab:panes_with_info()

			local have_only_one = #tab:panes() == 1
			if have_only_one then
				pane:split({ direction = "Bottom" })
				return
			end

			local pane_is_zoomed = false
			for _, pane_info in ipairs(panes_with_info) do
				if pane_info.is_active then
					pane_is_zoomed = pane_info.is_zoomed
					break
				end
			end

			if pane_is_zoomed then
				tab:set_zoomed(false)
				window:perform_action({ ActivatePaneDirection = "Down" }, pane)
			else
				window:perform_action({ ActivatePaneDirection = "Up" }, pane)
				tab:set_zoomed(true)
			end
		end),
	}
end

local keys = {
	toogle_term(),
	{
		key = ".",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

for key, dir in pairs(direction_keys) do
	table.insert(keys, {
		key = key,
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection(dir),
	})
	table.insert(keys, {
		key = key,
		mods = "CMD|OPT",
		action = wezterm.action.AdjustPaneSize({ dir, 3 }),
	})
end

return keys

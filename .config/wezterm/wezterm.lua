local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 30

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Macchiato"
  else
    return "Catppuccin Frappe"
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return config
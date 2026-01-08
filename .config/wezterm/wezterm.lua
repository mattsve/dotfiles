local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 30

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Modus-Vivendi-Tinted"
  else
    return "Modus-Operandi-Tinted"
  end
end

config.font = wezterm.font 'BlexMono Nerd Font Mono'

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.font_size = 14.0
config.window_frame = {
  font_size = 14.0,
  active_titlebar_bg = '#fbf7f0',
  inactive_titlebar_bg = '#fbf7f0'
}

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = '#c9b9b0',
      fg_color = '#000000'
    },
    inactive_tab = {
      bg_color = '#dfd5cf',
      fg_color = '#595959'
    },
    inactive_tab_hover = {
      bg_color = '#c9b9b0',
      fg_color = '#000000'
    },
    new_tab = {
      bg_color = '#dfd5cf',
      fg_color = '#595959'
    },
    new_tab_hover = {
      bg_color = '#c9b9b0',
      fg_color = '#000000'
    }
  }
}
config.use_fancy_tab_bar = true

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
  config.font_size = 11.0
  config.window_frame.font_size = 11.0
end

return config
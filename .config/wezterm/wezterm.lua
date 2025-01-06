-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = 'GruvboxDark'

config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.95

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/bin/fish', '-l' }

config.font = wezterm.font 'FiraMono Nerd Font'
config.font_size = 11

config.audible_bell = 'Disabled'

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

config.colors = {
  visual_bell = '#404020',  -- muted dark yellow
}

-- Event Handlers

wezterm.on('bell', function(window, pane)
  -- wayland has no system beep function, and is ugly in general, play sound here instead
  -- TODO: detect OS and use appropriate command, e.g. macOS:
  -- wezterm.run_child_process({'osascript', '-e', 'beep'})
  -- TODO: check if inside flatpak sandbox and prepend /var/run/host before /usr/share/...
  wezterm.background_child_process({'paplay', '/var/run/host/usr/share/sounds/Yaru/stereo/bell.oga'})
  -- TODO: display current proc info
  -- window:toast_notification('wezterm', 'bell rung in pane ' .. pane:pane_id() .. '!')
end)

-- and finally, return the configuration to wezterm
return config

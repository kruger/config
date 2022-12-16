
local wezterm = require 'wezterm';

local mux = wezterm.mux
local act = wezterm.action

return {
  font = wezterm.font("JetBrains Mono"),
  font_size = 22.0,
  line_height = 1.0,
  cell_width = 1.0,
  audible_bell = "Disabled",
  -- Need something better
  -- color_scheme = "ayu",
  harfbuzz_features = {"zero"},
  use_dead_keys = false,
  window_close_confirmation = "NeverPrompt",
  initial_cols = 124,
  initial_rows = 32,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = false,
  native_macos_fullscreen_mode = true,
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  -- timeout_milliseconds defaults to 1000 and can be omitted
  -- SUPER-b is close to tmux, but different.  Enables using tmux
  leader = { key = 'b', mods = 'SUPER', timeout_milliseconds = 1000 },
  keys = {
    -- This matches iTerm
    {key = 'f', mods = 'SUPER|CTRL', action = wezterm.action.ToggleFullScreen,},
    -- tmux-like stuff:
    -- Send "CTRL-B" to the terminal when pressing CTRL-B, CTRL-B
    {key = 'b', mods = 'LEADER|CTRL', action = act.SendString '\x01',},

    -- Pane splits
    {
      key = '|', mods = 'LEADER|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-', mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- Pane movement: vi-like bindings with ALT (my nvim uses CTRL)
    --[[ {key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left',}, ]]
    --[[ {key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right',}, ]]
    --[[ {key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up',}, ]]
    --[[ {key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down',}, ]]
    --[[ -- Pane adjustments ]]
    --[[ {key = 'H', mods = 'ALT', action = act.AdjustPaneSize {"Left", 2},}, ]]
    --[[ {key = 'L', mods = 'ALT', action = act.AdjustPaneSize {"Right", 2},}, ]]
    --[[ {key = 'K', mods = 'ALT', action = act.AdjustPaneSize {"Down", 2},}, ]]
    --[[ {key = 'J', mods = 'ALT', action = act.AdjustPaneSize {"Up", 2},}, ]]
    --[[ {key = 'z', mods = 'ALT', action = act.TogglePaneZoomState}, ]]
    --[[ {key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState}, ]]
    --[[ -- Copy mode ]]
    --[[ {key = 'e', mods = 'LEADER', action = act.ActivateCopyMode, }, ]]
    --[[ {key = 'k', mods = 'CTRL', action = act.CopyMode 'PageUp' }, ]]
  },
}


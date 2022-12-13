
local wezterm = require 'wezterm';

local mux = wezterm.mux
local act = wezterm.action

return {
  font = wezterm.font("JetBrains Mono"),
  font_size = 22.0,
  line_height = 1.0,
  cell_width = 1.0,
  audible_bell = "Disabled",
  color_scheme = "ayu",
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
  colors = {
      tab_bar = {
          -- The color of the strip that goes along the top of the window
          background = "#262626",

          -- The active tab is the one that has focus in the window
          active_tab = {
              -- The color of the background area for the tab
              bg_color = "#404040",
              -- The color of the text for the tab
              fg_color = "#c0c0c0",
              -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
              -- label shown for this tab.
              -- The default is "Normal"
              intensity = "Bold",
              -- Specify whether you want "None", "Single" or "Double" underline for
              -- label shown for this tab.
              -- The default is "None"
              underline = "None",
              -- Specify whether you want the text to be italic (true) or not (false)
              -- for this tab.  The default is false.
              italic = false,
              -- Specify whether you want the text to be rendered with strikethrough (true)
              -- or not for this tab.  The default is false.
              strikethrough = false,
          },

          -- Inactive tabs are the tabs that do not have focus
          inactive_tab = {
              bg_color = "#202020",
              fg_color = "#808080",
              -- The same options that were listed under the `active_tab` section above
              -- can also be used for `inactive_tab`.
          },
          -- You can configure some alternate styling when the mouse pointer
          -- moves over inactive tabs
          inactive_tab_hover = {
              bg_color = "#363636",
              fg_color = "#909090",
              italic = false,
              -- The same options that were listed under the `active_tab` section above
              -- can also be used for `inactive_tab_hover`.
          }
      }
  },

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
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
    {key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left',},
    {key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right',},
    {key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up',},
    {key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down',},
    -- Pane adjustments
    {key = 'H', mods = 'ALT', action = act.AdjustPaneSize {"Left", 2},},
    {key = 'L', mods = 'ALT', action = act.AdjustPaneSize {"Right", 2},},
    {key = 'K', mods = 'ALT', action = act.AdjustPaneSize {"Down", 2},},
    {key = 'J', mods = 'ALT', action = act.AdjustPaneSize {"Up", 2},},
    {key = 'z', mods = 'ALT', action = act.TogglePaneZoomState},
    {key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState},
    -- Copy mode
    {key = 'e', mods = 'LEADER', action = act.ActivateCopyMode, },
    {key = 'u', mods = 'CTRL', action = act.CopyMode 'PageUp' },
  },
}


local module = {}

local wezterm = require 'wezterm';
local act = wezterm.action

-- When I use workspaces, I don't use tmux so I over-write the tmux bindings
module.keys = {
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

    -- workspace
    {key = 'w', mods = 'LEADER',
      -- action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
      action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
    },
    { key = 'n', mods = 'LEADER', action = act.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.SwitchWorkspaceRelative(-1) },

  }

return module

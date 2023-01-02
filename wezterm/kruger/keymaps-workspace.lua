-- When I use workspaces, I don't use tmux so I over-write the tmux bindings so I keep a separate file
-- Note that the merge command does not actually merge so I have to duplicate the same keys as keymaps.lua.   
-- This is annoying, but I am not good enough at lua to know how to fix
local module = {}

local wezterm = require 'wezterm';
local act = wezterm.action

-- timeout_milliseconds defaults to 1000 and can be omitted
-- SUPER-b is close to tmux, but different.  Enables using tmux
module.leader = { key = 'b', mods = 'SUPER', timeout_milliseconds = 1000 }


module.keys = {
    -- This matches iTerm
    {key = 'f', mods = 'SUPER|CTRL', action = act.ToggleFullScreen,},
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
    -- Copy mode
    {key = 'e', mods = 'LEADER', action = act.ActivateCopyMode, },
    -- Default is CTRL-u which I like, but it doesn't work by default
    -- When set manually, it works, but then it takes over non-copy-mode usage
    {key = 'k', mods = 'CTRL', action = act.CopyMode 'PageUp' },
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

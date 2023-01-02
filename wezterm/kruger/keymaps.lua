local module = {}

local wezterm = require 'wezterm';
local act = wezterm.action

-- See also keymaps-workspace.lua.   I should probably figure out bindings 
-- that don't conflict with tmux, or not?   Brain can only do so much

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
  }

return module

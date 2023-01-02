
local wezterm = require 'wezterm';

local act = wezterm.action
local mux = wezterm.mux

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

wezterm.on('gui-startup', function(cmd)
  -- allow `wezterm start -- something` to affect what we spawn
  -- in our initial window
  local args = {}
  if cmd then
    args = cmd.args
  end
  ----------------------------------------------------------------------
  --  Personal workspace
  ----------------------------------------------------------------------
  -- This is in a separate workspace
  local personal_tab, personal_pane, personal_window = mux.spawn_window {
    workspace = 'Personal',
    cwd = wezterm.home_dir .. '/pub/pim',
    -- args = { 'ssh', 'vault' },
  }
  personal_tab:set_title 'RST'
  personal_window:set_title 'Personal'

  -- Second tab is for management
  local mngt_tab, mngt_pane, mngt_window = personal_window:spawn_tab {
    cwd = wezterm.home_dir .. '/TechX/management',
  }
  mngt_tab:set_title 'management'

  -- Next tab is for pub
  local pub_tab, pub_pane, pub_window = personal_window:spawn_tab {
    cwd = wezterm.home_dir .. '/pub',
  }
  pub_tab:set_title 'pub'

  -- Next tab is for spotify
  local spot_tab, spot_pane, spot_window = personal_window:spawn_tab {
         cwd = wezterm.home_dir .. '/.config/spotify-tui',
  }
  spot_tab:set_title 'spotify'
    -- second pane is for the daemon
    local dmn_pane = spot_pane:split {
        cwd = wezterm.home_dir .. '/.config/spotifyd',
        direction = 'Right',
        size = 0.3,

    }

  ----------------------------------------------------------------------
  --  software workspace
  ----------------------------------------------------------------------
  -- This is in a separate workspace
  local software_tab, software_pane, software_window = mux.spawn_window {
    workspace = 'software',
    cwd = wezterm.home_dir .. '/config/software',
    -- args = { 'ssh', 'vault' },
  }
  software_window:set_title 'software'
  software_tab:set_title 'brew'

  -- Second tab is for management
  local mngt_tab, mngt_pane, mngt_window = software_window:spawn_tab {
    cwd = wezterm.home_dir .. '/config/software',
  }
  mngt_tab:set_title 'mamba/conda/pip'

  -- Next tab is for pub
  local pub_tab, pub_pane, pub_window = software_window:spawn_tab {
    cwd = wezterm.home_dir .. '/config/software',
  }
  pub_tab:set_title 'config'

  ----------------------------------------------------------------------
  --  EFIT-AI workspace
  ----------------------------------------------------------------------
  local efitall_dir = wezterm.home_dir .. '/efitairoot/efitall'
  -- Main window and tab
  local efittab, efit_pane, efit_window = mux.spawn_window {
    workspace = 'efitai',
    cwd = efitall_dir .. '/efit',
  }
  efit_window:set_title 'EFIT-AI'
  -- Because set_title doesn't work. Requires bash function settitle
  -- This doesn't work either
  -- efit_pane:send_text 'settitle EFIT\n'


    -- Main tab, second pane is for building efit
    local build_pane = efit_pane:split {
        direction = 'Right',
        size = 0.4,
        cwd = efitall_dir .. '/efit/build',
    }
  -- Second tab is for efitaidb (not sure why spawn_tab returns window)
  local edb_tab, edb_pane, edb_window = efit_window:spawn_tab { 
      cwd = efitall_dir .. '/efitai_database',
  }
    -- Second tab, second pane is for python repl
    local repl_pane = edb_pane:split {
        direction = 'Right',
        size = 0.3,
    }
  -- Third tab is for project management
  local epm_tab, epm_pane, epm_window = efit_window:spawn_tab {
    cwd = wezterm.home_dir .. '/efitairoot/project'
  }

  ----------------------------------------------------------------------
  --  PETSc workspace
  ----------------------------------------------------------------------
  local petsc_dir = wezterm.home_dir .. '/ptroot/upstream/petsc'
  -- Main window and tab
  local petsc_tab, petsc_pane, petsc_window = mux.spawn_window {
    workspace = 'petsc',
    cwd = petsc_dir,
  }
  petsc_window:set_title 'PETSc'
  -- Because set_title doesn't work
  -- This doesn't work either
  -- petsc_pane:send_text 'echo -n -e "\033]0;PETSc\007"\n'

    -- Main tab, second pane is for building petsc
    local pbuild_pane = petsc_pane:split {
        direction = 'Right',
        size = 0.3,
        cwd = petsc_dir,
        -- cwd = petsc_dir .. '/build',
    }
  -- Second tab is for petsc as well
  local p2_tab, p2_pane, p2_window = petsc_window:spawn_tab { 
      cwd = petsc_dir,
  }
    -- Second tab, second pane is for more building
    local repl_pane = p2_pane:split {
        direction = 'Right',
        size = 0.3,
    }
  -- Third tab is for project management
  local p3_tab, p3_pane, p3_window = petsc_window:spawn_tab {
    cwd = wezterm.home_dir .. '/ptroot/project'
  }

  ----------------------------------------------------------------------
  -- Set which one is active
  ----------------------------------------------------------------------
  mux.set_active_workspace 'efitai'
  -- mux.set_active_workspace 'Personal'
end)

return {
  unix_domains = {
    { -- The name; must be unique amongst all domains
      name = 'unix',
    },
  },
  font = wezterm.font("JetBrains Mono"),
  font_size = 18.0,
  audible_bell = "Disabled",
  -- color_scheme = "ayu",
  window_frame = {
    -- The font used in the tab bar.
    font_size = 18.0,
  },
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },
  colors = {
      -- Should probably use format-tab-title event intead: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
      --[[ tab_bar = { ]]
      --[[     -- The color of the strip that goes along the top of the window ]]
      --[[     background = "#FFFFFF", ]]
      --[[]]
      --[[     -- The active tab is the one that has focus in the window ]]
      --[[     active_tab = { ]]
      --[[         -- The color of the background area for the tab ]]
      --[[         bg_color = "#FFFFFF", ]]
      --[[         -- The color of the text for the tab ]]
      --[[         fg_color = "#000000", ]]
      --[[         -- Specify whether you want "Half", "Normal" or "Bold" intensity for the ]]
      --[[         -- label shown for this tab. ]]
      --[[         -- The default is "Normal" ]]
      --[[         intensity = "Bold", ]]
      --[[         underline = "None", ]]
      --[[         italic = false, ]]
      --[[         strikethrough = false, ]]
      --[[     }, ]]
      --[[     -- Inactive tabs are the tabs that do not have focus ]]
      --[[     inactive_tab = { ]]
      --[[         bg_color = "#202020", ]]
      --[[         fg_color = "#808080", ]]
      --[[     }, ]]
      --[[     -- alternate styling when the mouse pointer moves over inactive tabs ]]
      --[[     inactive_tab_hover = { ]]
      --[[         bg_color = "#363636", ]]
      --[[         fg_color = "#909090", ]]
      --[[         italic = false, ]]
      --[[     } ]]
      --[[ } ]]
  },  harfbuzz_features = {"zero"},
  use_dead_keys = false,
  enable_scroll_bar = true,
  window_close_confirmation = "NeverPrompt",
  initial_cols = 128,
  initial_rows = 52,
  hide_tab_bar_if_only_one_tab = true,
  native_macos_fullscreen_mode = true,
  automatically_reload_config = false,
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
    -- Default is CTRL-u which I like, but it doesn't work by default
    -- When set manually, it works, but then it takes over non-copy-mode usage
    {key = 'k', mods = 'CTRL', action = act.CopyMode 'PageUp' },

    -- workspace
    {key = 'w', mods = 'LEADER',
      -- action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
      action = act.ShowLauncherArgs { flags = 'WORKSPACES' },
    },
    { key = 'n', mods = 'LEADER', action = act.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.SwitchWorkspaceRelative(-1) },

  },
}


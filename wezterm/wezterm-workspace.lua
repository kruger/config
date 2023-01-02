
local wezterm = require 'wezterm';
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

local merge = require('kruger.utils').merge
local basic = require('kruger.basic')
local appearance = require('kruger.appearance')
local keywork = require('kruger.keymaps-workspace')

return merge(basic, appearance, keywork)

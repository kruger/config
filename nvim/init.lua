-- See lua/user/lua/init.lua-- Developed on 2022-11-18 by following the video series accompanying:
-- https://github.com/LunarVim/neovim-from-scratch
require "user.options" -- See lua/user/options.lua ; the lua is implied
require "user.keymaps"
require "user.plugins"
-- the rest are essentially settings for plugins so need both plugin changes and deactivation here
require "user.colorscheme"
require "user.cmp" -- completion
require "user.lsp" -- See lua/user/lua/init.lua
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment" -- easily comment with gc
require "user.gitsigns"
require "user.nvim-tree"
require "user.lualine"
require "user.tabline" -- alternative to bufferline that uses lualine themes 
-- require "user.bufferline"
require "user.toggleterm"
require "user.dap"  -- TODO: Need to actually learn about the nvim-dap plugin, mappings, etc.
require "user.impatient"
require "user.project"

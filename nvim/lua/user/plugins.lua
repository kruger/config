local fn = vim.fn

-- Automatically install packer
-- This is really: $HOME/.local/share/nvim/site/pack/packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
-- ------------------------------------------------------------------------
-- Install your plugins here
-- ------------------------------------------------------------------------
  use{"wbthomason/packer.nvim"} -- Have packer manage itself
  use{"nvim-lua/popup.nvim"} -- An implementation of the Popup API from vim in Neovim
  use{"nvim-lua/plenary.nvim"} -- Useful lua functions used ny lots of plugins
  use{"windwp/nvim-autopairs"} -- Autopairs, integrates with both cmp and treesitter
  use{"numToStr/Comment.nvim"} -- Easily comment stuff -- Need this: 'JoosepAlviste/nvim-ts-context-commentstring'
  use{"kyazdani42/nvim-web-devicons"}
  use{"kyazdani42/nvim-tree.lua"}
  -- use{"akinsho/bufferline.nvim"}
  use{"kdheepak/tabline.nvim"}
  use{"moll/vim-bbye"}
  use{"nvim-lualine/lualine.nvim"}
  use{"akinsho/toggleterm.nvim"}
  use{"lewis6991/impatient.nvim"} -- this speeds up lua install
  use{"ahmedkhalf/project.nvim"}  -- This helps define a project directory automatically, which helps lsp
  -- TODO - SEK: This looks like a good plugin. https://github.com/ggandor/leap.nvim (along with spooky and flit)


  -- cmp plugins  (there are more.  If you add one, then you'll need to add source)
  use{"hrsh7th/nvim-cmp"} -- The completion plugin
  use{"hrsh7th/cmp-buffer"} -- buffer completions
  use{"hrsh7th/cmp-path"} -- path completions
  use{"hrsh7th/cmp-cmdline"} -- cmdline completions
  use{"saadparwaiz1/cmp_luasnip"} -- snippet completions
  use{"hrsh7th/cmp-nvim-lsp"}
  use{"hrsh7th/cmp-nvim-lua"}

  -- snippets
  use{"L3MON4D3/LuaSnip"} --snippet engine
  use{"rafamadriz/friendly-snippets"} -- a bunch of snippets to use

  -- LSP
  use{"neovim/nvim-lspconfig"} -- enable LSP
  use{"williamboman/mason.nvim"} -- simple to use language server installer
  use{"williamboman/mason-lspconfig.nvim"} -- simple to use language server installer
  config = function()
      require("vim.core.mason").setup()
  end
  -- TODO - SEK: This looks like a good plugin. https://github.com/glepnir/lspsaga.nvim

  -- use clangd for LSP server.  This helps with that
  -- See: lua/user/lsp/mason.lua
  use{"p00f/clangd_extensions.nvim"}

  -- DAP: Debugger access protocol (this works with mason as well)
  use{"mfussenegger/nvim-dap"} -- Main plugin
  use{"nvim-telescope/telescope-dap.nvim"}
  use{"mfussenegger/nvim-dap-python"}
  -- TODO - SEK: Need to figure this out
  -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- Linters and formatters (this works with mason as well)
  use{"jose-elias-alvarez/null-ls.nvim"} -- for formatters and linters


  -- Telescope
  use{"nvim-telescope/telescope.nvim"}
  use{"nvim-telescope/telescope-media-files.nvim"}

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use{"JoosepAlviste/nvim-ts-context-commentstring"}
  use{"p00f/nvim-ts-rainbow"}
  use{"nvim-treesitter/playground"}

  -- Git
  use{"lewis6991/gitsigns.nvim"}
  -- ------------
  -- Colorschemes
  -- ------------
  use{"marko-cerovac/material.nvim"}
  use{"lunarvim/colorschemes"}
  use{"lunarvim/darkplus.nvim"}
  use{"folke/tokyonight.nvim"}  -- this has lots of options as well

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

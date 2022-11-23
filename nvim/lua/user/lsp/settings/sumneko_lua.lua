return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}




local configs = require 'nvim_lsp/configs'
local util = require 'nvim_lsp/util'

local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
configs.clangd = {
  default_config = util.utf8_config {
}

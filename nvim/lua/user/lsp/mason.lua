
-- SEK: Even though one can LspInstall them, for some reason they need to be added to this list to actually work
-- SEK: Also note that you should have the settings files created in the settings subdir
local servers = {
	"sumneko_lua",
	"pyright",
	"jsonls",
	"clangd",
  -- ccls : See https://jdhao.github.io/2020/11/29/neovim_cpp_dev_setup/
	"bashls",
  "fortls",
  "pyright",
  "texlab",
  "cmake",
  "prosemd_lsp",
 }
-- Not sure why I can LspInstall them but then get errors :
--  "grammarly",
--  "marksman", -- crashes
--  "json-lsp",
--  "grammarly-languageserver",

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

  -- SEK: this loads the settings in the settings/*.lua files
	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

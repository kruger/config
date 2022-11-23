local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- SEK:  This is where the external linters and prettier's are configured
-- TODO-SEK:  Need to add a lot of other formatters and perhaps code actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- TODO-SEK:  clang_format/clang_check, cppcheck, uncrustify
-- TODO-SEK:  cmake_lint, checkmake
-- TODO-SEK:  Multiple python linters (black/flake8/yapf), isort/usort
-- TODO-SEK:  fprettify
-- TODO-SEK:  commitlint/gitlint
-- TODO-SEK:  beautysh
-- TODO-SEK:  (*spell* esp. misspell)/proselint/write_good/dictionary
-- TODO-SEK:  rstcheck
-- TODO-SEK:  yamllint/yamlfmt
-- TODO-SEK:  markdownlint(_CLI2)/mdl/mdformat/remark/textlint 
-- TODO-SEK:  chktex/bibclean/latexindent
-- TODO-SEK:  prettier does many languages by themselves (Markdown, rust, sh, toml, yaml, html)  See also prettierd
--
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    formatting.black,
    formatting.clang_format,
    -- formatting.black.with { extra_args = { "--fast" } },
    -- formatting.yapf,
    formatting.stylua,
    diagnostics.flake8,
  },
}

local status_ok, clangd_extensions = pcall(require, "clangd_extensions")
if not status_ok then
  return
end

clangd_extensions.setup {
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            only_current_line = false, -- Only show inlay hints for the current line

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            show_parameter_hints = true,      -- whether to show parameter hints with the inlay hints or not
            parameter_hints_prefix = "<- ",   -- prefix for parameter hints
            other_hints_prefix = "=> ",       -- prefix for all the other hints (type, chaining)
            max_len_align = false,            -- whether to align to the length of the longest line in the file
            max_len_align_padding = 1,        -- padding from the left if max_len_align is true
            right_align = false,              -- whether to align to the extreme right or not
            right_align_padding = 7,          -- padding from the right if right_align is true
            highlight = "Comment",            -- The color of the hints
            priority = 100,                   -- The highlight group priority for extmark
        },
        ast = {
            -- These are unicode, should be available in any font
            role_icons = {
                 type = "🄣",
                 declaration = "🄓",
                 expression = "🄔",
                 statement = ";",
                 specifier = "🄢",
                 ["template argument"] = "🆃",
            },
            kind_icons = {
                Compound = "🄲",
                Recovery = "🅁",
                TranslationUnit = "🅄",
                PackExpansion = "🄿",
                TemplateTypeParm = "🅃",
                TemplateTemplateParm = "🅃",
                TemplateParamObject = "🅃",
            },
            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

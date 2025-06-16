vim.lsp.config("*", {
    capabilities = vim.lsp.protocol.make_client_capabilities()
})

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "vimls",
        "clangd",
        "rust_analyzer",
        -- "pyright",
        "basedpyright",
        -- "ruff",
        "gopls",
        -- TODO: https://www.elixir-tools.dev/news/the-elixir-tools-update-vol-7/
        "superhtml",
        "tailwindcss",
        "denols",
    },
}

vim.lsp.enable("gdscript")

require("blink.cmp").setup {
    keymap = {
        preset = "super-tab",
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
        list = {
            selection = {
                preselect = function(ctx)
                    return not require('blink.cmp').snippet_active({ direction = 1 })
                end,
            },
        },
    },
    signature = {
        enabled = true,
    },
}

require("mason-null-ls").setup {
    ensure_installed = {
        "cspell",
        "gdtoolkit",
        "clang_format",
        "golines",
        "htmlhint",
        "stylelint",
        "markdownlint",
        -- TODO: consider biome instead?
        "prettierd",
    },
    automatic_installation = false,
    handlers = {},
}

-- none-ls exposes backwards-compatible null-ls namespace
local null_ls = require("null-ls")
null_ls.setup {
    sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.gdlint,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.gdformat,
        null_ls.builtins.formatting.golines,
        -- TODO: htmlhint?
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylelint,
    },
}

-- TODO: debug adapters (DAP)

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufWritePost" }, {
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end,
})

vim.lsp.config("*", {
    capabilities = vim.lsp.protocol.make_client_capabilities()
})

require("mason").setup()
require("mason-lspconfig").setup {
    -- TODO: only ensure_installed if node is runnable command?
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
    -- TODO: only ensure_installed if node is runnable command?
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

require("gp").setup {
    providers = {
        ollama = {
            endpoint = (os.getenv("OLLAMA_API_BASE") or "http://localhost:11434") .. "/v1/chat/completions",
        },
        openai = {
            disable = true,
            endpoint = "https://api.openai.com/v1/chat/completions",
            -- secret = {"op", "item", "get", "OpenAI Dev ENV Key (phoenix)", "--vault", "Private", "--field", "api key", "--reveal",},
            secret = os.getenv("OPENAI_API_KEY"),
        },
        anthropic = {
            disable = true,
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = os.getenv("ANTHROPIC_API_KEY"),
        },
        copilot = {
            disable = true,
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
                "bash",
                "-c",
                "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
        },
        googleai = {
            disable = true,
            endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
            secret = os.getenv("GOOGLEAI_API_KEY"),
        },
    },
    agents = {
        {name = "ChatOllamaLlama3.1-8B", disable = true},
        {name = "CodeOllamaLlama3.1-8B", disable = true},
        {
            provider = "ollama",
            name = "ChatOllamaQwen3.5-9B",
            chat = true,
            command = true,
            model = {
                model = "qwen3.5:9b",
                -- num_ctx = 8192,
            },
            -- TODO: where to globally define this?
            system_prompt = "You are a general AI assistant.",
        },
        {
            disable = true,
            provider = "ollama",
            name = "ChatOllamaQwen3.5-27B",
            chat = true,
            command = true,
            model = {
                model = "qwen3.5:27b",
                -- temperature = 1.9,
                -- top_p = 1,
                -- num_ctx = 8192,
            },
            -- TODO: where to globally define this?
            system_prompt = require("gp.defaults").code_system_prompt,
        },
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

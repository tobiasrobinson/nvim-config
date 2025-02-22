return {
    -- Mason.nvim for managing LSP servers, DAP servers, linters, and formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSPConfig for easier integration between mason.nvim and nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "clangd", "tailwindcss" }, -- Use "ts_ls" if it's a valid server
            })
        end,
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Example LSP setups
            lspconfig.lua_ls.setup({}) -- Lua LSP
            lspconfig.ts_ls.setup({}) -- Custom TypeScript/JavaScript LSP (if "ts_ls" is valid)
            lspconfig.clangd.setup({}) -- C/C++ LSP
            lspconfig.tailwindcss.setup({}) -- Tailwind CSS LSP
        end,
    },

    -- Mason-null-ls.nvim for integrating Mason with null-ls
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                automatic_setup = true, -- Automatically set up formatters and linters
            })
        end,
    },

    -- null-ls.nvim for integrating formatters and linters
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Formatters
                    null_ls.builtins.formatting.stylua, -- Lua
                    null_ls.builtins.formatting.prettierd, -- JavaScript/TypeScript/HTML/CSS
                    null_ls.builtins.formatting.clang_format, -- C/C++
                    null_ls.builtins.formatting.htmlbeautifier, -- HTML
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false }) -- Format on save
                            end,
                        })
                    end
                end,
            })
        end,
    },

    -- Completion Engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP completion
            "hrsh7th/cmp-buffer", -- Buffer completion
            "hrsh7th/cmp-path", -- Path completion
            "hrsh7th/cmp-cmdline", -- Command-line completion
            "saadparwaiz1/cmp_luasnip", -- Snippet completion
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Down>"] = cmp.mapping.select_next_item(), -- Arrow keys to navigate
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Tab to confirm
                    ["<C-Space>"] = cmp.mapping.complete(), -- Ctrl + Space to bring up suggestions
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Snippet Engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
}


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
        ensure_installed = { "lua_ls", "ts_ls" , "clangd", "tailwindcss"},
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup{}  -- Example LSP setup (change as needed)
    end
  },

  -- Completion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- LSP completion
      "hrsh7th/cmp-buffer",     -- Buffer completion
      "hrsh7th/cmp-path",       -- Path completion
      "hrsh7th/cmp-cmdline",    -- Command-line completion
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

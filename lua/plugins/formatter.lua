return {
  -- Mason.nvim for managing formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-null-ls.nvim for integrating Mason with null-ls
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true, -- Automatically set up formatters
      })
    end,
  },

  -- null-ls.nvim for integrating formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- JavaScript/TypeScript formatter
          null_ls.builtins.formatting.prettierd,
          -- HTML formatter
          null_ls.builtins.formatting.htmlbeautifier,
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
}

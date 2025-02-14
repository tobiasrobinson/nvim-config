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
        ensure_installed = { "lua_ls", "ts_ls" }, -- Ensure these LSP servers are installed
      })
    end,
  },

  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua LSP
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize `vim` as a global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Add runtime files to workspace
              checkThirdParty = false, -- Disable third-party checking
            },
            telemetry = {
              enable = false, -- Disable telemetry
            },
          },
        },
      })

      -- JavaScript and TypeScript LSP
      lspconfig.ts_ls.setup({})

     -- Keybindings and LSP handlers
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message"  })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic"  })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = "List workspace folders" })
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, { desc = "Format buffer" })
        end,
      })
    end,
  },
}

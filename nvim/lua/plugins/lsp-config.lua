return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "html",
          "eslint",
          "textlsp",
          "pylsp",
          "sqls",
          "rust_analyzer",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.html.setup({})
      lspconfig.java_language_server.setup({})
      lspconfig.eslint.setup({})
      lspconfig.textlsp.setup({})
      lspconfig.pylsp.setup({})
      lspconfig.rust_analyzer.setup({})

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}

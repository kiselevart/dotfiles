return {
--  {
--    "williamboman/mason.nvim",
--    config = function()
--      require("mason").setup()
--    end
--  },
--  {
--    "williamboman/mason-lspconfig.nvim",
--    config = function()
--      require("mason-lspconfig").setup({
--        ensure_installed = {
--          "lua_ls",
--          "clangd",
--          "html",
--          "eslint",
--          "textlsp",
--          "pylsp",
--          "sqls",
--          "rust_analyzer",
--        },
--      })
--    end
--  },
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
      lspconfig.kotlin_language_server.setup{
        filetypes = { "kotlin", "kt", "kts" },
        cmd = { vim.fn.expand("~") .. "/Users/kisel/Library/kotlin-language-server/server/build/libs/server-1.3.14.jar" },
      }

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}

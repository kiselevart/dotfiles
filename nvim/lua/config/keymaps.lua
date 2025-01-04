vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local config = require('nvim-treesitter.configs')
config.setup({
  ensure_installed = {"lua", "javascript", "c", "rust", "python"}, 
  highlight = { enable = true }, 
  indent = { enable = true },
})

vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>')
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>')

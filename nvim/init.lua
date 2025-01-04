vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect"

vim.api.nvim_set_option("clipboard", "unnamed")

require("config.lazy")
require("config.keymaps")

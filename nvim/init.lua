vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.clipboard = "unnamedplus"

require("config.lazy")
require("config.keymaps")

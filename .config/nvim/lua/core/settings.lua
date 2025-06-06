-- core/settings.lua

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.g.mapleader = ' '

vim.opt.cindent = true
vim.opt.cinoptions = {
    "g0",
}

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'

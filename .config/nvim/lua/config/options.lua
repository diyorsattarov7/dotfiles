-- lua/config/options.lua

local o, opt = vim.o, vim.opt

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4

o.termguicolors = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true

opt.cindent = true
opt.cinoptions = { "g0" }

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

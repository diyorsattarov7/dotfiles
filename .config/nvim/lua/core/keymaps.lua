-- core/keymaps.lua

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>x", "\"+y")
vim.keymap.set("v", "<leader>x", "\"+y")
vim.keymap.set("n", "<leader>d", "x")

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', ':NvimTreeFocus<CR>', { silent = true })

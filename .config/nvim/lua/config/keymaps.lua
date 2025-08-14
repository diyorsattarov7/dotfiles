-- lua/config/keymaps.lua

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })
map({ "n", "v" }, "<leader>x", '"+y', { desc = "Yank to Clipboard" })
map("n", "<leader>d", "x", { desc = "Delete char" })

-- map("n", "<leader>e", function()
--  vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
-- end, { desc = "Show Diagnostic" })

map("n", "<leader>fc", function()
	vim.cmd("set filetype=cpp")
	vim.notify("Filetype set to C++", vim.log.levels.INFO)
end, { desc = "Set Filetype to C++" })

-- map("n", "<leader>t", vim.cmd.terminal, { desc = "Open Terminal" })
-- map("t", "<C-q>", [[<C-\><C-n>:bd!<CR>]], { desc = "Force quit terminal" })

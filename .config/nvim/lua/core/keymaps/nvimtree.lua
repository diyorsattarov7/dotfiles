local M = {}

function M.setup()
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })
    vim.keymap.set("n", "<C-f>", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree", silent = true })
end

return M

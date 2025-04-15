-- core/keymaps.lua

local M = {}

M.setup_basic = function()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set("n", "<leader>x", "\"+y")
    vim.keymap.set("v", "<leader>x", "\"+y")
    vim.keymap.set("n", "<leader>d", "x")
end

M.setup_telescope = function()
    local ok, builtin = pcall(require, 'telescope.builtin')
    if not ok then
        return
    end
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

end

function M.setup()
    M.setup_basic()
    M.setup_telescope()
end
return M

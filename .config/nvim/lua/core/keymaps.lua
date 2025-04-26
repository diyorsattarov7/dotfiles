-- core/keymaps.lua

local M = {}

local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

M.setup_basic = function()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })
    vim.keymap.set({"n", "v"}, "<leader>x", "\"+y", { desc = "Yank to Clipboard" })
    vim.keymap.set("n", "<leader>d", "x", { desc = "Delete" })
    vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
    end, { desc = "Show Diagnostic" })
    vim.keymap.set("n", "<leader>fc", function()
        vim.cmd("set filetype=cpp")
        print("Filetype set to C++")
    end, { desc = "Set Filetype to C++" })
end

M.setup_nvimtree = function()
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })
    vim.keymap.set("n", "<C-f>", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree", silent = true })
end

M.setup_telescope = function()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
        return
    end
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "[P]ath [F]ind Files" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git [F]iles" })
    vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = "[P]ath [S]earch" })

    vim.keymap.set('n', '<leader>sf', function()
        local search_dir = vim.fn.input("Search directory: ", "~/", "dir")
        if search_dir == "" then return end
        builtin.find_files({
            prompt_title = "System Files",
            cwd = search_dir,
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = {
                "^/proc/", "^/sys/", "^/dev/", "^/run/", "^/tmp",
                "node_modules/", ".git/", ".zsh_sessions/", "%.zsh_history$", "%.zsh_sessions/"
            }
        })
    end, { desc = "[S]ystem [F]ind Files" })

    vim.keymap.set('n', '<leader>sg', function()
        local search_dir = vim.fn.input("Search directory: ", "~/", "dir")
        if search_dir == "" then return end
        builtin.live_grep({
            prompt_title = "System Grep",
            cwd = search_dir,
            additional_args = function()
                return {
                    "--hidden", "--no-ignore",
                    "--glob=!.zsh_sessions/", "--glob=!.zsh_history", "--glob=!.git/",
                    "--glob=!/proc/", "--glob=!/sys/", "--glob=!/dev/", "--glob=!/run/", "--glob=!/tmp/"
                }
            end
        })
    end, { desc = "[S]ystem [G]rep" })
end

function M.setup()
    M.setup_basic()
    M.setup_nvimtree()
    M.setup_telescope()
end

return M

-- core/keymaps.lua

local M = {}

M.setup_basic = function()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set("n", "<leader>x", "\"+y")
    vim.keymap.set("v", "<leader>x", "\"+y")
    vim.keymap.set("n", "<leader>d", "x")
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
    vim.keymap.set('n', '<C-f>', ':NvimTreeFocus<CR>', { silent = true })
end

M.setup_telescope = function()
    local ok, telescope = pcall(require, 'telescope')
    local ok, builtin = pcall(require, 'telescope.builtin')
    local ok, themes = pcall(require, 'telescope.themes')
    if not ok then
        return
    end
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    vim.keymap.set('n', '<leader>sf', function()
        local search_dir = vim.fn.input("Search directory: ", "~/", "dir")

        if search_dir == "" then return end

        builtin.find_files({
            prompt_title = "System Files",
            cwd = search_dir,
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = {
                "^/proc/",
                "^/sys/",
                "^/dev/",
                "^/run/",
                "^/tmp",
                "node_modules/",
                ".git/",
                ".zsh_sessions/",
                "%.zsh_history$",
                "%.zsh_sessions/"
            }
        })
    end)

    vim.keymap.set('n', '<leader>sg', function()
        local search_dir = vim.fn.input("Search directory: ", "~/", "dir")

        if search_dir == "" then return end

        builtin.live_grep({
            prompt_title = "System Grep",
            cwd = search_dir,
            additional_args = function()
                return {
                    "--hidden",
                    "--no-ignore",
                    "--glob=!.zsh_sessions/",
                    "--glob=!.zsh_history",
                    "--glob=!.git/",
                    "--glob=!/proc/",
                    "--glob=!/sys/",
                    "--glob=!/dev/",
                    "--glob=!/run/",
                    "--glob=!/tmp/"
                }
            end
        })
    end)

end

function M.setup()
    M.setup_basic()
    M.setup_telescope()
end
return M

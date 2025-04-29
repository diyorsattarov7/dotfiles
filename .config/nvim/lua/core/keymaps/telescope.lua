local M = {}

function M.setup()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then return end
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

return M

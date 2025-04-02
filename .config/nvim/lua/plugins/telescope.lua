local builtin = require('telescope.builtin')
local telescope = require('telescope')
local themes = require('telescope.themes')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>sf', function()
  local search_dir = vim.fn.input("Search directory: ", "/", "dir")
  
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
      "^/tmp/",
      "node_modules/",
      ".git/",
      ".zsh_sessions/",
      "%.zsh_history$",
      "%.zsh_sessions/"
    }
  })
end)

vim.keymap.set('n', '<leader>sg', function()
  local search_dir = vim.fn.input("Search directory: ", "/", "dir")
  
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

telescope.setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
  },
}

-- plugins/telescope.lua
local telescope = require("telescope")

---@type function
local setup = telescope.setup

setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    pickers = {
        find_files = {
            theme = "dropdown",
        },
        live_grep = {
            theme = "dropdown",
        },
    },
})

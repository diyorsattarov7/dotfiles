-- init.lua

require("bootstrap")
require("core.settings")

require("lazy").setup(require("plugins.init"), {
    defaults = {
        lazy = false,
    },
    change_detection = {
        notify = false,
    },
})

require("core.keymaps").setup()
require("core.theme")
require("core.autocommands")

require("plugins.nvim-tree")
require("plugins.lualine")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.luasnip")
require("plugins.vimtex")
require("plugins.markdown")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.lazygit").setup()

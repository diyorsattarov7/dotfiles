-- plugins/treesitter.lua

require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "python", "javascript", "typescript", "cpp", "c" },
  highlight = { enable = true },
})


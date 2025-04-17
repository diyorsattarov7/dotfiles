-- plugins/treesitter.lua

require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    "lua", "python", "javascript", "typescript", "cpp", "c", 
    "markdown", "markdown_inline",  
  },
  highlight = { enable = true },
})


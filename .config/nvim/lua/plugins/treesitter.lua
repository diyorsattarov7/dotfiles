-- plugins/treesitter.lua

require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    "lua", "python", "javascript", "typescript", "cpp", "c", 
    "markdown", "markdown_inline",  
    "objc", "cpp", "c",  
  },
  highlight = { enable = true },
})

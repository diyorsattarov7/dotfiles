-- plugins/treesitter.lua

require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    "lua", "python", "javascript", "typescript", "cpp", "c", 
    "markdown", "markdown_inline",  -- Markdown support
    "objc", "cpp", "c",  -- Objective-C support (Treesitter uses "objc" for Objective-C)
  },
  highlight = { enable = true },
})

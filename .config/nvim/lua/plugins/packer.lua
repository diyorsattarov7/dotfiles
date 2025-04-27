-- plugins/packer.lua
local packer = require('packer')
packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    
    use 'ellisonleao/gruvbox.nvim'
    use 'projekt0n/github-nvim-theme'
    
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-telescope/telescope.nvim'
    
    use 'nvim-treesitter/nvim-treesitter'
    
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason-lspconfig.nvim' 
    
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    use 'iamcco/markdown-preview.nvim'
    use 'lervag/vimtex'
    use 'numToStr/Comment.nvim'
    use 'lewis6991/gitsigns.nvim'
    if is_bootstrap then
        require('packer').sync()
    end
end)

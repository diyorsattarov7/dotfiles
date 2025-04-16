-- plugins/packer.lua
local packer = require('packer')
packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    if is_bootstrap then
        require('packer').sync()
    end

    use { "ellisonleao/gruvbox.nvim" }
    use { "projekt0n/github-nvim-theme" }
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        }
    }

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    }

    use { "williamboman/mason.nvim" }
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = { "neovim/nvim-lspconfig" }
    }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        }
    }

end)

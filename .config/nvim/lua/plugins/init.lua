-- plugins/init.lua

return {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",

    "ellisonleao/gruvbox.nvim",
    "projekt0n/github-nvim-theme",

    "nvim-tree/nvim-tree.lua",
    "nvim-lualine/lualine.nvim",
    "nvim-telescope/telescope.nvim",

    "nvim-treesitter/nvim-treesitter",

    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "mason-org/mason-lspconfig.nvim",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
    },

    "lervag/vimtex",
    "numToStr/Comment.nvim",

    "lewis6991/gitsigns.nvim",
    "kdheepak/lazygit.nvim",
    { import = "plugins.formatting" },
}

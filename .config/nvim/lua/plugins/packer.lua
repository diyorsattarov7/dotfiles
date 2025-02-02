-- plugins/packer.lua

local packer = require('packer')
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- LSP setup
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
  }

  -- Git integration
  use 'lewis6991/gitsigns.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Rust tools and debug support
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'
  use 'nvim-lua/plenary.nvim'

  use {
      'iamcco/markdown-preview.nvim',
      run = function() vim.fn['mkdp#util#install']() end,
      ft = { 'markdown' },
  }


  -- Sync packer if bootstrapping
  if is_bootstrap then
    require('packer').sync()
  end
end)


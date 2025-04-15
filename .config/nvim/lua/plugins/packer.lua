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
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
end)

-- init.lua
local bootstrap = require('bootstrap')
local is_bootstrap = bootstrap.ensure_packer()

require('core.settings')
require('core.keymaps').setup()
require('core.theme')

require('plugins.packer')
require('plugins.nvim-tree')
require('plugins.lualine')

require('plugins.lsp')

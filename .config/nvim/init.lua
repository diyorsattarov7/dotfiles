-- init.lua
local bootstrap = require('bootstrap')
local is_bootstrap = bootstrap.ensure_packer()

require('core.settings')
require('core.keymaps').setup()

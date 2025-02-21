-- init.lua

-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Source core settings and keymaps
require('core.theme')
require('core.settings')
require('core.keymaps')

-- Plugin setup
require('plugins.packer')

-- Configure the rest of the plugins
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.gitsigns')
require('plugins.telescope')
require('plugins.rust-tools')
require('plugins.markdown')

-- Sync packer if bootstrapping
if is_bootstrap then
  require('packer').sync()
end

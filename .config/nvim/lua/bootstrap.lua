-- bootstrap.lua
local M = {}

M.ensure_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/packer.nvim'
    local is_bootstrap = false

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        is_bootstrap = true
        vim.fn.system {
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path
        }
        vim.cmd [[packadd packer.nvim]]
        print "Installed packer.nvim, please restart Neovim and run :PackerSync"
    end

    return is_bootstrap
end

return M

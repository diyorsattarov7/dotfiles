-- plugins/packer.lua

local packer = require('packer')
packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }

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

    use 'lewis6991/gitsigns.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
    use 'nvim-lua/plenary.nvim'

    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' },
    }

    use({
        'projekt0n/github-nvim-theme',
        config = function()
            require('github-theme').setup({
                options = {
                    terminal_colors = true,
                    styles = {
                        comments = 'italic',
                        keywords = 'bold',
                        functions = 'bold',
                    },
                }
            })
        end
    })

    use({
        'mhartington/formatter.nvim',
        config = function()
            require('formatter').setup({
                filetype = {
                    cpp = {
                        function()
                            return {
                                exe = "clang-format",
                                args = { "--assume-filename=.cpp" }, 
                                stdin = true
                            }
                        end
                    },
                    hpp = {
                        function()
                            return {
                                exe = "clang-format",
                                args = { "--assume-filename=.hpp" }, 
                                stdin = true
                            }
                        end
                    }
                }
            })

            vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = "FormatAutogroup",
                pattern = { "*.cpp", "*.hpp" },
                command = "FormatWrite",
            })
        end
    })

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        }
    }

    use {
        'lervag/vimtex',
        ft = {'tex', 'latex'}
    }

    if is_bootstrap then
        require('packer').sync()
    end
end)


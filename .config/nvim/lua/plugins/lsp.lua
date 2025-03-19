-- plugins/lsp.lua
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspconfig = require('lspconfig')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.complete(),
        ['C-e'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-z>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.abort() 
            end
            vim.cmd.undo() 
        end, {'i', 's'}),  
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
    }
})

local handle = io.popen("brew --prefix")
local homebrew_prefix = handle:read("*a"):gsub("\n", "")
handle:close()

local function get_brew_include_dirs()
    local dirs = {}
    local handle = io.popen("ls " .. homebrew_prefix .. "/opt")
    for lib in handle:lines() do
        local include_dir = homebrew_prefix .. "/opt/" .. lib .. "/include"
        local lib_dir = homebrew_prefix .. "/opt/" .. lib .. "/lib"
        if vim.fn.isdirectory(include_dir) == 1 then
            table.insert(dirs, "-I" .. include_dir)
        end
        if vim.fn.isdirectory(lib_dir) == 1 then
            table.insert(dirs, "-L" .. lib_dir)
        end

    end
    handle:close()

    local sdk_path = vim.fn.system({"xcrun", "--show-sdk-path"})
    sdk_path = string.gsub(sdk_path, "%s+$", "") 

    if sdk_path ~= "" then
        table.insert(dirs, "-isysroot" .. sdk_path)
        table.insert(dirs, "-I" .. sdk_path .. "/usr/include")  
        table.insert(dirs, "-F" .. sdk_path .. "/System/Library/Frameworks") 
    end

    return dirs
end

lspconfig.clangd.setup({
    on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never"
    },
    filetypes = { "c", "cpp", "objc", "objcpp" }
})

lspconfig.pyright.setup({
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "strict",  
                diagnosticMode = "openFilesOnly",  
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
})

lspconfig.ts_ls.setup({
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
})

lspconfig.texlab.setup({
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
        })
        
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false
            },
            chktex = {
                onEdit = true,  
                onOpenAndSave = true  
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                executable = nil,
                args = {}
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    }
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'ts_ls' }
})


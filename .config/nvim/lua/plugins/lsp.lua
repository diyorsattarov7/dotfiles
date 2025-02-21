-- plugins/lsp.lua
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspconfig = require('lspconfig')

-- Setup nvim-cmp
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
                cmp.abort() -- Close the popup if it's still open
            end
            vim.cmd.undo() -- Perform a standard Vim undo
        end, {'i', 's'}),  -- Apply in insert and select modes
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
        -- Check if include and lib directories exist before adding
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

    -- Add macOS SDK paths (Crucial for Objective-C)
    local sdk_path = vim.fn.system({"xcrun", "--show-sdk-path"})
    sdk_path = string.gsub(sdk_path, "%s+$", "") -- Trim trailing whitespace

    if sdk_path ~= "" then
        table.insert(dirs, "-isysroot" .. sdk_path)
        table.insert(dirs, "-I" .. sdk_path .. "/usr/include")  -- Important for system headers
        table.insert(dirs, "-F" .. sdk_path .. "/System/Library/Frameworks") -- Add frameworks path
    end

    return dirs
end

-- LSP setup for clangd
lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- Buffer local mappings
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
    filetypes = { "c", "cpp", "objc", "objcpp", "m", "mm", "h", "hpp", "cxx" },
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--fallback-style=google",
        "--query-driver=/usr/bin/xcrun clang", -- Or your preferred compiler (e.g., /usr/bin/xcrun clang)
        "-j=4",
        "--header-insertion-decorators=0"
    },
    init_options = {
        compilationDatabasePath = "build", -- Or wherever your compile_commands.json is
        fallbackFlags = get_brew_include_dirs()
    }
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
                typeCheckingMode = "strict",  -- Ensures syntax and type checking
                diagnosticMode = "openFilesOnly",  -- Only check open files
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            }
        }
    }
})

-- LSP setup for JavaScript/TypeScript (ts_ls)
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

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'ts_ls' }
})


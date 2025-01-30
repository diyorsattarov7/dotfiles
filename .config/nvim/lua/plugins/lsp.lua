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
    ['<C-Space>'] = cmp.mapping.complete(),
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
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--fallback-style=google",
    "--query-driver=/usr/bin/gcc",
    "-j=4",
    "--header-insertion-decorators=0"
  },
  init_options = {
    compilationDatabasePath = "build",
    fallbackFlags = {
        "-I/opt/homebrew/opt/nlohmann-json/include",
        "-I/usr/local/opt/nlohmann-json/include",
        "-I/opt/homebrew/opt/spdlog/include",
        "-I/opt/homebrew/opt/fmt/include",
        "-I/usr/local/opt/spdlog/include",
        "-I/usr/local/opt/boost/include",
        "-I/usr/local/include",
        "-I/usr/include",
        "-L/usr/local/opt/boost/lib"
    }
  }
})

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'clangd', 'rust_analyzer' }
})

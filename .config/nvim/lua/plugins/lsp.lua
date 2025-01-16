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
    -- LSP-related keymaps or additional config here
  end,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    clangd = {
      extraArgs = { "--clang-tidy", "--fallback-style=Google" },
    }
  }
})

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'clangd', 'rust_analyzer' }
})


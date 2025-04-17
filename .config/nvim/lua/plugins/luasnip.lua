-- plugins/luasnip.lua 
local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end
luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})
vim.keymap.set({"i", "s"}, "<C-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({"i", "s"}, "<C-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end, { silent = true })
luasnip.add_snippets("tex", {
    luasnip.snippet("sec", {
        luasnip.text_node("\\section{"),
        luasnip.insert_node(1, "Section Name"),
        luasnip.text_node("}")
    }),
    luasnip.snippet("eq", {
        luasnip.text_node({"\\begin{equation}", "\t"}),
        luasnip.insert_node(1, "a = b"),
        luasnip.text_node({"", "\\end{equation}"})
    }),
    -- Added documentclass snippet
    luasnip.snippet("docclass", {
        luasnip.text_node("\\documentclass["),
        luasnip.insert_node(1, "options"),
        luasnip.text_node("]{"),
        luasnip.insert_node(2, "article"),
        luasnip.text_node("}")
    }),
})
local cmp_status_ok, cmp = pcall(require, "cmp")
if cmp_status_ok then
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' }
        })
    })
end

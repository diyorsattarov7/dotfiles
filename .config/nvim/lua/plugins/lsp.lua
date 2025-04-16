-- plugins/lsp.lua
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd" },
}

lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd", },
    filetypes = {"c", "cpp" },
    on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "●", 
        spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

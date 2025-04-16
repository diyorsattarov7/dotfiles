require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd" },
}

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
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

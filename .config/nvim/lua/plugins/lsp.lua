require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd" },
}

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
    cmd = {
        "clangd",
    },
    filetypes = {"c", "cpp" }
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

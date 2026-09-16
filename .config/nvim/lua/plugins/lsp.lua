-- plugins/lsp.lua
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "ts_ls", "cssls", "somesass_ls", "lua_ls" },
}

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config.lua_ls = {
    filetypes = { "lua" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}

vim.lsp.config.cssls = {
    filetypes = { "css", "scss", "less" },
    settings = {
        scss = { validate = true },
        css = { validate = true },
    },
}

vim.lsp.config.somesass_ls = {
    filetypes = { "sass", "scss", "less", "css" },
    settigns = {
        somesass = {
            includePaths = {},
            suggestFromUseOnly = false,
        },
    },
}

vim.lsp.config.ts_ls = {
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
}

vim.lsp.config.clangd = {
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
}

vim.lsp.config.sourcekit = {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    filetypes = { "swift", "m", "mm" },
}

vim.lsp.enable({ "ts_ls", "clangd", "sourcekit", "cssls", "somesass_ls", "lua_ls" })

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

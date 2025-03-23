-- plugins/cpp.lua

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "hpp", "c", "h" },
    callback = function()
        vim.bo.smartindent = false
        vim.bo.autoindent = false
        vim.opt.cindent = false
    end
})

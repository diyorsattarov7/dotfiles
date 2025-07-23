-- plugins/autocommands.lua

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, "\"")
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    callback = function()
        local filename = vim.fn.expand("%:t")

        if vim.fn.expand("%:e") == "" and filename ~= "" then
            local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false)
            local content = table.concat(lines, "\n"):lower()


            local cpp_patterns = {
                "#ifndef%s",
                "#define%s",
                "#pragma%s+once",

                "#include%s*<[%w_]+>",
                "#include%s*\"[^\"]+\"",

                "namespace%s+[%w_]+",
                "template%s*<",
                "class%s[w_]+",

                "::",
                "operator[%w_]*%s*%(",
            }

            for _, pattern in ipairs(cpp_patterns) do
                if content:match(pattern) then
                    vim.bo.filetype = "cpp"
                    print("Detected C++ filetype: " .. filename)
                    return
                end
            end

        end
    end,
})

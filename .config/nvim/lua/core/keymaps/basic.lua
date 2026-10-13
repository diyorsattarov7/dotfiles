local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })
    vim.keymap.set({"n", "v"}, "<leader>x", "\"+y", { desc = "Yank to Clipboard" })
    vim.keymap.set("n", "<leader>d", "x", { desc = "Delete" })
    vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
    end, { desc = "Show Diagnostic" })
    vim.keymap.set("n", "<leader>fc", function()
        vim.cmd("set filetype=cpp")
        print("Filetype set to C++")
    end, { desc = "Set Filetype to C++"
    })
    vim.keymap.set("n", "<leader>t", function()
        local dir = vim.fn.expand("%:p:h")
        vim.cmd("lcd " .. vim.fn.fnameescape(dir))
        vim.cmd("terminal")
    end, {
        desc = "Open Terminal"
    })
    vim.keymap.set("t", "<C-q>", [[<C-\><C-n>:bd!<CR>]], { desc = "Force quit terminal" })
    vim.keymap.set("v", '<leader>"', 'c""<Esc>P', {
        desc = "Wrap selection in quotes"
    })

end

return M


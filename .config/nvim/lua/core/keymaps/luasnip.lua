local M = {}

function M.setup()
    local present, ls = pcall(require, "luasnip")
    if not present then return end

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then ls.expand_or_jump() end
    end, { silent = true, desc = "LuaSnip Expand or Jump Forward" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then ls.jump(-1) end
    end, { silent = true, desc = "LuaSnip Jump Backward" })

    vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then ls.change_choice(1) end
    end, { silent = true, desc = "LuaSnip Next Choice" })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then ls.change_choice(-1) end
    end, { silent = true, desc = "LuaSnip Previous Choice" })
end

return M

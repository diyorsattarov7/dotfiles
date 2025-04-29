-- core/keymaps.lua

local M = {}

function M.setup()
    require("core.keymaps.basic").setup()
    require("core.keymaps.nvimtree").setup()
    require("core.keymaps.telescope").setup()
    require("core.keymaps.luasnip").setup()
end

return M

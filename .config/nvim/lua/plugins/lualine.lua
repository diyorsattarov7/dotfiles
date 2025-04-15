-- plugins/lualine.lua

local function lsp_status()
  local clients = vim.lsp.get_clients()
  local names = {}
  for _, client in ipairs(clients) do
    if client.name ~= "null-ls" then
      table.insert(names, client.name)
    end
  end
  return table.concat(names, ", ")
end

require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { lsp_status, "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = { "nvim-tree", "fugitive" },
}

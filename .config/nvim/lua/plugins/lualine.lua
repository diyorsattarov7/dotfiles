-- plugins/lualine.lua

local function lsp_status()
  if #vim.lsp.get_clients() > 0 then
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    local lsp_names = {}
    for _, client in ipairs(clients) do
      if client.name ~= "null-ls" then
        table.insert(lsp_names, client.name)
      end
    end
    return "  " .. table.concat(lsp_names, ", ")
  end
  return ""
end

local function git_blame()
  local blame = vim.b.gitsigns_blame_line
  if blame then
    local text = blame:gsub(".*author ", ""):gsub(" <%w+@.->", "")
    if text ~= "Not Committed Yet" then
      return "  " .. text
    end
  end
  return ""
end

local function file_info()
  local icon = ""
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  
  local file_icon, file_icon_color = require('nvim-web-devicons').get_icon_color(
    filename, extension, { default = true }
  )
  
  if file_icon then
    icon = file_icon .. " "
  end
  
  return icon .. filename .. " "
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local filename = {
  "filename",
  file_status = true,
  path = 1, -- relative path
  shorting_target = 40,
  symbols = {
    modified = " ●",
    readonly = " ",
    unnamed = "[No Name]",
    newfile = "[New]",
  }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto', -- auto-detects from your colorscheme
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = { "NvimTree", "dashboard", "Outline" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { "branch", icon = "" },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        colored = true,
      },
      diagnostics,
    },
    lualine_c = {
      filename,
      { file_info },
    },
    lualine_x = {
      { lsp_status },
      { "filetype", colored = true, icon_only = false, icon = { align = 'right' } },
      { "fileformat", symbols = { unix = " ", dos = " ", mac = " " } },
      { "encoding" },
    },
    lualine_y = {
      { "progress", separator = { right = '' }, left_padding = 2 },
    },
    lualine_z = {
      { "location", separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "nvim-tree", "fugitive" }
}

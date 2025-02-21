local function set_github_theme()
  local dark_mode = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null") ~= ""
  local theme = dark_mode and "github_dark_colorblind" or "github_light_colorblind"
  vim.cmd("colorscheme " .. theme)
end

set_github_theme()

vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
  callback = set_github_theme,
})


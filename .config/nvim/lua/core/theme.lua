local function is_in_tmux()
  return vim.env.TMUX ~= nil
end

local function set_github_theme() 
  if is_in_tmux() then
    local dark_mode = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null") ~= ""
    local theme = dark_mode and "github_dark_colorblind" or "github_light_colorblind"
    vim.opt.termguicolors = true
    require('github-theme').setup({
      options = {
        terminal_colors = true,
        styles = {
          comments = 'italic',
          keywords = 'bold',
          functions = 'bold',
        },
      }
    })
    vim.cmd("colorscheme " .. theme)
  else 
    vim.cmd("colorscheme default") 
  end
end

set_github_theme()

vim.api.nvim_create_autocmd({ "FocusGained" }, {
  callback = set_github_theme,
})

-- core/theme.lua
local selected_theme = "github"

local function is_in_tmux()
    return vim.env.TMUX ~= nil
end

local function set_theme()
    if not is_in_tmux() then
        vim.cmd("colorscheme default")
        return
    end

    local dark_mode = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null") ~= ""

    if selected_theme == "github" then
        local theme = dark_mode and "github_dark_colorblind" or "github_light_colorblind"
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

set_theme()

vim.api.nvim_create_autocmd({ "FocusGained" }, { callback = set_theme })

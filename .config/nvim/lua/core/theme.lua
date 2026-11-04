-- core/theme.lua
local selected_theme = "github"
local dark_background = "#0D1116"

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

		require("github-theme").setup({
			options = {
				terminal_colors = true,
				styles = {
					comments = "italic",
					keywords = "bold",
					functions = "bold",
				},
			},
			palettes = {
				github_dark_colorblind = {
					bg0 = dark_background,
					bg1 = dark_background,
				},
			},
			groups = {
				github_dark_colorblind = {
					Normal = { bg = dark_background },
					NormalNC = { bg = dark_background },
				},
			},
		})

		vim.cmd("colorscheme " .. theme)
	else
		vim.cmd("colorscheme default")
	end
end

set_theme()

vim.api.nvim_create_autocmd("FocusGained", {
	callback = set_theme,
})

local M = {}

local function is_dark_mode()
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	if not handle then
		return false
	end
	local result = handle:read("*a")
	handle:close()
	return result:match("Dark") ~= nil
end

function M.set_theme()
	local github = require("github-theme")
	github.setup({
		options = {
			terminal_colors = true,
			styles = {
				comments = "italic",
				keywords = "bold",
				functions = "bold",
			},
		},
	})

	if is_dark_mode() then
		vim.cmd.colorscheme("github_dark_colorblind")
	else
		vim.cmd.colorscheme("github_light_colorblind")
	end
end

function M.auto_switch()
	M.set_theme()

	local last_state = is_dark_mode()
	vim.fn.timer_start(1000, function()
		local current_state = is_dark_mode()
		if current_state ~= last_state then
			last_state = current_state
			vim.schedule(function()
				M.set_theme()
				vim.notify("Theme switched to " .. (current_state and "Dark" or "Light"), vim.log.levels.INFO)
			end)
		end
	end, { ["repeat"] = -1 })
end

return M

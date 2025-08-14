-- lua/plugins/files.lua

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle left<cr>", desc = "Toggle File Explorer", mode = "n", silent = true },
			{ "<C-f>", "<cmd>Neotree focus left<cr>", desc = "Focus File Explorer", mode = "n", silent = true },
		},
		opts = {
			window = {
				width = 32,
				mappings = {
					["<Tab>"] = function()
						vim.cmd("wincmd p")
					end,
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_default",
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			sources = { "filesystem", "buffers", "git_status" },
		},
	},
}

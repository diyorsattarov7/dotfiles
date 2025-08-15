return {
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			opts.defaults = opts.defaults or {}
			opts.defaults.vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/*",
			}
			return opts
		end,
	},
}

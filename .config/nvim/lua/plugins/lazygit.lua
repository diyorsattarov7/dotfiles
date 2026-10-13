-- plugins/lazygit.lua
return {
  "kdheepak/lazygit.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  setup = function()
    vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { noremap = true, silent = true })
  end,
}

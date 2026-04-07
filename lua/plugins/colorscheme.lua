return {
  "folke/tokyonight.nvim",
  version = "v4.14.1",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("tokyonight-night")
    vim.cmd.hi("Comment gui=none")
  end,
}

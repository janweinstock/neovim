return {
  "lewis6991/gitsigns.nvim",
  version = "v2.1.0",

  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })
    vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {})
  end,
}

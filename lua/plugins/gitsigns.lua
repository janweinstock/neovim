return {
  'lewis6991/gitsigns.nvim',

  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    })
    vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {})
  end,
}

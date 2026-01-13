return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set('n', '<leader>gs', ':Git status<CR>', {})
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', {})
    vim.keymap.set('n', '<leader>gt', ':Git log --graph --oneline --all<CR>', {})
    vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', {})
  end
}

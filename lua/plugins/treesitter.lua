return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    local config = require('nvim-treesitter.config')
    config.setup({
      ensure_installed = { 'bash', 'c', 'cpp', 'rust', 'html', 'lua', 'markdown', 'javascript' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

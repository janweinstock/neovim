if vim.fn.has("nvim-0.11") == 0 then
  error("Neovim 0.11 or higher is required")
end

require('config.options')
require('config.lazy')
require('config.lsp')
require('config.keymaps')

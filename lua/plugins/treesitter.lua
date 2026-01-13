return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.config")
    config.setup({
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "html",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

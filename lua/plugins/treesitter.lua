return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.3",
  build = ":TSUpdate",
  lazy = false,

  opts = {
    ensure_installed = { "bash",
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
      "vim",
      "vimdoc",
      "yaml",
    },

    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,

  config = function()
    -- Install parsers (async, no-op if already installed)
    require("nvim-treesitter").install({
      "bash",
      "c",
      "cmake",
      "cpp",
      "html",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local ok = pcall(vim.treesitter.start)
        if ok then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

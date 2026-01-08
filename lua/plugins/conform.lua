return {
  'stevearc/conform.nvim',

  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disabled_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disabled_filetypes[vim.bo[bufnr].filetype],
      }
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { { 'prettierd', 'prettier' } },
    },

    formatters = {
      stylua = {
        command = 'stylua',
        args = { '--indent-type', 'Spaces', '-' },
      },
    },

    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({
            async = true,
            lsp_fallback = true,
          })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
  },
}

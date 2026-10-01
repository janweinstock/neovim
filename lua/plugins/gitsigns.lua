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

    -- jump between hunks, keeping native ]c/[c behaviour in diff mode
    local gitsigns = require("gitsigns")
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next git hunk" })
    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Previous git hunk" })
    vim.keymap.set("n", "<leader>gn", function() gitsigns.nav_hunk("next") end, { desc = "[G]it [N]ext hunk" })
    vim.keymap.set("n", "<leader>gp", function() gitsigns.nav_hunk("prev") end, { desc = "[G]it [P]revious hunk" })
  end,
}

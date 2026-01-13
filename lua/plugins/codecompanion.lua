return {
    "olimorris/codecompanion.nvim",

    dependencies = {
        { "j-hui/fidget.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
    },

    config = function()
        -- local mod = "gemini-2.5-pro"
        local model = "gemini-2.5-flash"
        require("codecompanion").setup({
            interactions = {
                chat = { adapter = "gemini", model = model },
                inline = { adapter = "gemini", model = model },
            },
            opts = {
                log_level = "DEBUG",
            },
        })
    end
}

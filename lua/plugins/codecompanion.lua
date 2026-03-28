return {
    "olimorris/codecompanion.nvim",

    dependencies = {
        { "j-hui/fidget.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
        { "nvim-telescope/telescope.nvim" },
    },

    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = { adapter = "gemini" },
                inline = { adapter = "gemini" },
                agent = {
                    adapter = "gemini",
                    tools = { "cmd_runner", "editor", "rg" },
                },
            },
            display = {
                action_palette = {
                    width = 95,
                    height = 10,
                    prompt = "Prompt ",
                    provider = "telescope",
                    opts = {
                        show_default_actions = true,
                        show_default_prompt_library = true,
                    },
                },
                chat = {
                    window = {
                        layout = "float",
                    },
                },
            },
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        schema = {
                            model = {
                                default = "gemini-2.5-flash",
                            },
                        },
                    })
                end,
            },
            opts = {
                log_level = "DEBUG",
            },
        })
    end
}

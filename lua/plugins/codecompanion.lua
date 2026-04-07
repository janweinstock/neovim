return {
    "olimorris/codecompanion.nvim",
    version = "v19.9.0",

    dependencies = {
        { "j-hui/fidget.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
        { "nvim-telescope/telescope.nvim" },
        {
            "github/copilot.vim",
            config = function()
                -- Disable all Copilot functionality, keep only for auth
                vim.g.copilot_enabled = 0
                vim.g.copilot_no_tab_map = true
                vim.g.copilot_assume_mapped = true
                vim.g.copilot_filetypes = { ["*"] = false }
            end,
        },
    },

    config = function()
        local default_adapter = "copilot"
        require("codecompanion").setup({
            interactions = {
                chat = { adapter = default_adapter },
                inline = { adapter = default_adapter },
                agent = {
                    adapter = default_adapter,
                    tools = { "cmd_runner", "editor", "rg" },
                },
            },
            adapters = {
                http = {
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = { default = "claude-sonnet-4.6", }, },
                        })
                    end,
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

            opts = {
                log_level = "DEBUG",
            },
        })
    end
}

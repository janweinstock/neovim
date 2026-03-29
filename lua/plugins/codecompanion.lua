return {
    "olimorris/codecompanion.nvim",

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
        local default_adapter = "gemini"
        local default_model = "gemini-2.5-flash"
        require("codecompanion").setup({
            interactions = {
                chat = { adapter = default_adapter, model = default_model },
                inline = { adapter = default_adapter, model = default_model },
                agent = {
                    adapter = default_adapter,
                    model = default_model,
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
                http = {
                    gemini = function()
                        return require("codecompanion.adapters").extend("gemini", {
                            schema = {
                                model = {
                                    default = "gemini-2.5-flash",
                                },
                            },
                        })
                    end,
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = {
                                    default = "gpt-5.3",
                                },
                            },
                        })
                    end,
                },
            },
            opts = {
                log_level = "DEBUG",
            },
        })
    end
}

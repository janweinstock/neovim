vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
vim.keymap.set("n", "<C-left>", "<C-w><C-h>", { desc = "Move focus to the left window", silent = true })
vim.keymap.set("n", "<C-right>", "<C-w><C-l>", { desc = "Move focus to the right window", silent = true })
vim.keymap.set("n", "<C-down>", "<C-w><C-j>", { desc = "Move focus to the lower window", silent = true })
vim.keymap.set("n", "<C-up>", "<C-w><C-k>", { desc = "Move focus to the upper window", silent = true })
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left toggle<CR>', { desc = "Toggle filesystem view", silent = true })

vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>",
    { desc = "CodeCompanion Actions", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Prompt", silent = true })
vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion Chat Toggle", silent = true })
vim.cmd("cnoreabbrev ai CodeCompanion")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("group-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("group-lsp-attach", { clear = true }),
    callback = function(event)
        local mkkey = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        mkkey("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        mkkey("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        mkkey("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        mkkey("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        mkkey("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        mkkey("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        mkkey("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        mkkey("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        mkkey("<leader>f", vim.lsp.buf.format, "[F]ormat")

        mkkey("H", vim.lsp.buf.hover, "Hover Documentation")
        mkkey("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("group-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("group-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "group-lsp-highlight", buffer = event2.buf }
                end,
            })
        end
    end,
})


local cc_fidgets = {}
local cc_group = vim.api.nvim_create_augroup("CodeCompanionFidget", {})

vim.api.nvim_create_autocmd("User", {
    desc = "Starts a fidget when an AI request is started",
    pattern = "CodeCompanionRequestStarted",
    group = cc_group,
    callback = function(event)
        cc_fidgets[event.data.id] = require("fidget.progress").handle.create({
            title = "CodeCompanion",
            message = "Thinking...",
            lsp_client = { name = event.data.adapter.formatted_name },
        })
    end,
})

vim.api.nvim_create_autocmd("User", {
    desc = "Ends a fidget when an AI request finishes",
    pattern = "CodeCompanionRequestFinished",
    group = cc_group,
    callback = function(event)
        local fidget = cc_fidgets[event.data.id]
        if fidget then
            fidget.message = event.data.status == "success" and "Done" or "Failed"
            fidget:finish()
            cc_fidgets[event.data.id] = nil
        end
    end,
})

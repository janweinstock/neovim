vim.lsp.enable({
    "lua_ls",
    "clangd",
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "■",
        spacing = 0,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

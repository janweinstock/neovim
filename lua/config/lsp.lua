vim.lsp.enable({
    "lua_ls",
    "clangd",
    "neocmake",
})

vim.diagnostic.config({
    virtual_lines = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- rotate lsp log when it exceeds 50MB, keeping one previous copy
local lsp_log = vim.lsp.log.get_filename()
local lsp_log_stat = vim.uv.fs_stat(lsp_log)
if lsp_log_stat and lsp_log_stat.size > 50 * 1024 * 1024 then
    os.rename(lsp_log, lsp_log .. ".old")
end

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

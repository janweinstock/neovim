-- Downloaded from: https://github.com/LuaLS/lua-language-server/releases
return {
    cmd = { "lua-language-server", },
    filetypes = { "lua" },
    root_markers = {
        ".git",
        ".luacheckrc",
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "selene.toml",
        "selene.yml",
        "stylua.toml",
    },

    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,

    format = {
        defaultConfig = {
            indent_style = "space",
            indent_size = "4",
            quote_style = "double",
        },
    },
}

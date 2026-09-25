-- Install using: dnf install clang-tools-extra
return {
  cmd = { "clangd", "--background-index", "--header-insertion=never" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
}

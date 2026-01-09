-- install using: cargo install neocmakelsp
return {
  cmd = { 'neocmakelsp', 'stdio' },
  filetypes = { 'cmake' },
  root_markers = { '.git', 'build', 'cmake', 'BUILD', },
}

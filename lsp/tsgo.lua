-- install using: npm install -g typescript (7+, which ships a native language server)
return {
  cmd = { "tsc", "--lsp", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}

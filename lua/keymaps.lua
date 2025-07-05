local M = {}

M.on_attach = function(_, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n','gd', vim.lsp.buf.definition,     bufopts)
  vim.keymap.set('n','gD', vim.lsp.buf.declaration,    bufopts)
  vim.keymap.set('n','gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n','gr', vim.lsp.buf.references,     bufopts)
end

return M

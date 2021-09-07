Q.get_highlight = function()
  -- TODO: this doesn't seem to work with tree-sitter highlighting

  local id = vim.fn.synID(vim.fn.line '.', vim.fn.col '.', 1)
  local highlight = (
      vim.fn.synIDattr(id, 'name')
      .. ' -> '
      .. vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name')
    )
  Q.dump(highlight)
  return highlight
end

Q.m('<Leader>,', [[<Cmd>call fixity#dev()<CR>]])
Q.m('<Leader>m', '<Cmd>messages<CR>')
Q.m('<Leader>/', '<Cmd>lua Q.get_highlight()<CR>')

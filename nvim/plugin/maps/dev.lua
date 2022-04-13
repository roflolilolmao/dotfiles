Q.get_highlight = function()
  -- TODO: this doesn't seem to work with tree-sitter highlighting

  for i, id in pairs(vim.fn.synstack(vim.fn.line '.', vim.fn.col '.')) do
    local highlight = (
      vim.fn.synIDattr(id, 'name')
      .. ' -> '
      .. vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name')
    )
    Q.dump(i, highlight)
  end
end

Q.m('<Leader>.', [[<Cmd>call fixity#d()<CR>]])
Q.m('<Leader>,', [[<Cmd>call fixity#dev()<CR>]])
Q.m('<Leader>m', '<Cmd>messages<CR>')
Q.m('<Leader>?', '<Cmd>lua Q.get_highlight()<CR>')

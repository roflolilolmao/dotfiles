Q.diff_mode = function()
  -- TODO: needs more work

  if vim.wo.diff then
    Q.m('n', ']czz')
    Q.m('N', '[czz')
    Q.m('o', 'do')
    Q.m('O', '<Cmd>.diffget<CR>')
    Q.m('p', 'dp')
    Q.m('P', '<Cmd>.diffput<CR>')
  end
end

Q.m('<leader><leader>d', '<Cmd>lua Q.diff_mode()<CR>')

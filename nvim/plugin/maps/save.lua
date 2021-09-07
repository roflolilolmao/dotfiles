Q.save_if_file_exists = function()
  local filename = vim.api.nvim_buf_get_name(0)

  if filename ~= nil and filename ~= '' then
    vim.cmd 'update'
  end
end

Q.save_all = function()
  local view = vim.fn.winsaveview()
  vim.cmd 'mark Z'
  vim.cmd 'bufdo lua Q.save_if_file_exists()'
  vim.cmd 'silent! normal! `Z'
  vim.fn.winrestview(view)
end

Q.m('<F5>', '<Cmd>lua Q.save_all()<CR>', 'ni')

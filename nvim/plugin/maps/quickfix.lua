Q.cn = function(direction)
  local index = vim.fn.getqflist({ idx = 0 }).idx
  if index == 0 then
    return
  end

  local filtered = vim.fn.filter(vim.fn.getqflist(), function(i)
    return i ~= index - 1
  end)

  local title = vim.fn.getqflist({ title = 0 }).title
  vim.fn.setqflist({}, ' ', { title = title, items = filtered })

  if not next(filtered) then
    vim.cmd 'cclose'
    return
  end

  vim.cmd(index + direction .. 'cc')
end

Q.m('<Leader>n', [[<Cmd>lua Q.cn(0)<CR>]])
Q.m('<Leader>N', [[<Cmd>lua Q.cn(-1)<CR>]])

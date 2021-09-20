Q.qf = {
  cn = function(direction)
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
  end,

  open_or_clean = function()
    local win = vim.fn.getqflist({ winid = 0 }).winid
    if win > 0 then
      vim.cmd 'cexpr []'
    end

    vim.cmd 'cwindow'
    vim.cmd 'wincmd p'
  end,

  add_current_line = function()
    vim.cmd 'caddexpr expand("%") . ":" . line(".") . ":" . getline(".")'

    local win = vim.fn.getqflist({ winid = 0 }).winid
    if win > 0 then
        return
    end

    vim.cmd 'cwindow'
    vim.cmd 'wincmd p'
  end
}

Q.m("<Leader>'", '<Cmd>lua Q.qf.open_or_clean()<CR>')

Q.m('<Leader>n', [[<Cmd>lua Q.qf.cn(0)<CR>]])
Q.m('<Leader>N', [[<Cmd>lua Q.qf.cn(-1)<CR>]])

Q.m(
  '<C-CR>',
  '<Cmd>lua Q.qf.add_current_line()<CR>'
)

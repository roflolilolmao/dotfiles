Q.term = function()
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  local win = vim.api.nvim_open_win(0, true, {
    relative = 'win',
    width = width - 8,
    height = height - 4,
    row = 1,
    col = 3,
    border = 'rounded',
    style = 'minimal',
  })

  -- For some reason, setting the Normal highlight to itself will fix the
  -- background (this might be because my background is set to nil)
  vim.api.nvim_win_set_option(
    win,
    'winhighlight',
    'Normal:Normal,FloatBorder:Title'
  )

  vim.cmd 'terminal'
  vim.cmd 'startinsert'

  vim.api.nvim_buf_set_keymap(0, 't', 'Q', '<Cmd>bd!<CR>', {noremap = true})
  vim.api.nvim_buf_set_name(0, 'Q terminal')
  vim.cmd(string.format([[
    augroup Q_term
      autocmd!
      autocmd TermClose <buffer> bwipeout!
    augroup END
    ]]
  ))

end

Q.scratch = function()
  local buf = vim.api.nvim_create_buf(true, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'win',
    width = 80,
    height = 24,
    row = 1,
    col = 3,
    border = 'rounded',
    style = 'minimal',
  })

  vim.api.nvim_buf_set_name(buf, 'Q scratch')

  -- For some reason, setting the Normal highlight to itself will fix the
  -- background (this might be because my background is set to nil)
  vim.api.nvim_win_set_option(
    win,
    'winhighlight',
    'Normal:Normal,FloatBorder:Title'
  )
end

Q.m('<F1>', '<Cmd>lua Q.term()<CR>')
Q.m('<F3>', '<Cmd>lua Q.scratch()<CR>')

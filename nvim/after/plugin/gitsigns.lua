require'gitsigns'.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    changedelete = { text = '!' },
  },
  word_diff = true,
  keymaps = {
    ['n <Leader>hn'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n <Leader>hp'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
  },
}

vim.cmd('highlight GitSignsAdd guifg=green guibg=NONE')
vim.cmd('highlight GitSignsChange guifg=#8888ff guibg=NONE')
vim.cmd('highlight GitSignsDelete guifg=red guibg=NONE')

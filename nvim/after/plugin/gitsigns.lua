require'gitsigns'.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
    changedelete = { text = '!' },
  },
  word_diff = true,
}

vim.cmd('highlight GitSignsAdd guifg=green guibg=NONE')
vim.cmd('highlight GitSignsChange guifg=#8888ff guibg=NONE')
vim.cmd('highlight GitSignsDelete guifg=red guibg=NONE')

vim.cmd 'runtime autoload/repeat.vim'

vim.cmd 'runtime macros/sandwich/keymap/surround.vim'

vim.fn['operator#sandwich#set']('all', 'all', 'cursor', 'keep')
Q.m('.', '<Plug>(operator-sandwich-predot)<Plug>(RepeatDot)', 'n', {})

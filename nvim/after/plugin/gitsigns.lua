require('gitsigns').setup {
  signs = {
    add = { hl = 'DiffAdd', text = '+' },
    change = { hl = 'DiffChange', text = '~' },
    delete = { hl = 'DiffDelete', text = '-' },
    topdelete = { hl = 'DiffDelete' },
    changedelete = { hl = 'DiffDelete', text = '!' },
  },
  keymaps = {
    noremap = true,

    ['n <Leader>hn'] = {
      expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
    },
    ['n <Leader>hp'] = {
      expr = true,
      "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
    },

    ['n <leader>hs'] = '<Cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<Cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<Cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<Cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<Cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hh'] = '<Cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<Cmd>lua require"gitsigns".blame_line(true)<CR>',

    ['o ih'] = ':<C-u>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-u>lua require"gitsigns.actions".select_hunk()<CR>',
  },
}

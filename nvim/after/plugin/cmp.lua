local cmp = require'cmp'

cmp.setup{
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll(-4),
    ['<C-f>'] = cmp.mapping.scroll(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm{
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },

  sources = {
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    --{ name = 'buffer' },
    --{ name = 'treesitter' }
  };
}

require('cmp_nvim_lsp').setup{}
require'cmp_luasnip'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local luasnip = require'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return t [[<Cmd>lua require'cmp'.mapping.complete()<CR>]]
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

local opts = {expr = true}

Q.mm('i', '<Tab>', 'v:lua.tab_complete()', opts)
Q.mm('s', '<Tab>', 'v:lua.tab_complete()', opts)
Q.mm('i', '<S-Tab>', 'v:lua.s_tab_complete()', opts)
Q.mm('s', '<S-Tab>', 'v:lua.s_tab_complete()', opts)
Q.mm('i', '<C-Tab>', '<Plug>luasnip-expand-or-jump', {})

Q.mm(
  'i',
  '<C-e>',
  [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
  opts
)

Q.mm(
  's',
  '<C-e>',
  [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
  opts
)

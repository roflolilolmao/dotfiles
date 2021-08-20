local cmp = require'cmp'
local luasnip = require'luasnip'

local function escape(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup{
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },

  formatting = {
    format = function(entry, item)
      item.kind = string.format('%s [%s]', item.kind, entry.source.name)
      return item
    end
  },

  mapping = {
    ['<Tab>'] = cmp.mapping.mode({'i', 's'}, function (_, fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(escape'<C-n>', 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(escape'<Plug>luasnip-expand-or-jump', 'n')
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping.mode({'i', 's'}, function (_, fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(escape'<C-p>', 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(escape'<Plug>luasnip-jump-prev', '')
      else
        fallback()
      end
    end),
    ['<CR>'] = cmp.mapping.confirm(),
    ['<C-d>'] = cmp.mapping.scroll(-4),
    ['<C-f>'] = cmp.mapping.scroll(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
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

-- local opts = {expr = true}

-- Q.mm('i', '<Tab>', 'v:lua.tab_complete()', opts)
-- Q.mm('s', '<Tab>', 'v:lua.tab_complete()', opts)
-- Q.mm('i', '<S-Tab>', 'v:lua.s_tab_complete()', opts)
-- Q.mm('s', '<S-Tab>', 'v:lua.s_tab_complete()', opts)
-- Q.mm('i', '<C-Tab>', '<Plug>luasnip-expand-or-jump', {})

-- Q.mm(
--   'i',
--   '<C-e>',
--   [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
--   opts
-- )

-- Q.mm(
--   's',
--   '<C-e>',
--   [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
--   opts
-- )

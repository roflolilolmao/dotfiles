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
    ['<Tab>'] = function (fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(escape'<C-n>', 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(escape'<Plug>luasnip-expand-or-jump', '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function (fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(escape'<C-p>', 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(escape'<Plug>luasnip-jump-prev', '')
      else
        fallback()
      end
    end,
    ['<CR>'] = cmp.mapping.confirm(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
  },

  sources = {
    {name = 'path'},
    {name = 'luasnip'},
    {name = 'nvim_lsp'},
  };
}

require'cmp_nvim_lsp'.setup{}
require'cmp_luasnip'

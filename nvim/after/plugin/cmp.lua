local cmp = require 'cmp'
local luasnip = require 'luasnip'

local function feed(map, mode)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(map, true, true, true),
    mode,
    true
  )
end

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, item)
      item.kind = string.format('%s [%s]', item.kind, entry.source.name)
      return item
    end,
  },

  documentation = {
    border = Q.border,
    winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        feed('<C-n>', 'n')
      elseif luasnip.expand_or_jumpable() then
        feed('<Plug>luasnip-expand-or-jump', '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        feed('<C-p>', 'n')
      elseif luasnip.jumpable(-1) then
        feed('<Plug>luasnip-jump-prev', '')
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

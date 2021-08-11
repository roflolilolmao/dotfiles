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
    return vim.fn['compe#complete']()
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

Q.mm('i', '<C-Space>', 'compe#complete()', opts)
-- compe will autoselect the first item
Q.mm('i', '<CR>', [[compe#confirm({'keys': '<CR>', 'select': v:true})]], opts)
Q.mm('i', '<C-e>', [[compe#close('<C-e>')]], opts)

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


require'compe'.setup{
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    luasnip = true;
    nvim_lsp = true;
    treesitter = true;
    --nvim_lua = true;

    buffer = false;
  };
}

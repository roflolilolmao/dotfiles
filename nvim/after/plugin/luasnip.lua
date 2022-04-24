local luasnip = require 'luasnip'
local types = require 'luasnip.util.types'

luasnip.config.setup {
  history = false,
  region_check_events = 'InsertEnter',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '●', 'Constant' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '●', 'Identifier' } },
      },
    },
  },
}

luasnip.add_snippets('python', {
  luasnip.snippet('rich', {
    luasnip.text_node { 'from rich import print', 'print(' },
    luasnip.insert_node(0),
    luasnip.text_node { ')', '' },
  }),
})

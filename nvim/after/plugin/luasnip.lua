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

luasnip.snippets = {
  markdown = {
    luasnip.snippet('url', {
      luasnip.text_node '[',
      luasnip.insert_node(1),
      luasnip.text_node '](',
      luasnip.insert_node(2),
      luasnip.text_node ')',
      luasnip.insert_node(0),
    }),
  },
  python = {
    luasnip.snippet('rich', {
      luasnip.text_node('from rich import inspect, print', ''),
      luasnip.insert_node(0),
    }),
  },
}

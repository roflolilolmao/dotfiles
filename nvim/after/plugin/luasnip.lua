local luasnip = require 'luasnip'

luasnip.config.set_config {
  history = false,
  region_check_events = 'InsertEnter',
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
    })
  },
  python = {
    luasnip.snippet('rich', {
      luasnip.text_node('from rich import inspect, print', ''),
      luasnip.insert_node(0),
    }),
  },
}

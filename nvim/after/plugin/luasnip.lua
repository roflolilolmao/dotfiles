local luasnip = require 'luasnip'

luasnip.config.set_config {
  history = false,
  region_check_events = 'InsertEnter',
}

luasnip.snippets = {
  python = {
    luasnip.snippet('rich', {
      luasnip.text_node('from rich import inspect, print', ''),
      luasnip.insert_node(0),
    }),
  },
}

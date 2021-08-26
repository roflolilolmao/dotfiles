local luasnip = require("luasnip")

luasnip.config.set_config{
  enable_autosnippets = false,
  history = false,
  updateevents = 'TextChanged,TextChangedI',
}

luasnip.snippets = {
  python = {
    luasnip.snippet('rich', {
      luasnip.text_node('from rich import inspect, print', ''),
      luasnip.insert_node(0),
    }),
  },
}

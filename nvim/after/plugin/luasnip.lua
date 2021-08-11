-- Taken from
-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

local luasnip = require("luasnip")

local expr_opts = {silent = true, expr = true}

Q.mm(
  'i',
  '<C-e>',
  [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
  expr_opts
)

Q.mm(
  's',
  '<C-e>',
  [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>']],
  expr_opts
)

-- some shorthands...
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node

local l = require('luasnip.extras').lambda
local r = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda

-- Every unspecified option will be set to the default.
luasnip.config.set_config({
  enable_autosnippets = true,
  history = true,
  -- Update more often, :h events for more info.
  updateevents = 'TextChanged,TextChangedI',
})

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local recursive_table
recursive_table = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(''),
      sn( nil, {
        t({'', '| `' }),
        i(1),
        t({'` | ' }),
        i(2),
        t({' |' }),
        d(3, recursive_table, {})
      }),
    })
  )
end

local function char_count_same(c1, c2)
  local line = vim.api.nvim_get_current_line()
  -- '%'-escape chars to force explicit match (gsub accepts patterns).
  -- second return value is number of substitutions.
  local _, ct1 = string.gsub(line, '%'..c1, '')
  local _, ct2 = string.gsub(line, '%'..c2, '')
  return ct1 == ct2
end

local function even_count(arg)
  local line = vim.api.nvim_get_current_line()
  local _, ct = string.gsub(line, arg, '')
  return ct % 2 == 0
end

local function neg(fn, ...)
  return not fn(...)
end

-- This makes creation of pair-type snippets easier.
local function pair(pair_begin, pair_end, expand_func, ...)
  -- triggerd by opening part of pair, wordTrig=false to trigger anywhere.
  -- ... is used to pass any args following the expand_func to it.
  return s(
    {trig = pair_begin, wordTrig=false},
    {t({pair_begin}), i(1), t({pair_end})},
    expand_func,
    ...,
    pair_begin,
    pair_end
  )
end

luasnip.snippets = {
  all = {
    -- When wordTrig is set to false, snippets may also expand inside other words.
    --luasnip.parser.parse_snippet(
    --{ trig = 'te', wordTrig = false },
    --'${1:cond} ? ${2:true} : ${3:false}'
    --),

    -- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
    --luasnip.parser.parse_snippet({ trig = '%d', regTrig = true }, 'A Number!!'),

    -- The last entry of args passed to the user-function is the surrounding snippet.
    --s(
    --{ trig = 'a%d', regTrig = true },
    --f(function(args)
      --return 'Triggered with ' .. args[1].trigger .. '.'
    --end, {})
    --),

    -- It's possible to use capture-groups inside regex-triggers.
    --s(
    --{ trig = 'b(%d)', regTrig = true },
    --f(function(args)
      --return 'Captured Text: ' .. args[1].captures[1] .. '.'
    --end, {})
    --),

    -- Short version for applying String transformations using function nodes.
    --s('transform', {
      --i(1, 'initial text'),
      --t({ '', '' }),
      -- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
      -- This list will be applied in order to the first node given in the second argument.
      --l(l._1:match('[^i]*$'):gsub('i', 'o'):gsub(' ', '_'):upper(), 1),
    --}),
    --s('transform2', {
      --i(1, 'initial text'),
      --t('::'),
      --i(2, 'replacement for e'),
      --t({ '', '' }),
      -- Lambdas can also apply transforms USING the text of other nodes:
      --l(l._1:gsub('e', l._2), { 1, 2 }),
    --}),

    -- Shorthand for repeating the text in a given node.
    --s('repeat', { i(1, 'text'), t({ '', '' }), r(1) }),

    -- Directly insert the ouput from a function evaluated at runtime.
    --s('part', p(os.date, '%Y')),

    -- use matchNodes to insert text based on a pattern/function/lambda-evaluation.
    --s('mat', {
      --i(1, { 'sample_text' }),
      --t(': '),
      --m(1, '%d', 'contains a number', 'no number :('),
    --}),

    -- The inserted text defaults to the first capture group/the entire
    -- match if there are none
    --s('mat2', {
      --i(1, { 'sample_text' }),
      --t(': '),
      --m(1, '[abc][abc][abc]'),
    --}),

    -- It is even possible to apply gsubs' or other transformations
    -- before matching.
    --s('mat3', {
      --i(1, { 'sample_text' }),
      --t(': '),
      --m(
      --1,
      --l._1:gsub('[123]', ''):match('%d'),
      --"contains a number that isn't 1, 2 or 3!"
      --),
    --}),

    -- `match` also accepts a function, which in turn accepts a string
    -- (text in node, \n-concatted) and returns any non-nil value to match.
    -- If that value is a string, it is used for the default-inserted text.
    --s('mat4', {
      --i(1, { 'sample_text' }),
      --t(': '),
      --m(1, function(text)
        --return (#text % 2 == 0 and text) or nil
      --end),
    --}),

    -- The nonempty-node inserts text depending on whether the arg-node is
    -- empty.
    --s('nempty', {
      --i(1, 'sample_text'),
      --n(1, 'i(1) is not empty!'),
    --}),

    -- dynamic lambdas work exactly like regular lambdas, except that they
    -- don't return a textNode, but a dynamicNode containing one insertNode.
    -- This makes it easier to dynamically set preset-text for insertNodes.
    --s('dl1', {
      --i(1, 'sample_text'),
      --t({ ':', '' }),
      --dl(2, l._1, 1),
    --}),

    -- Obviously, it's also possible to apply transformations, just like lambdas.
    --s('dl2', {
      --i(1, 'sample_text'),
      --i(2, 'sample_text_2'),
      --t({ '', '' }),
      --dl(3, l._1:gsub('\n', ' linebreak ') .. l._2, { 1, 2 }),
    --}),

    pair("(", ")", neg, char_count_same),
    pair("{", "}", neg, char_count_same),
    pair("[", "]", neg, char_count_same),
    pair("<", ">", neg, char_count_same),
    pair("'", "'", neg, even_count),
    pair('"', '"', neg, even_count),
    pair("`", "`", neg, even_count),
  },
  lua = {
    s({trig='if', wordTrig=true}, {
      t({'if '}),
      i(1),
      t({' then', '\t'}),
      i(0),
      t({'', 'end'})
    }),
    s({trig='ee', wordTrig=true}, {
      t({'else', '\t'}),
      i(0),
    })
  },
  markdown = {
    s('table', {
      t({ '| ' }),
      i(1),
      t({ ' | ' }),
      i(2),
      t({ ' |', '| -- | -- |' }),
      d(3, recursive_table, {}),
    }),
  },
  python = {
    s({trig='if', wordTrig=true}, {
      t({'if '}),
      i(1),
      t({':', '\t'}),
      i(0),
    }),
    s({trig='ee', wordTrig=true}, {
      t({'else:', '\t'}),
      i(0),
    }),
    s('print', {
      t('print('),
      i(0),
      t(')'),
    }),
  },
}

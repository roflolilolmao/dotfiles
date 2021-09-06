if vim.fn.has 'win32' == 1 then
  return
end

require('neuron').setup {
  neuron_dir = '~/neuron',
  mappings = true,
  leader = '<Leader>e',
}

Q.m(
  '<Leader>en',
  [[<Cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<CR>]]
)

Q.m('<Leader>ee', [[<Cmd>lua require'neuron/telescope'.find_zettels()<CR>]])

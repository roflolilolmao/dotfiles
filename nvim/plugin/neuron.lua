if vim.fn.has('win32') then
  return
end

require'neuron'.setup {
  neuron_dir = '~/neuron',
  mappings = true,
  leader = '<Leader>e',
}

Q.m(
  'n',
  '<Leader>en',
  [[<Cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<CR>]]
)

Q.m(
  'n',
  '<Leader>ee',
  [[<Cmd>lua require'neuron/telescope'.find_zettels()<CR>]]
)

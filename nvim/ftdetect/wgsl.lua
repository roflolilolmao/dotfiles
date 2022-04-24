vim.api.nvim_create_autocmd(
  {'BufRead', 'BufNewFile'},
  {
    pattern = {"*.wgsl"},
    callback = function()
      vim.bo.filetype = 'wgsl'
    end,
  }
)

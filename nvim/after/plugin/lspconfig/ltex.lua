-- source: https://gist.github.com/lbiaggi/a3eb761ac2fdbff774b29c88844355b8

--[[
  Waiting for https://github.com/neovim/nvim-lspconfig/pull/863

  https://github.com/valentjn/ltex-ls

  require'q.lsp.ltex'

local lspconfig = require'lspconfig'

if not lspconfig.ltex then
  require'lspconfig/configs'.ltex = {
    default_config = {
      cmd = {'ltex-ls'};
      filetypes = {'tex', 'bib', 'markdown'};
      root_dir = function(filename)
        util = require'lspconfig/util'
        return (
          util.find_git_ancestor(filename)
          or util.path.dirname(filename)
        )
      end;
      settings = {
        ltex = {
          enabled = {'latex', 'tex', 'bib', 'md', 'markdown'},
          checkFrequency = 'edit',
          language = 'en',
          sentenceCacheSize = 5000,
          additionalRules = {
            enablePickyRules = true,
            motherTongue = 'en',
          };
        },
      };
    };
  };
end

lspconfig['ltex'].setup{
  on_attach = Q.lsp_on_attach,
}
]]

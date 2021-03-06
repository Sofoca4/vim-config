local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'omnisharp/omnisharp-roslyn' -- Omnisharp plugin
  use 'mfussenegger/nvim-dap' -- Debugger
end)

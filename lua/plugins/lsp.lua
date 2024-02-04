return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local lsp_zero = require('lsp-zero')
      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end
  },
  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
}

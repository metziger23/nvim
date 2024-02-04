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
      lsp_zero.extend_lspconfig()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        handlers = {
          lsp_zero.default_setup,
        },

        -- list of servers for mason to install
        ensure_installed = {
          "lua_ls",
          "clangd",
          "bashls",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })
    end
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      local mason_tool_installer = require("mason-tool-installer")
      mason_tool_installer.setup({
        ensure_installed = {
          "stylua", -- lua formatter
          "clang-format",
        },
      })
    end
  }
}

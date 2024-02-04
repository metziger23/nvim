return {
  'stevearc/conform.nvim',
  opts = {},

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
    })
  end
}

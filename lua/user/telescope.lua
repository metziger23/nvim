return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files"})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep"})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help Tags"})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers"})
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Find Old Files"})
    vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Find String Under Cursor"})
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = "Find Marks"})
  end,
}

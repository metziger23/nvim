return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
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
			extensions = {
				file_browser = {
					hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("noice")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
		vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find String Under Cursor" })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Find Marks" })

		local opts = { noremap = true }
		opts.desc = "Open Explorer"
		vim.api.nvim_set_keymap("n", "<space>ee", ":Telescope file_browser<CR>", opts)

		-- open file_browser with the path of the current buffer
		opts.desc = "Open Explorer On Current Buffer"
		vim.api.nvim_set_keymap("n", "<space>ec", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
	end,
}

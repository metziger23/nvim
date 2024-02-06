return {
	-- https://github.com/RRethy/vim-illuminate
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	dependencies = { "folke/which-key.nvim" },
	config = function()
		local illuminate = require("illuminate")
		illuminate.configure({
			delay = 250,
		})

		require("which-key").register({
			["<C-p>"] = {
				illuminate.goto_prev_reference,
				"illuminate: [p]rev reference",
			},
			["<C-n>"] = {
				illuminate.goto_next_reference,
				"illuminate: [n]ext reference",
			},
		}, {})
	end,
}

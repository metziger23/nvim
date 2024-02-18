return {
	"stevearc/overseer.nvim",
	opts = {},
	config = function()
		require("overseer").setup({
			templates = { "builtin", "user.run-qmake", "user.make-qmake_all", "user.run-make" },
		})
	end,
}

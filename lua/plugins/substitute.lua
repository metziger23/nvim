return {
	"gbprod/substitute.nvim",
	config = function()
		local substitute = require("substitute")
		local exchange = require("substitute.exchange")

		substitute.setup({
			highlight_substituted_text = {
				enabled = false,
			},
		})

		local opts = { noremap = true }
		vim.keymap.set("n", "s", substitute.operator, opts)
		vim.keymap.set("n", "ss", substitute.line, opts)
		vim.keymap.set("n", "S", substitute.eol, opts)
		vim.keymap.set("x", "s", substitute.visual, opts)

		vim.keymap.set("n", "sx", exchange.operator, opts)
		vim.keymap.set("n", "sxx", exchange.line, opts)
		vim.keymap.set("x", "X", exchange.visual, opts)
		vim.keymap.set("n", "sxc", exchange.cancel, opts)
	end,
}

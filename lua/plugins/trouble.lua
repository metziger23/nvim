return {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle", "Trouble" },
	opts = { use_diagnostic_signs = true },
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
		{ "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Toggle Trouble LSP References" },
	},
}

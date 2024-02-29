local ToggleTerm = {

	bashtop = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "bashtop", direction = "float" })
		return t:toggle()
	end,

	lazygit = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "lazygit", direction = "float" })
		return t:toggle()
	end,

	neomutt = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "neomutt", direction = "float" })
		return t:toggle()
	end,

	ranger = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local t = Terminal:new({ cmd = "ranger", direction = "float" })
		return t:toggle()
	end,
}

return {
	"akinsho/toggleterm.nvim",
	enabled = true,
	version = "*",
	opts = {
		size = 13,
		open_mapping = [[<c-\>]],
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = "1",
		start_in_insert = true,
		persist_size = true,
		direction = "horizontal",
	},
	keys = {
		{ "<leader>Tb", "<cmd>lua ToggleTerm.bashtop()<cr>", "Bashtop" },
		{ "<leader>Tl", function () ToggleTerm.lazygit() end, "LazyGit" },
		{ "<leader>Tm", "<cmd>lua ToggleTerm.neomutt()<cr>", "Neomutt" },
		{ "<leader>Tr",function () ToggleTerm.ranger() end, "Ranger" },
	},
}


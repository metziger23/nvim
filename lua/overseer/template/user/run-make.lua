return {
	name = "run make",
	builder = function()
		local make_utils = require("utils.make")
		local make = make_utils.generate_make()
        local cores = tostring(vim.fn.system("nproc"))
		return {
			cmd = make,
			args = {  "-j" .. cores },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}

return {
	name = "run qmake",
	params = {
		build_type = {
			type = "enum",
			name = "Build type",
			optional = false,
			default = "debug",
			choices = { "debug", "release" },
		},
	},
	builder = function(params)
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")

		local debug = require("utils.qmake").generate_build_type_param(params.build_type)

        local spec = "macx-clang"

		local qmake = "/Users/mgulyi/Qt/6.6.1/macos/bin/qmake"
		return {
			cmd = { qmake },
			args = { "-spec", spec, debug },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}

local M = {}

function M.generate_build_type_param(build_type)
	if build_type == "debug" then
		return "CONFIG+=debug"
	elseif build_type == "release" then
		return ""
	end
end

function M.generate_spec()
   if(vim.fn.has("mac")) then
        return "macx-clang"
   end
end

function M.generate_qmake()
   if(vim.fn.has("mac")) then
        return "/Users/mgulyi/Qt/6.6.1/macos/bin/qmake"
   end
end

return M

local M = {}

function M.generate_build_type_param(build_type)
	if build_type == "debug" then
		return "CONFIG+=debug"
	elseif build_type == "release" then
		return ""
	end
end

return M

local M = {}

function M.generate_make()
   if(vim.fn.has("unix")) then
        return "/usr/bin/make"
    end
end

return M

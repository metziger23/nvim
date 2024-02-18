local M = {}

function M.generate_make()
   if(vim.fn.has("unix")) then
        return "/usr/bin/make"
    end
end

function M.get_number_of_cores()
    if(vim.fn.has("unix")) then
        return vim.fn.system("nproc")
    end
end

return M

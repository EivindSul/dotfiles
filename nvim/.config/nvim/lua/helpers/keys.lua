local M = {}

M.map = function(mode, lhs, rhs, desc, ...)
	local args = { ... }
	local action

    if #args > 0 then
        -- If arguments are provided, create an anonymous function to wrap the function call
        action = function() rhs(unpack(args)) end
	else
        action = rhs
    end

	vim.keymap.set(mode, lhs, action, { silent = true, desc = desc })
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
	vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

M.dap_map = function(mode, lhs, rhs, desc)
	M.map(mode, lhs, rhs, desc)
end

M.set_leader = function(key)
	vim.g.mapleader = key
	vim.g.maplocalleader = key
	M.map({ "n", "v" }, key, "<nop>")
end

return M

local M = {}
local state = {}
state.panes = {}

local function forget_on_close(pane_id)
	if pane_id == "" or pane_id == nil then
		return
	end

	local on_exit = function(_)
		if state.current_runner_pane == pane_id then
			state.current_runner_pane = nil
		end
		for i, pane in ipairs(state.panes) do
			if pane == pane_id then
				table.remove(state.panes, i)
				break
			end
		end
	end

	vim.system({ "zellij", "subscribe", "--pane-id", pane_id }, { text = true }, on_exit)
end

M.prompt_and_run_command = function()
	local cmd = vim.fn.input("Command to run (default is makeprg): ")
	vim.cmd("redraw")
	if cmd == "" then
		cmd = vim.fn.expandcmd(vim.bo.makeprg)
	end
	if cmd == "" then
		cmd = vim.fn.expandcmd(vim.o.makeprg)
	end
	if cmd == "" then
		print("No command specified")
	end

	cmd, _ = string.gsub(cmd, "%%", vim.fn.expand("%"))
	cmd, _ = string.gsub(cmd, "%#", vim.fn.expand("#"))

	return M.start_runner(cmd)
end

M.start_runner = function(command)
	if command == "" then
		print("No command given")
		return -1
	end
	local cmd = vim.split(command, "%s+", { trimempty = true })
	local full_cmd = vim.list_extend({ "zellij", "run", "--" }, cmd)
	local res = vim.system(full_cmd, { text = true }):wait()

	if res.code ~= 0 then
		return -1
	end
	local pane_id = vim.fn.trim(res.stdout)
	state.current_runner_pane = pane_id
	table.insert(state.panes, pane_id)
	forget_on_close(pane_id)
	return pane_id
end

M.close_runner = function()
	local pane_id = state.current_runner_pane
	if pane_id == nil then
		return
	end

	vim.system({ "zellij", "action", "close-pane", "--pane-id", pane_id }, { text = true }):wait()
end

M.rerun_or_run = function()
	if not state.current_runner_pane then
		M.prompt_and_run_command()
		return 1
	else
		return M.rerun_runner(state.current_runner_pane)
	end
end

M.rerun_runner = function(pane_id)
	if pane_id == "" then
		print("No pane_id given")
		return -1
	end
	local res = vim.system({ "zellij", "action", "send-keys", "--pane-id", pane_id, "Enter" }, { text = true }):wait()

	if res.code ~= 0 then
		return -1
	end
	return 1
end

return M


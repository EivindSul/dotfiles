vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/igorlfs/nvim-dap-view",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/leoluz/nvim-dap-go",
})

local dap = require("dap")
local view = require("dap-view")

local function get_pid_of_process(pname)
	if pname == "" then
		print("No process name given")
		return -1
	else
		local obj = vim.system({ "pgrep", pname }, { text = true }):wait()

		if obj.code ~= 0 then
			return -1
		end
		local pid = obj.stdout
		-- vim.notify("PID is " .. pid, vim.log.levels.INFO)
		return tonumber(pid)
	end
end

local function prompt_for_pid()
	local pname = vim.fn.input("Enter search string for process: ")
	vim.cmd("redraw")

	local pid = get_pid_of_process(pname)
	return pid
end

dap.adapters.delve = function(callback, config)
	if config.mode == "remote" and config.request == "attach" then
		callback({
			type = "server",
			host = config.host or "127.0.0.1",
			port = config.port or "38697",
		})
	else
		callback({
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
				detached = vim.fn.has("win32") == 0,
			},
		})
	end
end

-- https://github.com/leoluz/nvim-dap-go/blob/main/lua/dap-go.lua
-- TODO: Maybe copy some logic from dap-go to create a proper picker for PID?
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{ -- NOTE: Breaks on multiple matching processes
		type = "delve",
		name = "Attach local",
		mode = "local",
		request = "attach",
		processId = function()
			local pid = prompt_for_pid()
			if pid == -1 then
				vim.notify("Process not found", vim.log.levels.WARN)
				return nil
			else
				return pid
			end
		end,
	},
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

local function conditional_breakpoint()
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
		dap.set_breakpoint(input)
	end)
end
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", conditional_breakpoint, { desc = "Set conditional breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
vim.keymap.set("n", "<leader>dx", dap.clear_breakpoints, { desc = "Clear breakpoints" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL view" })
-- vim.keymap.set("n", "<leader>du", ui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>du", view.toggle, { desc = "Toggle DAP UI" })
-- https://www.reddit.com/r/neovim/comments/1ge0al4/is_it_possible_to_add_variable_to_watch_list_at/
-- TODO: ^Do this, but for dap-view

-- Eval var under cursor
-- vim.keymap.set("n", "<leader>d?", function()
-- 	require("dapui").eval(nil, { enter = true })
-- end, { desc = "Eval var under cursor" })

vim.keymap.set("n", "<F1>", dap.continue, { desc = "dap.continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "dap.step_into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "dap.step_over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "dap.step_out" })
vim.keymap.set("n", "<F5>", dap.step_back, { desc = "dap.step_back" })
vim.keymap.set("n", "<F6>", dap.restart, { desc = "dap.restart" })
vim.keymap.set("n", "<F7>", dap.terminate, { desc = "dap.terminate" })

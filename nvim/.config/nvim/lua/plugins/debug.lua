return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- "leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			-- require("dap-go").setup()
			-- require("dap-python").setup("python3")
			require("dap-python").setup(
				"/home/eivind/Documents/skole/master/8sem/dat259/miniconda/conda/envs/snail/bin/python"
			)
			table.insert(require("dap").configurations.python, {
				type = "python",
				request = "launch",
				name = "Debug driver.py with scratch.snail",
				cwd = "/home/eivind/Documents/skole/master/8sem/dat259/snail/src",
				module = "snail.driver",
				args = { "/home/eivind/Documents/skole/master/8sem/dat259/snail/samples/scratch.snail" },
			})

			require("nvim-dap-virtual-text").setup()

			-- Handled by nvim-dap-go
			-- dap.adapters.go = {
			--   type = "server",
			--   port = "${port}",
			--   executable = {
			--     command = "dlv",
			--     args = { "dap", "-l", "127.0.0.1:${port}" },
			--   },
			-- }
			-- local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
			-- if elixir_ls_debugger ~= "" then
			--   dap.adapters.mix_task = {
			--     type = "executable",
			--     command = elixir_ls_debugger,
			--   }
			--
			--   dap.configurations.elixir = {
			--     {
			--       type = "mix_task",
			--       name = "phoenix server",
			--       task = "phx.server",
			--       request = "launch",
			--       projectDir = "${workspaceFolder}",
			--       exitAfterTaskReturns = false,
			--       debugAutoInterpretAllModules = false,
			--     },
			--   }
			-- end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Debug: Run to cursor" })

			-- Eval var under cursor
			vim.keymap.set("n", "<leader>d?", function()
				require("dapui").eval(nil, { enter = true })
			end, { desc = "Eval var under cursor" })

			vim.keymap.set("n", "<F1>", dap.continue, { desc = "dap.continue" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = "dap.step_into" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = "dap.step_over" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = "dap.step_out" })
			vim.keymap.set("n", "<F5>", dap.step_back, { desc = "dap.step_back" })
			vim.keymap.set("n", "<F6>", dap.restart, { desc = "dap.restart" })

			vim.keymap.set("n", "<leader>du", ui.toggle, { desc = "Toggle DAP UI" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	ui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	ui.close()
			-- end
		end,
	},
}

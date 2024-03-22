return {
	{
		"nvim-neotest/neotest",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rcasia/neotest-java",
			"nvim-neotest/neotest-python",
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python"),
					require("neotest-java")({
						ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
					}),
				}
			})

			local map = require("helpers.keys").map
			map("n", "<leader>tt", neotest.summary.toggle, "Toggle summary pane")
			-- map("n", "<leader>tr", function() neotest.run.run(vim.fn.getcwd()) end, "Run tests in current working directory")
			map("n", "<leader>tr", neotest.run.run, "Run tests in current working directory", vim.fn.getcwd())
		end
	}
}

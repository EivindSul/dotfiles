return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.add(
				{
					{ "<leader>T", group = "LaTeX" },
					{ "<leader>d", group = "Debugging" },
					{ "<leader>f", group = "File" },
					{ "<leader>g", group = "Git" },
					{ "<leader>l", group = "LSP" },
					{ "<leader>s", group = "Search" },
					{ "<leader>t", group = "Tests" },
					{ "<leader>u", group = "UI" },
				}
			)
		end
	}
}

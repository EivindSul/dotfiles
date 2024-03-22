return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.register(
				{
					["<leader>"] = {
						f = { name = "File" },
						-- d = { name = "Terminal" },
						d = { name = "Debugging" },
						s = { name = "Search" },
						S = { name = "Sessions" },
						l = { name = "LSP" },
						t = { name = "Tests" },
						T = { name = "LaTeX" },
						u = { name = "UI" },
						g = { name = "Git" },
					}
				}
			)
		end
	}
}

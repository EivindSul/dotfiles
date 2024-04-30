return {
	{
		"stevearc/conform.nvim",
		-- TODO: Fix config to make usable
		enabled = false,
		config = function ()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					java = { "astyle" },

				}
			})
		end
	}
}



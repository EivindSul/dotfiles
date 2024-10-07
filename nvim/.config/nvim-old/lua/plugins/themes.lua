-- Themes
return {
	"typicode/bg.nvim",

	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	{
		"rose-pine/nvim",
		name = "rose-pine",
	},

	"mhartington/oceanic-next",

	{
		"sainnhe/gruvbox-material",
		init = function ()
			vim.g.gruvbox_material_transparent_background = 1
			if vim.g.neovide then
				vim.g.gruvbox_material_background = "medium"
				vim.g.gruvbox_material_transparent_background = 0
			end
		end,
	},

	{
	"sainnhe/everforest",
		init = function ()
			vim.g.everforest_transparent_background = 1
		end,
	},

	"savq/melange-nvim"
}

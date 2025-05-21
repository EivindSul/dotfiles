return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim",
		},
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				code = {
					enabled = true,
					sign = true,
					style = "language",
					position = "left",
					language_pad = 0,
					disable_background = { "diff" },
					width = "full",
					left_margin = 0,
					left_pad = 0,
					right_pad = 0,
					min_width = 0,
					border = "thin",
					above = "▄",
					below = "▀",
					highlight = "RenderMarkdownCode",
					highlight_inline = "RenderMarkdownCodeInline",
				},
				link = {
					enabled = true,
					image = "󰥶 ",
					email = "󰀓 ",
					hyperlink = "󰌹 ",
					highlight = "RenderMarkdownLink",
					wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
					custom = {
						web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
					},
				},
				heading = {
					enabled = false,
				},
				paragraph = {
					enabled = false,
				},
				dash = {
					enabled = false,
				},
				bullet = {
					enabled = false,
				},
				checkbox = {
					enabled = false,
				},
				quote = {
					enabled = false,
				},
				pipe_table = {
					enabled = false,
				},
				sign = {
					enabled = false,
				},
				indent = {
					enabled = false,
				},
			})
		end,
	},
}

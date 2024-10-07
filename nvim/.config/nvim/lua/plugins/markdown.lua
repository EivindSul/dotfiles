return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				code = {
					-- Turn on / off code block & inline code rendering
					enabled = true,
					-- Turn on / off any sign column related rendering
					sign = true,
					-- Determines how code blocks & inline code are rendered:
					--  none:     disables all rendering
					--  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
					--  language: adds language icon to sign column if enabled and icon + name above code blocks
					--  full:     normal + language
					style = "language",
					-- Determines where language icon is rendered:
					--  right: right side of code block
					--  left:  left side of code block
					position = "left",
					-- Amount of padding to add around the language
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					language_pad = 0,
					-- A list of language names for which background highlighting will be disabled
					-- Likely because that language has background highlights itself
					disable_background = { "diff" },
					-- Width of the code block background:
					--  block: width of the code block
					--  full:  full width of the window
					width = "full",
					-- Amount of margin to add to the left of code blocks
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Margin available space is computed after accounting for padding
					left_margin = 0,
					-- Amount of padding to add to the left of code blocks
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					left_pad = 0,
					-- Amount of padding to add to the right of code blocks when width is 'block'
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					right_pad = 0,
					-- Minimum width to use for code blocks when width is 'block'
					min_width = 0,
					-- Determins how the top / bottom of code block are rendered:
					--  thick: use the same highlight as the code body
					--  thin:  when lines are empty overlay the above & below icons
					border = "thin",
					-- Used above code blocks for thin border
					above = "▄",
					-- Used below code blocks for thin border
					below = "▀",
					-- Highlight for code blocks
					highlight = "RenderMarkdownCode",
					-- Highlight for inline code
					highlight_inline = "RenderMarkdownCodeInline",
				},
				heading = {
					-- Turn on / off heading icon & background rendering
					enabled = false,
					-- Turn on / off any sign column related rendering
					sign = true,
					-- Determines how icons fill the available space:
					--  inline:  underlying '#'s are concealed resulting in a left aligned icon
					--  overlay: result is left padded with spaces to hide any additional '#'
					position = "overlay",
					-- Replaces '#+' of 'atx_h._marker'
					-- The number of '#' in the heading determines the 'level'
					-- The 'level' is used to index into the list using a cycle
					icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
					-- Added to the sign column if enabled
					-- The 'level' is used to index into the list using a cycle
					signs = { "󰫎 " },
					-- Width of the heading background:
					--  block: width of the heading text
					--  full:  full width of the window
					-- Can also be a list of the above values in which case the 'level' is used
					-- to index into the list using a clamp
					width = "full",
					-- Amount of margin to add to the left of headings
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Margin available space is computed after accounting for padding
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					left_margin = 0,
					-- Amount of padding to add to the left of headings
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					left_pad = 0,
					-- Amount of padding to add to the right of headings when width is 'block'
					-- If a floating point value < 1 is provided it is treated as a percentage of the available window space
					-- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
					right_pad = 0,
					-- Minimum width to use for headings when width is 'block'
					-- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
					min_width = 0,
					-- Determins if a border is added above and below headings
					border = false,
					-- Alway use virtual lines for heading borders instead of attempting to use empty lines
					border_virtual = false,
					-- Highlight the start of the border using the foreground highlight
					border_prefix = false,
					-- Used above heading for border
					above = "▄",
					-- Used below heading for border
					below = "▀",
					-- The 'level' is used to index into the list using a clamp
					-- Highlight for the heading icon and extends through the entire line
					backgrounds = {
						"RenderMarkdownH1Bg",
						"RenderMarkdownH2Bg",
						"RenderMarkdownH3Bg",
						"RenderMarkdownH4Bg",
						"RenderMarkdownH5Bg",
						"RenderMarkdownH6Bg",
					},
					-- The 'level' is used to index into the list using a clamp
					-- Highlight for the heading and sign icons
					foregrounds = {
						"RenderMarkdownH1",
						"RenderMarkdownH2",
						"RenderMarkdownH3",
						"RenderMarkdownH4",
						"RenderMarkdownH5",
						"RenderMarkdownH6",
					},
				},
			})
		end,
	},
}

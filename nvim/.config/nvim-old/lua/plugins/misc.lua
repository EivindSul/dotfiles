local map = require("helpers.keys").map
-- require("helpers.keys").map("n", "<leader>L", lazy.show, "Show Lazy")
return {
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			-- require("mini.pairs").setup() -- æsj ikke gøy
			require("mini.ai").setup()
			require("mini.sessions").setup()
			require("mini.starter").setup()
			require("mini.surround").setup()
			require("mini.comment").setup({
				options = {
					ignore_blank_line = true,
				}
			})
			require("mini.hipatterns").setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
					todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
					note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
				},
			})
		end
	},
	-- bufremove

	-- Prøve mini.hues, mini.colors, lage syknronisert fargeskjema med tmux/zellij

	-- Better buffer closing actions. Available via the buffers helper.
	-- TODO: Bytte med mini.bufremove
	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}

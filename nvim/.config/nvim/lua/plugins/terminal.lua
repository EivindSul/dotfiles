return {
	{ -- Toggle floating or bottom terminals.
		'akinsho/toggleterm.nvim',
		version = "*",
		enabled = false,
		config = function()
			require("toggleterm").setup()
			local Terminal  = require('toggleterm.terminal').Terminal
			local map = require("helpers.keys").map

			local horizontal_terminal = Terminal:new({ direction = "horizontal", size = 30, hidden = true })
			local floating_terminal = Terminal:new({ direction = "float", hidden = true })

			function horizontal_terminal_toggle()
				horizontal_terminal:toggle()
			end

			function floating_terminal_toggle()
				floating_terminal:toggle()
			end

			map("n", "<leader>dh", "<cmd>lua horizontal_terminal_toggle()<cr>", "Toggle horizontal terminal")
			map("n", "<leader>dd", "<cmd>lua floating_terminal_toggle()<cr>", "Toggle floating terminal")
		end,
		opts = {
			--[[ things you want to change go here]]
		}
	},
	{ -- Opening nvim in a terminal will not make it nested
		"willothy/flatten.nvim",
		config = true,
		lazy = false,
		priority = 1001,
	},
}

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup()
			vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>NeoTreeRevealToggle<cr>", { desc = "Toggle file explorer" })
		end,
	},
}

vim.keymap.set("n", "<leader>pu", "<cmd>PlantumlUpdate<CR>",
	{ buffer = true, desc = "Manually trigger a PlantUML diagram update for the current buffer" })
vim.keymap.set("n", "<leader>pl", "<cmd>PlantumlLaunchBrowser<CR>",
	{ buffer = true, desc = "Open the PlantUML web viewer in your default browser" })
vim.keymap.set("n", "<leader>ps", "<cmd>PlantumlServerStart<CR>", { buffer = true, desc = "Start the PlantUML server" })
vim.keymap.set("n", "<leader>px", "<cmd>PlantumlServerStop<CR>", { buffer = true, desc = "Stop the PlantUML server" })


vim.opt_local.commentstring = "' %s"
vim.opt_local.comments = ":'"

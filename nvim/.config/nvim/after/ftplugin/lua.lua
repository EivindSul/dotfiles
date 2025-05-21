-- Source code
vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>", { desc = "Source current file", buffer = 0 })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Source current line", buffer = 0 })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source selected code", buffer = 0 })

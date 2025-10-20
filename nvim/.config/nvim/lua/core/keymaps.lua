-- Escape in normal mode to remove search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Double escape to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open terminal and enter insert mode
vim.keymap.set("n", "<leader>rt", function()
	local shell = vim.env.SHELL
	if shell == nil then
		vim.notify("SHELL variable empty, terminal cannot launch.")
	else
		vim.api.nvim_command("split +startinsert term://" .. shell)
	end
end, { desc = "Open terminal in split" })
vim.keymap.set("n", "<leader>rr", function()
	-- Gammel vimscript funkjon
	-- vim.g.runnerbuffer = vim.fn.bufadd("runner")
	-- Heller bruk denne: -- Den vim.api er mer modulær og stødig.
	-- vim.g.runnerbuffer = vim.api.nvim_create_buf()
	-- local bufnr = vim.fn.bufnr("runner")
	-- vim.notify(tostring(bufnr))
	-- vim.fn.bufadd
	print("Not implemented")
end, { desc = "Rerun" })
vim.keymap.set("n", "<leader>rR", function()
	print("Not implemented")
end, { desc = "Run current file" })
vim.keymap.set("n", "<leader>rw", function()
	print("Not implemented")
end, { desc = "Rerun on write" })

-- Free up arrow keys
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Easier navigation between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move windows around
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the bottom" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the top" })

-- Scroll half pages and center cursor in the middle of the screen
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })

-- LSP/Diagnostic keymaps. Mostly defaults with added description
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "List all references" })
vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "List all implementations" })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "Jump to type definition" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Jump to definition" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Jump to declaration" })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { desc = "Format current buffer" })
vim.keymap.set("n", "gx", vim.diagnostic.open_float, { desc = "Show diagnostics under cursor" })
vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { desc = "List all symbols in current buffer" })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Change view to next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Change view to previous buffer" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

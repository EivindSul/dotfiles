local function format_with_fmt()
	-- Get the selected range
	local start_line, start_col = vim.fn.line("'<"), vim.fn.col("'<")
	local end_line, end_col = vim.fn.line("'>"), vim.fn.col("'>")

	-- Get the text in the range
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local text = table.concat(lines, "\n")

	-- Run the shell command
	local formatted_text = vim.fn.system("fmt -w 80", text)

	-- Replace the original text with formatted text
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, vim.split(formatted_text, "\n"))
end

-- Keymaps
vim.keymap.set(
	"x",
	"<leader>f",
	format_with_fmt,
	{ noremap = true, silent = true, buffer = 0, desc = "Format to width 80" }
) -- Visual selection
-- vim.keymap.set("n", "<leader>f", ":'<,'>lua format_with_fmt()<CR>", { noremap = true, silent = true }) -- Motion-based

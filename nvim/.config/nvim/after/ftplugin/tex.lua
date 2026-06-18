vim.bo.textwidth = 80
vim.wo.colorcolumn = "+1"

vim.wo.spell = true

vim.keymap.set("n", "<leader>Ti", "<plug>(vimtex-info)", { buffer = true, desc = "VimTeX info" })
vim.keymap.set("n", "<leader>TI", "<plug>(vimtex-info-full)", { buffer = true, desc = "VimTeX info full" })
vim.keymap.set("n", "<leader>Tt", "<plug>(vimtex-toc-open)", { buffer = true, desc = "Show table of contents" })
vim.keymap.set("n", "<leader>TT", "<plug>(vimtex-toc-toggle)", { buffer = true, desc = "Toggle table of contents" })
vim.keymap.set("n", "<leader>Tq", "<plug>(vimtex-log)", { buffer = true, desc = "Show log" })
vim.keymap.set("n", "<leader>Tv", "<plug>(vimtex-view)", { buffer = true, desc = "Open pdf viewer" })
vim.keymap.set("n", "<leader>Tr", "<plug>(vimtex-reverse-search)", { buffer = true, desc = "Reverse search" })
vim.keymap.set("n", "<leader>Tl", "<plug>(vimtex-compile)", { buffer = true, desc = "Toggle continuous compiler" })
vim.keymap.set("n", "<leader>Tk", "<plug>(vimtex-stop)", { buffer = true, desc = "Stop continuous compiler" })
vim.keymap.set("n", "<leader>TL", "<plug>(vimtex-compile-ss)", { buffer = true, desc = "Compile document" })
vim.keymap.set("n", "<leader>TK", "<plug>(vimtex-stop-all)", { buffer = true, desc = "Stop compilation for all files" })
vim.keymap.set("n", "<leader>Te", "<plug>(vimtex-errors)", { buffer = true, desc = "Open error window" })
vim.keymap.set(
	"n",
	"<leader>To",
	"<plug>(vimtex-compile-output)",
	{ buffer = true, desc = "Open file where output is directed" }
)
vim.keymap.set("n", "<leader>Tg", "<plug>(vimtex-status)", { buffer = true, desc = "Show compilation status" })
vim.keymap.set(
	"n",
	"<leader>TG",
	"<plug>(vimtex-status-all)",
	{ buffer = true, desc = "Show compilation status for all files" }
)
vim.keymap.set("n", "<leader>Tc", "<plug>(vimtex-clean)", { buffer = true, desc = "Clean auxillary files" })
vim.keymap.set("n", "<leader>TC", "<plug>(vimtex-clean-full)", { buffer = true, desc = "Clean all output" })
vim.keymap.set("n", "<leader>Tm", "<plug>(vimtex-imaps-list)", { buffer = true, desc = "Show insert-mode mappings" })
vim.keymap.set("n", "<leader>Tx", "<plug>(vimtex-reload)", { buffer = true, desc = "Reload VimTeX" })
vim.keymap.set("n", "<leader>TX", "<plug>(vimtex-reload-state)", { buffer = true, desc = "Reload current buffer" })
vim.keymap.set("n", "<leader>Ts", "<plug>(vimtex-toggle-main)", { buffer = true, desc = "Set file as main" })
vim.keymap.set(
	"n",
	"<leader>Ta",
	"<plug>(vimtex-context-menu)",
	{ buffer = true, desc = "Show context menu on item below cursor" }
)

return {
	{
		"lervag/vimtex",
		enabled = true,
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_enabled = 1
			vim.g.vimtex_syntax_enabled = 1
			vim.g.vimtex_quickfix_mode = 0
		end,
		config = function()
			vim.keymap.set("n", "<leader>Ti", "<plug>(vimtex-info)", { desc = "VimTeX info" })
			vim.keymap.set("n", "<leader>TI", "<plug>(vimtex-info-full)", { desc = "VimTeX info full" })
			vim.keymap.set("n", "<leader>Tt", "<plug>(vimtex-toc-open)", { desc = "Show table of contents" })
			vim.keymap.set("n", "<leader>TT", "<plug>(vimtex-toc-toggle)", { desc = "Toggle table of contents" })
			vim.keymap.set("n", "<leader>Tq", "<plug>(vimtex-log)", { desc = "Show log" })
			vim.keymap.set("n", "<leader>Tv", "<plug>(vimtex-view)", { desc = "Open pdf viewer" })
			vim.keymap.set("n", "<leader>Tr", "<plug>(vimtex-reverse-search)", { desc = "Reverse search" })
			vim.keymap.set("n", "<leader>Tl", "<plug>(vimtex-compile)", { desc = "Toggle continuous compiler" })
			vim.keymap.set("n", "<leader>Tk", "<plug>(vimtex-stop)", { desc = "Stop continuous compiler" })
			vim.keymap.set("n", "<leader>TL", "<plug>(vimtex-compile-ss)", { desc = "Compile document" })
			vim.keymap.set("n", "<leader>TK", "<plug>(vimtex-stop-all)", { desc = "Stop compilation for all files" })
			vim.keymap.set("n", "<leader>Te", "<plug>(vimtex-errors)", { desc = "Open error window" })
			vim.keymap.set(
				"n",
				"<leader>To",
				"<plug>(vimtex-compile-output)",
				{ desc = "Open file where output is directed" }
			)
			vim.keymap.set("n", "<leader>Tg", "<plug>(vimtex-status)", { desc = "Show compilation status" })
			vim.keymap.set(
				"n",
				"<leader>TG",
				"<plug>(vimtex-status-all)",
				{ desc = "Show compilation status for all files" }
			)
			vim.keymap.set("n", "<leader>Tc", "<plug>(vimtex-clean)", { desc = "Clean auxillary files" })
			vim.keymap.set("n", "<leader>TC", "<plug>(vimtex-clean-full)", { desc = "Clean all output" })
			vim.keymap.set("n", "<leader>Tm", "<plug>(vimtex-imaps-list)", { desc = "Show insert-mode mappings" })
			vim.keymap.set("n", "<leader>Tx", "<plug>(vimtex-reload)", { desc = "Reload VimTeX" })
			vim.keymap.set("n", "<leader>TX", "<plug>(vimtex-reload-state)", { desc = "Reload current buffer" })
			vim.keymap.set("n", "<leader>Ts", "<plug>(vimtex-toggle-main)", { desc = "Set file as main" })
			vim.keymap.set(
				"n",
				"<leader>Ta",
				"<plug>(vimtex-context-menu)",
				{ desc = "Show context menu on item below cursor" }
			)
			-- map("nx", "<leader>tL", "<plug>(vimtex-compile-selected)", "Compile the selected part of the current file")
			-- map("n", "dse", "<plug>(vimtex-env-delete)", "placeholder")
			-- map("n", "dsc", "<plug>(vimtex-cmd-delete)", "placeholder")
			-- map("n", "ds", "<plug>(vimtex-env-delete-math)", "placeholder")
			-- map("n", "dsd", "<plug>(vimtex-delim-delete)", "placeholder")
			-- map("n", "cse", "<plug>(vimtex-env-change)", "placeholder")
			-- map("n", "csc", "<plug>(vimtex-cmd-change)", "placeholder")
			-- map("n", "cs", "<plug>(vimtex-env-change-math)", "placeholder")
			-- map("n", "csd", "<plug>(vimtex-delim-change-math)", "placeholder")
			-- map("nx", "tsf", "<plug>(vimtex-cmd-toggle-frac)", "placeholder")
			-- map("n", "tsc", "<plug>(vimtex-cmd-toggle-star)", "placeholder")
			-- map("n", "tse", "<plug>(vimtex-env-toggle-star)", "placeholder")
			-- map("n", "ts", "<plug>(vimtex-env-toggle-math)", "placeholder")
			-- map("n", "<F6>", "<plug>(vimtex-env-surround-line)", "placeholder")
			-- |<plug>(vimtex-env-surround-operator)|          "n"
			-- <F6>             |<plug>(vimtex-env-surround-visual)|            "x"
			-- map("nx", "tsd", "<plug>(vimtex-delim-toggle-modifier)", "placeholder")
			-- map("nx", "tsD", "<plug>(vimtex-delim-toggle-modifier-reverse)", "placeholder")
			-- <F7>             |<plug>(vimtex-cmd-create)|                     "nxi"
			-- map("i", "]]", "<plug>(vimtex-delim-close)", "placeholder")
			-- <F8>             |<plug>(vimtex-delim-add-modifiers)|            "n"
			-- map("xo", "ac", "<plug>(vimtex-ac)", "placeholder")
			-- map("xo", "ic", "<plug>(vimtex-ic)", "placeholder")
			-- map("xo", "ad", "<plug>(vimtex-ad)", "placeholder")
			-- map("xo", "id", "<plug>(vimtex-id)", "placeholder")
			-- map("xo", "ae", "<plug>(vimtex-ae)", "placeholder")
			-- map("xo", "ie", "<plug>(vimtex-ie)", "placeholder")
			-- map("xo", "a", "<plug>(vimtex-a$)", "placeholder")
			-- map("xo", "i", "<plug>(vimtex-i$)", "placeholder")
			-- map("xo", "aP", "<plug>(vimtex-aP)", "placeholder")
			-- map("xo", "iP", "<plug>(vimtex-iP)", "placeholder")
			-- map("xo", "am", "<plug>(vimtex-am)", "placeholder")
			-- map("xo", "im", "<plug>(vimtex-im)", "placeholder")
			-- map("nxo", "%", "<plug>(vimtex-%)", "placeholder")
			-- map("nxo", "]]", "<plug>(vimtex-]])", "placeholder")
			-- map("nxo", "][", "<plug>(vimtex-][)", "placeholder")
			-- map("nxo", "[]", "<plug>(vimtex-[])", "placeholder")
			-- map("nxo", "[[", "<plug>(vimtex-[[)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]m)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]M)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[m)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[M)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]n)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]N)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[n)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[N)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]r)", "placeholder")
			-- map("nxo", "]", "<plug>(vimtex-]R)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[r)", "placeholder")
			-- map("nxo", "[", "<plug>(vimtex-[R)", "placeholder")
			-- map("nxo", "]/", "<plug>(vimtex-]/", "placeholder")
			-- map("nxo", "]*", "<plug>(vimtex-]star", "placeholder")
			-- map("nxo", "[/", "<plug>(vimtex-[/", "placeholder")
			-- map("nxo", "[*", "<plug>(vimtex-[star", "placeholder")
			-- map("n", "K", "<plug>(vimtex-doc-package)", "placeholder")
		end,
	},
}

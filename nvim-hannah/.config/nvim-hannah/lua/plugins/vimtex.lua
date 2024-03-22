return {
	{
		"lervag/vimtex",
		enabled = true,
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_quickfix_enabled = 1
			vim.g.vimtex_syntax_enabled = 1
			vim.g.vimtex_quickfix_mode = 0
		end,
		config = function ()
			local map = require("helpers.keys").map
			map("n", "<leader>Ti", "<plug>(vimtex-info)", "VimTeX info")
			map("n", "<leader>TI", "<plug>(vimtex-info-full)", "VimTeX info full")
			map("n", "<leader>Tt", "<plug>(vimtex-toc-open)", "Show table of contents")
			map("n", "<leader>TT", "<plug>(vimtex-toc-toggle)", "Toggle table of contents")
			map("n", "<leader>Tq", "<plug>(vimtex-log)", "Show log")
			map("n", "<leader>Tv", "<plug>(vimtex-view)", "Open pdf viewer")
			map("n", "<leader>Tr", "<plug>(vimtex-reverse-search)", "Reverse search")
			map("n", "<leader>Tl", "<plug>(vimtex-compile)", "Toggle continuous compiler")
			map("n", "<leader>Tk", "<plug>(vimtex-stop)", "Stop continuous compiler")
			map("n", "<leader>TL", "<plug>(vimtex-compile-ss)", "Compile document")
			map("n", "<leader>TK", "<plug>(vimtex-stop-all)", "Stop compilation for all files")
			map("n", "<leader>Te", "<plug>(vimtex-errors)", "Open error window")
			map("n", "<leader>To", "<plug>(vimtex-compile-output)", "Open file where output is directed")
			map("n", "<leader>Tg", "<plug>(vimtex-status)", "Show compilation status")
			map("n", "<leader>TG", "<plug>(vimtex-status-all)", "Show compilation status for all files")
			map("n", "<leader>Tc", "<plug>(vimtex-clean)", "Clean auxillary files")
			map("n", "<leader>TC", "<plug>(vimtex-clean-full)", "Clean all output")
			map("n", "<leader>Tm", "<plug>(vimtex-imaps-list)", "Show insert-mode mappings")
			map("n", "<leader>Tx", "<plug>(vimtex-reload)", "Reload VimTeX")
			map("n", "<leader>TX", "<plug>(vimtex-reload-state)", "Reload current buffer")
			map("n", "<leader>Ts", "<plug>(vimtex-toggle-main)", "Set file as main")
			map("n", "<leader>Ta", "<plug>(vimtex-context-menu)", "Show context menu on item below cursor")
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
		end
	},
}

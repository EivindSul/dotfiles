vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter"
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Update parsers on treesitter plugin update",
	group = vim.api.nvim_create_augroup("treesitter-pack-update", { clear = true }),
	callback = function()
		vim.cmd("TSUpdate<CR>")
	end,
})

local ensureInstalled = {
	"lua",
	"python",
	"go",
	"java",
	"c",
	"bash",
	"markdown",
	"gitcommit",
}

local disabled = {
	"tex",
}

local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall =
	vim.iter(ensureInstalled)
	:filter(
		function(parser)
			return not vim.tbl_contains(alreadyInstalled, parser)
		end
	)
	:totable()

require("nvim-treesitter").install(parsersToInstall)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		if vim.tbl_contains(disabled, ev.match) then
			return
		end

		-- Enable treesitter highlighting and disable regex syntax
		pcall(vim.treesitter.start)
		-- Enable treesitter-based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- Set foldexpression and method using treesitter (from :h nvim-treesitter)
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo.foldmethod = 'expr'
	end,
})

vim.filetype.add({ extension = { corr = "corrlang" } })

local corr_ls_path = vim.env.HOME .. "/projects/corr-ls/corr-ls"

vim.lsp.config("corr-ls", {
	filetypes = { "corrlang" },
	cmd = { corr_ls_path },
})
vim.lsp.enable("corr-ls")

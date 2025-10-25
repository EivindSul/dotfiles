vim.filetype.add({ extension = { corr = "corrlang" } })

local corr_ls_path = vim.env.HOME .. "/projects/corr-ls/corr-ls"

vim.lsp.config("corr-ls", {
	filetypes = { "corrlang" },
	cmd = { corr_ls_path },
})
vim.lsp.enable("corr-ls")

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "corrlang",
-- 	callback = function()
-- 		local client = vim.lsp.start_client({
-- 			name = "corr-ls",
-- 			cmd = { "/Users/eivind/projects/corr-ls/corr-ls" },
-- 		})
--
-- 		if not client then
-- 			vim.notify("No client found")
-- 			return
-- 		end
--
-- 		vim.lsp.buf_attach_client(0, client)
-- 	end,
-- })

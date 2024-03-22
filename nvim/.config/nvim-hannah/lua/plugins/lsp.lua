return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				event = "LspAttach",
			},
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local lsp_map = require("helpers.keys").lsp_map

					lsp_map("<leader>lr", vim.lsp.buf.rename, event.buf, "Rename symbol")
					lsp_map("<leader>la", vim.lsp.buf.code_action, event.buf, "Code action")
					lsp_map("<leader>ld", vim.lsp.buf.type_definition, event.buf, "Type definition")
					lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, event.buf, "Document symbols")

					lsp_map("gd", vim.lsp.buf.definition, event.buf, "Goto Definition")
					lsp_map("gr", require("telescope.builtin").lsp_references, event.buf, "Goto References")
					lsp_map("gI", vim.lsp.buf.implementation, event.buf, "Goto Implementation")
					lsp_map("K", vim.lsp.buf.hover, event.buf, "Hover Documentation")
					lsp_map("gD", vim.lsp.buf.declaration, event.buf, "Goto Declaration")
				end
			})

			require("neodev").setup()
			require("fidget").setup()

			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"pyright",  -- Python
					-- "pylsp",  -- Python
					"hls",    -- Haskell
					"clangd", -- C and C++
					"texlab", -- LaTeX
					-- "bashls", -- Bash REQUIRES NPM
					-- "json-lsp", -- JSON REQUIRES NPM
					"jdtls",  -- Java
					"tsserver",  -- Javascript, typescript
					"eslint",  -- Javascript, typescript
				}
			})

			require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

			local lspconfig = require('lspconfig')
			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('mason-lspconfig').setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			})
		end
	}
}

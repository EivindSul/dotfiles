return {
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "jdtls", "java-debug-adapter", "java-test" } },
		},
		enabled = false,
		-- Config stolen from https://github.com/qmi03/nvim_config/blob/master/lua/plugins/java.lua
		ft = { "java" },
		config = function()
			local mason_registry = require("mason-registry")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			local jdtls_dir = mason_registry.get_package("jdtls"):get_install_path()
			local jdtls_jar = jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar"

			local debugger_dir = mason_registry.get_package("java-debug-adapter"):get_install_path()
			local debugger_jar = debugger_dir .. "/extension/server/*.jar"

			local bundles = {
				vim.fn.glob(debugger_jar),
			}
			vim.list_extend(
				bundles,
				vim.split(
					vim.fn.glob(mason_registry.get_package("java-test"):get_install_path() .. "/extension/server/*.jar"),
					"\n"
				)
			)

			local config = {
				cmd = {
					"java",

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",

					"-jar",
					vim.fn.expand(jdtls_jar),

					"-configuration",
					vim.fn.expand(jdtls_dir .. "/config_linux_arm"),

					"-data",
					vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name,
				},

				root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),

				-- Here you can configure eclipse.jdt.ls specific settings
				-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- for a list of options
				settings = {
					java = {},
				},
				init_options = {
					bundles = bundles,
				},
				capabilities = capabilities,
			}
			require("jdtls").start_or_attach(config)
		end,
	},
}

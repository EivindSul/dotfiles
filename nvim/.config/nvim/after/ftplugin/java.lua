vim.pack.add({
	"https://github.com/mfussenegger/nvim-jdtls",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
vim.cmd("MasonInstall jdtls")
vim.cmd("MasonInstall java-debug-adapter")
vim.cmd("MasonInstall java-test")

local found_jdtls_plugin, _ = pcall(require, "jdtls")
if not found_jdtls_plugin then
	vim.notify("Plugin nvim-jdtls not found!", vim.log.levels.WARN)
	return
end

-- https://github.com/mason-org/mason.nvim/blob/main/CHANGELOG.md#packageget_install_path-has-been-removed
local mason_dir = vim.fn.expand("$MASON")
if mason_dir == "" then
	mason_dir = vim.fn.stdpath("data") .. "/mason"
end
local capabilities = require("blink.cmp").get_lsp_capabilities()
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local jdtls_dir = vim.fn.expand("~/.local/opt/jdtls")
local jdtls_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")

if vim.fn.filereadable(jdtls_jar) ~= 1 then
	vim.notify("jdtls not found at " .. jdtls_jar, vim.log.levels.WARN)
	return
end

local bundles = {}

-- TODO: Fix this check. Maybe wait for nvim 0.12 filesystem tweaks
-- local debugger_bundles = {}
-- for bundle in vim.split(vim.fn.glob(mason_dir .. "/share/java-debug-adapter/*.jar"), "\n") do
-- 	if vim.fn.filereadable(bundle) == 1 then
-- 		table.insert(debugger_bundles, bundle)
-- 	end
-- end
-- vim.list_extend(bundles, debugger_bundles)

-- local test_bundles = {}
-- for bundle in vim.split(vim.fn.glob(mason_dir .. "/share/java-test/*.jar"), "\n") do
-- 	if vim.fn.filereadable(bundle) == 1 then
-- 		table.insert(debugger_bundles, bundle)
-- 	end
-- end
-- vim.list_extend(bundles, test_bundles)

local found_mason, _ = pcall(require, "mason")
if found_mason then
	vim.list_extend(bundles, vim.split(vim.fn.glob(mason_dir .. "/share/java-debug-adapter/*.jar"), "\n"))
	vim.list_extend(bundles, vim.split(vim.fn.glob(mason_dir .. "/share/java-test/*.jar"), "\n"))
else
	vim.notify("Mason not found, skipping jdtls bundle setup", vim.log.levels.INFO)
end

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
		vim.fn.expand(jdtls_dir .. "/config_mac"),

		"-data",
		vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name,
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

vim.keymap.set(
	"n",
	"<leader>lo",
	"<Cmd>lua require'jdtls'.organize_imports()<CR>",
	{ desc = "Organize imports", buffer = true }
)
vim.keymap.set(
	"n",
	"<leader>le",
	"<Cmd>lua require('jdtls').extract_variable()<CR>",
	{ desc = "Extract variable", buffer = true }
)
vim.keymap.set(
	"v",
	"<leader>lE",
	"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Extract variable", buffer = true }
)
vim.keymap.set("n", "<leader>lc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "", buffer = true })
vim.keymap.set(
	"v",
	"<leader>lC",
	"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Extract constant", buffer = true }
)
vim.keymap.set(
	"v",
	"<leader>lm",
	"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
	{ desc = "Extract method", buffer = true }
)

-- " If using nvim-dap
-- " This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
vim.keymap.set("n", "<leader>dc", require("jdtls").test_class, { desc = "Debug: Test nearest class", buffer = true })
vim.keymap.set(
	"n",
	"<leader>dm",
	require("jdtls").test_nearest_method,
	{ desc = "Debug: Test nearest method", buffer = true }
)

--[[
local function install_jdtls()
	vim.notify("Innstallerer jdtls, gi meg to sek her...", vim.log.levels.INFO)

	local datadir = vim.fn.stdpath("data")
	local targetdir = datadir .. "/jdtls"
	local tempdir = targetdir .. ".tmp"

	vim.system({
		"sh",
		"-c",
		table.concat({
			"set -e",
			"mkdir -p " .. tempdir,
			"cd " .. tempdir,
			"curl -L -o jdtls.tar.gz https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.56.0/jdt-language-server-1.56.0-202601291528.tar.gz",
			"tar -xzf jdtls.tar.gz",
		}, " && "),
	}, { text = true }, function(obj)
		if obj.code ~= 0 then
			vim.notify("jdtls install failed", vim.log.levels.ERROR)
			return
		end
	end)

	local deleted = vim.fn.delete(targetdir, "rf")
	if deleted ~= 0 then
		vim.notify("Unable to remove old install dir", vim.log.levels.ERROR)
		return
	end
	local renamed = vim.fn.rename(tempdir, targetdir)
	if renamed ~= 0 then
		vim.notify("Unable to rename jdtls dir, otherwise installation was okay", vim.log.levels.ERROR)
		return
	end

	vim.notify("jdtls installed successfully!", vim.log.levels.INFO)
end

local function verify_jdtls_install()
	local jdtls_dir = vim.fn.stdpath("data") .. "/jdtls"
	local jdtls_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	if vim.fn.filereadable(jdtls_jar) == 1 then
		return true, jdtls_dir, jdtls_jar
	end

	return false
end

-- https://github.com/mason-org/mason.nvim/blob/main/CHANGELOG.md#packageget_install_path-has-been-removed
local mason_dir = vim.fn.expand("$MASON")
if mason_dir == "" then
	mason_dir = vim.fn.stdpath("data") .. "/mason"
end
local capabilities = require("blink.cmp").get_lsp_capabilities()
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- local jdtls_dir = mason_dir .. "/share/jdtls"
-- local jdtls_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")
-- local jdtls_dir = vim.fn.expand("~/.local/opt/jdtls")
-- local jdtls_jar = vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local installed, jdtls_dir, jdtls_jar = verify_jdtls_install()
if not installed then
	local do_install = string.lower(vim.fn.input("jdtls not found. Install? (y/n)"))
	vim.cmd("redraw")
	if do_install == "y" or do_install == "yes" then
		vim.notify("Installing jdtls...", vim.log.levels.INFO)
		install_jdtls()
		installed, jdtls_dir, jdtls_jar = verify_jdtls_install()
		if not installed then
			vim.notify("jdtls install is still not valid. Exiting...", vim.log.levels.WARN)
			return
		end
	else
		vim.notify("Fine then.", vim.log.levels.INFO)
		return
	end
end

if jdtls_dir == nil or jdtls_jar == nil then
	return vim.notify("funker ikke", vim.log.levels.WARN)
end

local bundles = {}

local debugger_bundles = {}
for bundle in vim.split(vim.fn.glob(mason_dir .. "/share/java-debug-adapter/*.jar"), "\n") do
	if vim.fn.filereadable(bundle) == 1 then
		table.insert(debugger_bundles, bundle)
	end
end
vim.list_extend(bundles, debugger_bundles)

local test_bundles = {}
for bundle in vim.split(vim.fn.glob(mason_dir .. "/share/java-test/*.jar"), "\n") do
	if vim.fn.filereadable(bundle) == 1 then
		table.insert(debugger_bundles, bundle)
	end
end
vim.list_extend(bundles, test_bundles)

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
		vim.fn.expand(jdtls_dir .. "/config_mac"),

		"-data",
		vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name,
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
jdtls.start_or_attach(config)
]]

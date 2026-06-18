require("options")
require("keymaps")

-- General plugins
require("plugins.everforest")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.mini")
require("plugins.neotree")
require("plugins.conform")
require("plugins.debug")
require("plugins.dadbod")
require("plugins.sleuth")
require("plugins.vimtex")
require("plugins.plantuml")
require("plugins.folds")

require("custom.init-corr-ls")

-- vim.cmd("colorscheme miniautumn")
--
-- local highlight_groups = {
-- 	"Normal",
-- 	"NormalNC",
-- 	"NormalFloat",
-- 	"FloatBorder",
-- 	"SignColumn",
-- 	"LineNr",
-- 	"FoldColumn",
-- }
--
-- for _, group in ipairs(highlight_groups) do
-- 	vim.api.nvim_set_hl(0, group, { bg = "none" })
-- end

vim.pack.add({ "https://github.com/lervag/vimtex" })

vim.g.vimtex_view_method = "skim"
vim.g.vimtex_quickfix_enabled = 1
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_quickfix_mode = 0

vim.g.vimtex_fold_enabled = 1

--[[
Large documents are slow, likely due to matchparens, which I don't use much.

see:
:help vimtex-faq-slow-matchparen
:help vimtex-af-enhanced-matchparen

-- ]]

vim.g.vimtex_matchparen_enabled = 0
-- vim.g.vimtex_delim_timeout = 10
-- vim.g.vimtex_delim_stopline = 2

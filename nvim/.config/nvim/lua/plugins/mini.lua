--[[
TODO:

mini.operators:
Convert color codes from hex to rgb, rgba

General formatting:
mini.splitjoin
mini.

mini.ai:
Change inner parameters/arguments
change inner function

mini.bufremove
Close other buffers, non-viewed buffers

Plugin development using mini.test?
]]
--
vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require("mini.statusline")
-- set use_icons to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

require("mini.hipatterns").setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})

require("mini.tabline").setup({
	-- Whether to show file icons (requires 'mini.icons')
	show_icons = false,

	-- Function which formats the tab label
	-- By default surrounds with space and possibly prepends with icon
	-- format = nil,
	format = function(buf_id, label)
		local changed = vim.bo[buf_id].modified and "[+]" or ""
		return MiniTabline.default_format(buf_id, label) .. changed
	end,

	-- Whether to set Vim's settings for tabline (make it always shown and
	-- allow hidden buffers)
	set_vim_settings = true,

	-- Where to show tabpage section in case of multiple vim tabpages.
	-- One of 'left', 'right', 'none'.
	tabpage_section = "right",
})

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- `z` key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

local pick = require("mini.pick")
require("mini.extra").setup()
pick.setup()
local builtin = pick.builtin

vim.keymap.set("n", "<leader>sh", builtin.help, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.grep_live, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sd", MiniExtra.pickers.diagnostic, { desc = "[S]earch [D]iagnostics" })

local BufRemove = require("mini.bufremove")
BufRemove.setup()


vim.keymap.set("n", "<leader>bd", function() BufRemove.delete(0, false) end, { desc = "[D]elete current buffer" })
vim.keymap.set("n", "<leader>bD", function() BufRemove.delete(0, true) end, { desc = "force [D]elete current buffer" })
vim.keymap.set("n", "<leader>bo", function()
	local current = vim.api.nvim_get_current_buf()
	local bufs = vim.api.nvim_list_bufs()
	for _, buf in ipairs(bufs) do
		if vim.api.nvim_buf_is_loaded(buf) then
			if buf ~= current then
				BufRemove.delete(buf, false)
			end
		end
	end
end, { desc = "Delete [O]ther buffers" })
vim.keymap.set("n", "<leader>bp", function() end, { desc = "[P]ick buffers to delete" })

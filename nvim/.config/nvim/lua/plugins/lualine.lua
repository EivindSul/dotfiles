-- Fancier statusline
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"justinhj/battery.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		local colorscheme = require("helpers.colorscheme")
		local lualine_theme = colorscheme == "default" and "auto" or colorscheme

		require("battery").setup({
			show_plugged_icon = false,
			show_unplugged_icon = false,
		})
		local batteryIndicator = {
		function()
				return require("battery").get_status_line(
				)
			end,
		}

		require("lualine").setup{
			options = {
				icons_enabled = true,
				theme = lualine_theme,
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			-- sections = { lualine_a = battery },
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {batteryIndicator, 'fileformat', 'filetype'},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	end,
}

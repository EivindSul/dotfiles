return {
	'nanozuki/tabby.nvim',
	enabled = false,
	config =  function()
		local theme = {
			fill = 'TabLineFill',
			current_tab = 'TabLineSel',
			head = 'TabLine',
			tab = 'TabLine',
			win = 'TabLine',
			tail = 'TabLine',
		}

		require('tabby.tabline').set(function(line)
			return {
				-- shows list of tabs
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep(' ', theme.fill, hl),
						tab.name(),
						line.sep(' ', theme.fill, hl),
						hl = hl,
						margin = ' ',
					}
				end),
				line.spacer(),
				-- shows list of windows in tab
				-- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
				--   return {
				-- 	line.sep(' ', theme.fill, theme.win),
				--     win.is_current() and 'O' or 'o',
				--     win.buf_name(),
				--     line.sep(' ', theme.fill, theme.win),
				--     hl = theme.win,
				--     margin = ' ',
				--   }
				-- end),
				hl = theme.fill,
			}
		end)
	end
}

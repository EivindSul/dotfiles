-- bold og italic med ctrl+b og ctrl+i
-- create surrounding environment
-- create surrounding command 
-- \\ with shift+enter
-- \\ på slutten av linjen med ctrl+o og ctrl+O

function map (mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

function unmap (mode, lhs)
	vim.keymap.del(mode, lhs)
end
-- Hei Hannah elsker deg!
-- Add bold or italic text through Ctrl+b and Ctrl+i
map("n", "<C-b>", "i\\textbf{}<esc>", "Insert bold text environment")
map("n", "<C-i>", "i\\textit{}<esc>", "Insert italic text environment")

-- Add bold or italic environment around currently selected text. Does not work in visual line mode
map("x", "<C-b>", "c\\textbf{}<esc>P", "Insert bold text environment")
map("x", "<C-i>", "c\\textit{}<esc>P", "Insert italic text environment")

-- unmap("nv", "<tab>")

-- Add selected items to itemize list
-- map("x", "<C-i>", "di\\begin{itemize}<cr>\\end{itemize}<cr><esc>kP", "Add lines to itemize environment")


-- add surrounding environment/command
-- map("x", "mse", "", "Add surrounding environment")
-- map("x", "msc", "", "Add surrounding command")

vim.pack.add({ "https://github.com/charlesnicholson/plantuml.nvim" })

vim.filetype.add({ extension = { puml = "puml" } })

require("plantuml").setup({ auto_start = false, })

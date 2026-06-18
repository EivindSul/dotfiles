vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    tex = { "latexindent" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters = {
    latexindent = {
      args = { "-l", vim.fn.expand("~/.config/nvim/latexindent.yaml"), "-" },
    },
  },
})

vim.keymap.set(
  "n",
  "<leader>f",
  function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end,
  { desc = "[F]ormat buffer" }
)

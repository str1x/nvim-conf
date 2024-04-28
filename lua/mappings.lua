require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("i", "<C-z>", "<BS>", { noremap = true })
map("i", "<C-x>", "<Del>", { noremap = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local isLspDiagnosticsVisible = vim.diagnostic.virtual_text
vim.keymap.set("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
  }
end, { desc = "hide diagnostic text" })

vim.keymap.set(
  "n",
  "<C-d>",
  "<cmd>lua require('neoscroll').scroll(vim.wo.scroll, 'true', '50')<cr>",
  { remap = true, noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<C-u>",
  "<cmd>lua require('neoscroll').scroll(-vim.wo.scroll, 'true', '50')<cr>",
  { remap = true, noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>rd", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
vim.keymap.set("n", "<leader>rD", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })

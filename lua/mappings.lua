require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("i","<C-z>", "<BS>", { noremap = true })
map("i", "<C-x>", "<Del>", { noremap = true })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local isLspDiagnosticsVisible = vim.diagnostic.virtual_text
vim.keymap.set(
  "n",
  "<leader>lx",
  function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
    })
  end,
  { desc = "hide diagnostic text" }
)

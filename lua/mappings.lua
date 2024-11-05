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
map("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
  }
end, { desc = "hide diagnostic text" })

map(
  "n",
  "<C-d>",
  "<cmd>lua require('neoscroll').scroll(vim.wo.scroll, { duration = 50 })<cr>",
  { remap = true, noremap = true, silent = true }
)
map(
  "n",
  "<C-u>",
  "<cmd>lua require('neoscroll').scroll(-vim.wo.scroll, { duration = 50 })<cr>",
  { remap = true, noremap = true, silent = true }
)
map(
  "n",
  "<leader>lf",
  function()
    vim.diagnostic.open_float { border = "rounded" }
  end,
  { remap = true, noremap = true, silent = true, desc = "Floating diagnostic" }
)

map("n", "<leader>rd", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>rD", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local tb = require('telescope.builtin')
map(
  'v',
  '<space>fz',
  function()
    local text = vim.getVisualSelection()
    tb.current_buffer_fuzzy_find({ default_text = text })
  end,
  { noremap = true, silent = true, desc = "find selected in buffer"}
)
map(
  'v',
  '<space>fw',
  function()
    local text = vim.getVisualSelection()
    tb.live_grep({ default_text = text })
  end,
  { noremap = true, silent = true, desc = "live grep selected"}
)


map("n", "<leader>gb", "<cmd>Gitsigns blame_line <CR>", { desc = "git blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns blame <CR>", { desc = "git blame" })

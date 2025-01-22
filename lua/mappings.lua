local utils = require "utils"
local map = vim.keymap.set
local telescope = require "telescope.builtin"
local conform = require "conform"
local tabufine = require "nvchad.tabufline"
local nvchadThemes = require "nvchad.themes"
local nvchadTerm = require "nvchad.term"
--- input navigation
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
-- switch window
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
-- general
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>zm", utils.toggleZenMode, { desc = "Toggle zen mode" })
-- relative numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
-- format
map("n", "<leader>fm", function() conform.format({ lsp_fallback = true }) end, { desc = "general format file" })
-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", tabufine.next, { desc = "buffer goto next" })
map("n", "<S-tab>", tabufine.prev, { desc = "buffer goto prev" })
map("n", "<leader>x", tabufine.close_buffer, { desc = "buffer close" })
-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
-- terminals
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>h", function() nvchadTerm.new({ pos = "sp" }) end, { desc = "terminal new horizontal term" })
map("n", "<leader>v", function() nvchadTerm.new({ pos = "vsp" }) end, { desc = "terminal new vertical term" })
-- toggleable
map({ "n", "t" }, "<A-v>", function() nvchadTerm.toggle({ pos = "vsp", id = "vtoggleTerm" }) end, { desc = "terminal toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function() nvchadTerm.toggle({ pos = "sp", id = "htoggleTerm" }) end, { desc = "terminal toggleable horizontal term" })
map({ "n", "t" }, "<A-i>", function() nvchadTerm.toggle({ pos = "float", id = "floatTerm" }) end, { desc = "terminal toggle floating term" })
-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function() vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ") end, { desc = "whichkey query lookup" })
-- scroll
map("n", "<C-d>", function()
  utils.scroll(20, 150)
end, { desc = "scroll up" })
map("n", "<C-u>", function()
  utils.scroll(-20, 150)
end, { desc = "scroll down" })
-- dap
map("n", "<leader>rd", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>rD", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
-- git
map("n", "<leader>gb", "<cmd>Gitsigns blame_line <CR>", { desc = "git blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns blame <CR>", { desc = "git blame" })
-- lsp go to
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Go to declaration" })
map("n", "gd", function()
  telescope.lsp_definitions({ initial_mode = "normal" })
end, { desc = "LSP Go to definition" })
map("n", "gi", function()
  telescope.lsp_implementations({ initial_mode = "normal" })
end, { desc = "LSP Go to implementation" })
map("n", "gr", function()
  telescope.lsp_references({ initial_mode = "normal" })
end, { desc = "LSP Show references" })
map("n", "gt", function()
  telescope.lsp_type_definitions({ initial_mode = "normal" })
end, { desc = "LSP Go to type definition" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP Show signature help" })
-- lsp workspaces
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "LSP Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP Remove workspace folder" })
map("n", "<leader>wl", utils.printLSPWorkspaces, { desc = "LSP List workspace folders" })
-- lsp refactoring and other
map("n", "<leader>lr", require "nvchad.lsp.renamer", { desc = "LSP NvRenamer" })
map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code action" })
map("n", "<leader>lo", function()
  telescope.lsp_outgoing_calls({ initial_mode = "normal" })
end, { desc = "LSP list outgoing calls" })
map("n", "<leader>li", function()
  telescope.lsp_incoming_calls({ initial_mode = "normal" })
end, { desc = "LSP list incoming calls" })
map("n", "<leader>ls", function()
  telescope.lsp_workspace_symbols({ initial_mode = "normal" })
end, { desc = "LSP list workspace symbols" })
map("n", "<leader>lS", function()
  telescope.lsp_document_symbols({ initial_mode = "normal" })
end, { desc = "LSP list current buffer symbols" })
-- diagnostic
map("n", "<leader>lx", utils.toggleDiagnosticsVisible, { desc = "Toggle diagnostic text" })
map("n", "<leader>lf", utils.showDiagnosticHover, { desc = "Show diagnostic hover" })
map("n", "<leader>ld", function()
  telescope.diagnostics({ initial_mode = "normal" })
end, { desc = "LSP list all buffers diagnostic" })
map("n", "<leader>lD", function()
  telescope.diagnostics({ initial_mode = "normal", bufnr=0 })
end, { desc = "LSP list current buffer diagnostic" })
-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", nvchadThemes.open, { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "telescope find all files" })
map("v", "<space>fz", function()
  local text = utils.getVisualSelection()
  telescope.current_buffer_fuzzy_find({ default_text = text, initial_mode = "normal" })
end, { desc = "find selected in buffer" })
map("v", "<space>fw", function()
  local text = utils.getVisualSelection()
  telescope.live_grep({ default_text = text, initial_mode = "normal" })
end, { desc = "live grep selected" })

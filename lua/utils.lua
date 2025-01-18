local telescope = require('telescope.builtin')
local neoscroll = require('neoscroll')
local M = {}

local getVisualSelection = function()
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

local isLspDiagnosticsVisible = vim.diagnostic.virtual_text

M.findSelectedInBuffer = function()
  local text = getVisualSelection()
  telescope.current_buffer_fuzzy_find({ default_text = text })
end

M.grepSelected = function()
  local text = getVisualSelection()
  telescope.live_grep({ default_text = text })
end

M.toggleDiagnosticsVisible = function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config({
    virtual_text = isLspDiagnosticsVisible,
  })
end

M.showDiagnosticHover = function()
  vim.diagnostic.open_float { border = "rounded" }
end

M.printLSPWorkspaces = function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

--- scroll
---@param scroll number
---@param duration number
M.scrollHandler = function(scroll, duration)
  return function()
    neoscroll.scroll(scroll, { duration = duration })
  end
end

return M;

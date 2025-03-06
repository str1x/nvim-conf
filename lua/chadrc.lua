-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "everforest",
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
  theme_toggle = { "everforest", "penumbra_light" },
  transparency = false,
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
}

M.ui = {
  telescope = {
    style = "bordered"
  },
  statusline = {
    theme = "default",
    separator_style = "block",
    order = { "mode", "keyboard_layout", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      keyboard_layout = function()
        local icon = "󰌌"
        local text = string.upper(require("keymap-switch").provider());
        local hi_group = require("keymap-switch").condition() and 'St_cwd_icon' or 'St_InsertMode'
        return "%#" .. hi_group .. "# " .. icon .. " " .. text .. " "
      end,
    },
  },
}

return M

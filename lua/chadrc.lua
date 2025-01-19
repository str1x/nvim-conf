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
    style = 'bordered'
  }
}

return M

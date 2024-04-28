-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "everforest_light",
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- }, 
  theme_toggle = { "everforest", "everforest_light" },
  telescope = { style = "bordered" },
  transparency = false,
  statusline = {
    theme = "default",
    separator_style = "arrow",
  },
}

return M

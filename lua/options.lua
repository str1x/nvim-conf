require "nvchad.options"

local vim = vim
local opt = vim.opt
-- local o = vim.o

vim.o.cursorlineopt = "number,line"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.relativenumber = true
opt.termguicolors = true -- True color support
opt.autoindent = true    --- Good auto indent
opt.colorcolumn = { 120 }

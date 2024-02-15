-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.list = false -- don't show dashes for whitespaces/tabs

-- Tabs, Indent
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- formatting
vim.g.autoformat = false

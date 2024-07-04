local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- g.mapleader = ","
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true
opt.number = true
opt.wrap = false
opt.fileencoding = "utf-8"
opt.mouse = "a"
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.backup = false
opt.writebackup = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"
opt.signcolumn = "number"
opt.cursorline = false
opt.relativenumber = true
opt.background = "dark"
opt.showmode = false

-- Optimizations
opt.hidden = true   -- enable background buffers
opt.history = 100   -- remember n lines in history
-- opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-- Set completeopt to have a better completion experience
opt.completeopt = "menu,menuone,noselect"

-- Return to last edit position when opening files
cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- treat mjml files as html
cmd([[au BufRead,BufNewFile *.mjml setlocal ft=html]])

-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

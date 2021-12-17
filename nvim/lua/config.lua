vim.g.mapleader = ','

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.fileencoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'number'
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.background = 'dark'
vim.opt.showmode = false

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Return to last edit position when opening files
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- treat mjml files as html
vim.cmd([[
au BufRead,BufNewFile *.mjml setlocal ft=html
]])

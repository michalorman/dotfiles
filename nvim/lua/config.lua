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

-- Return to last edit position when opening files
vim.cmd([[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- treat mjml files as html
vim.cmd([[
au BufRead,BufNewFile *.mjml setlocal ft=html
]])

-- ----------------
-- Packer

-- Automatically execute PackerCompile whenever plugins.lua gets updated
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

-- ----------------
-- coc

vim.g.coc_global_extensions = {
  'coc-pairs', 'coc-tsserver', 'coc-eslint', 'coc-json', 'coc-vimlsp', 'coc-tailwindcss',
  'coc-html', 'coc-explorer', 'coc-yaml', 'coc-vetur', 'coc-css', 'coc-svg', 'coc-rls',
}

vim.cmd 'source ~/.config/nvim/vimscript/coc.vim'

-- ----------------
-- lightline

vim.g.lightline = {
  colorscheme = 'tokyonight'
}

-- ----------------
-- quick-scope

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

-- ----------------
-- Prettier

vim.cmd([[
au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.md,*.vue PrettierAsync
]])

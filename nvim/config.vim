set number
set termguicolors
set t_Co=256
set nowrap
set fileencoding=utf-8
set mouse=a
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=500
set clipboard=unnamedplus
set lazyredraw
set noshowmode
set background=dark
set signcolumn=number
set shortmess+=c
set cursorline

colorscheme OceanicNext

let mapleader = ","
let maplocalleader = ","

nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>a :Ag<CR>

inoremap jk <Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap H ^
nnoremap L $

nmap <leader>.  <Plug>(coc-codeaction)
nmap <leader>p :Prettier<CR>
nmap <leader>c :Git<cr>
nmap <leader>R :CocCommand workspace.renameCurrentFile<cr>

" Fast saving
nmap <leader>w :w!<cr>

map <silent> <leader><cr> :noh<cr>
nmap <silent> <leader>n :noh<cr>

nmap <silent> <leader>s :source $MYVIMRC<cr>
nmap <silent> <leader>v :tabe $MYVIMRC<cr>
nmap <silent> <leader>d :e %:h<cr>

nmap <silent> <leader>t :tabnew <bar> :term<cr>

" Directory of current file.
cnoremap %% <C-R>=expand("%:h")."/"<CR>

au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.gql,*.md,*.vue PrettierAsync

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ %l:%c

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

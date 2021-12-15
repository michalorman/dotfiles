call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
	let g:oceanic_next_terminal_bold = 1
	let g:oceanic_next_terminal_italic = 1
Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  let g:tokyonight_style = "night"

" Statusline
" Plug 'nvim-lualine/lualine.nvim'
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
  let g:lightline = {'colorscheme': 'tokyonight'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier'
Plug 'jparise/vim-graphql'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim'
Plug 'unblevable/quick-scope'
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
Plug 'dag/vim-fish'

call plug#end()

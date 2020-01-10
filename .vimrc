"" General
set termguicolors
set nocompatible



"" Vim-Plug Configuration
call plug#begin('~/.vim/plugged')

"" Utilities

" NerdTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
map <C-n> :NERDTreeToggle<CR>

" Auto Pair
" Plug 'jiangmiao/auto-pairs'

" Vim Surround 
Plug 'tpope/vim-surround'

" CtrlP
" Plug 'ctrlpvim/ctrlp.vim' 
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_custom_ignore = 'node_modules\|git'

" RipGrep Support
Plug 'jremmen/vim-ripgrep'

" FZF Vim Support
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :FZF<CR>

" Vim Easy Align
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Lightline
Plug 'itchyny/lightline.vim'
set noshowmode
" let g:lightline = {
" 	\ 'colorscheme': 'wombat',
" 	\ 'active': {
" 	\   'left': [ [ 'mode', 'paste' ],
" 	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
" 	\ },
" 	\ 'component_function': {
" 	\   'cocstatus': 'coc#status'
" 	\ },
" 	\ }


"" Language Support
" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['python', 'typescript']
" let g:rustfmt_autosave = 1

" Plug 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }

Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
let g:coc_force_debug = 1
" function! s:check_back_space() abort
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1] =~'\s'
" endfunction
" 
" inoremap <silent><expr> <TAB>
" 	\ pumvisible() ? "\<C-n>" :
" 	\ <SID>check_back_space() ? "\<TAB>" :
" 	\ coc#refresh()
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" JavaScript Support
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'

" TypeScript Support
Plug 'HerringtonDarkholme/yats.vim'

" Golang Support
Plug 'fatih/vim-go'
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

" Rust Support
" Plug 'rust-lang/rust.vim' 
" let g:rustfmt_autosave = 1

" Emmet Support
Plug 'mattn/emmet-vim', " { 'for': ['html', 'css'] }
let g:user_emmet_mode = 'a'

"" Themes
" Plug 'tomasiser/vim-code-dark' 
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'cocopon/iceberg.vim'
Plug 'mhartington/oceanic-next'

call plug#end()

" Syntax Highlighting
syntax on

" Enable filetype plugins
filetype off
filetype plugin indent on

"" Color Scheme 
" colorscheme codedark
" colorscheme dracula
colorscheme OceanicNext
set guicursor=

" set number
set relativenumber
set linebreak
set showmatch

set smartcase
set ignorecase
set hlsearch
set incsearch

set autoindent
set smartindent
set cinoptions=l1

set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set noexpandtab


"" Advanced
" set splitbelow
set ruler
set lazyredraw

" Use undofile
" set undodir=~/.vim/undodir
set undofile


" show a visual line under the cursor's current line
set cursorline

" enable all Python syntax highlighting features
let python_highlight_all=1

"" Key Mapping
" For Saving
map <C-s> :w<CR>


" Tabs
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

"" Coc.nvim Configuration
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :call CocActionAsync('jumpDefinition', 'tab drop')<cr>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> K :call CocActionAsync('doHover')<cr>

" coc-prettier settings to add :Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

set updatetime=300


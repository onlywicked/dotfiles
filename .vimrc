"" General
set termguicolors
set nocompatible

"" Allow to switch buffer without saving
set hidden

"" Mapping leader to space
let mapleader = ' '


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

" Vim Multiple Cursor
" Plug 'terryma/vim-multiple-cursors'

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


" Plug 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" let g:coc_force_debug = 1
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~'\s'
endfunction
 
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Mapping <Leader>{j,k} for error jumping
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev-error)


" inoremap <silent><expr> <TAB>
" 	\ pumvisible() ? "\<C-n>" :
" 	\ <SID>check_back_space() ? "\<TAB>" :
" 	\ coc#refresh()


"" Deoplete
" if has('nvim')
" 	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
" 	Plug 'Shougo/deoplete.nvim'
" 	Plug 'roxma/nvim-yarp'
" 	Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" JavaScript Support
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'

" TypeScript Support
Plug 'HerringtonDarkholme/yats.vim'

" Golang Support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" vim-go coc.nvim settings
"" disable settings conflicting with coc-go
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0

"" vim-go highlight settings
" let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 0
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
" let g:go_auto_sameids = 0

"" vim-go other settings
let g:go_fmt_command = "goimports"

" Rust Support
" Plug 'rust-lang/rust.vim' 
" let g:rustfmt_autosave = 1

" Emmet Support
Plug 'mattn/emmet-vim', " { 'for': ['html', 'css'] }
let g:user_emmet_mode = 'a'


"" Language Support
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['python']
" let g:rustfmt_autosave = 1


"" Themes
" Plug 'tomasiser/vim-code-dark' 
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'cocopon/iceberg.vim'
" Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
" Plug 'onlywicked/oceanic-next', { 'branch': 'feature/dark-theme' }
call plug#end()

" Syntax Highlighting
syntax on

" Enable filetype plugins
filetype off
filetype plugin indent on

"" Color Scheme 
" colorscheme codedark
" colorscheme dracula
" colorscheme OceanicNextDark
colorscheme gruvbox
set guicursor=

set wildmenu
set path+=** " Set path to current directory

"" netrw settings
let g:netrw_banner=0 " Disable netrw banner
let g:netrw_liststyle=3 " Tree style

" set number
" set number 
set relativenumber
set linebreak
set showmatch
set nowrap

set smartcase
set ignorecase
" set hlsearch
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
set undodir=~/.vim/undodir
set undofile
" set noswapfile


" show a visual line under the cursor's current line
set cursorline

" show a vertical line under the cursor's current line
set cursorcolumn

" enable all Python syntax highlighting features
let python_highlight_all=1

"" Key Mapping

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

set mouse=a

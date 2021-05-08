"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" General
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set nocompatible
filetype off


"" Mapping leader to space
let mapleader = ' '

"" Clipboard
" set clipboard=unamedplus




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Vim-Plug Configuration
call plug#begin('~/.vim/plugged')

"" Utilities

" NerdTree
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" map <C-n> :NERDTreeToggle<CR>

" Auto Pair
" Plug 'jiangmiao/auto-pairs'

" Vim Surround 
Plug 'tpope/vim-surround'

" RipGrep
Plug 'jremmen/vim-ripgrep'

" FZF Vim Support
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>

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


" Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
let g:coc_global_extensions = [
			\ 'coc-snippets',
			\	'coc-json',
			\ 'coc-css',
			\ 'coc-html',
			\ 'coc-tsserver',
			\ 'coc-prettier',
			\ ]

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Mapping <Leader>{j,k} for error jumping
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev-error)
" nmap <silent> gd :call CocActionAsync('jumpDefinition', 'tab drop')<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Use K to show documentation in preview window.
" nmap <silent> K :call CocActionAsync('doHover')<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" inoremap <silent><expr> <TAB>
" 	\ pumvisible() ? "\<C-n>" :
" 	\ <SID>check_back_space() ? "\<TAB>" :
" 	\ coc#refresh()

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Vim Commentary
Plug 'tpope/vim-commentary'

" Vim Snippets
Plug 'honza/vim-snippets'


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
" let g:go_doc_window_popup_window = 1
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
let g:rustfmt_autosave = 1

"" Firestore support
Plug 'delphinus/vim-firestore'


"" Themes
" Plug 'tomasiser/vim-code-dark' 
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'cocopon/iceberg.vim'
" Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
" Plug 'onlywicked/oceanic-next', { 'branch': 'feature/dark-theme' }

call plug#end()




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax Highlighting, Numbers, Linebreaks
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax Highlighting
syntax enable
" Enable filetype plugins
filetype plugin indent on

set number relativenumber
set linebreak
set showmatch
set nowrap




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Color Scheme 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme codedark
colorscheme dracula
" colorscheme gruvbox
" colorscheme OceanicNextDark
set guicursor=




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Buffer, Args
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Allow to switch buffer without saving
set hidden

set wildignorecase
set wildmenu

" ignore these directories from find
set wildignore+=**/node_modules/**,**/dist/**,**/tmp/**,**/target/**

" Set path to current directory and current buffer
set path=.,**





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Netrw Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:netrw_banner=0 " Disable netrw banner
let g:netrw_liststyle=3 " Tree style








"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Search Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set smartcase
set ignorecase
set hlsearch
set incsearch





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Indentation Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set cinoptions=l1

set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set noexpandtab




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Additional Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set splitbelow
set ruler

set lazyredraw
set updatetime=300

" Enable mouse support
set mouse=a

" Use undofile
set undofile
set undodir=~/.vim/undodir
set noswapfile

" show column marker
" set colorcolumn=80

" show a visual line under the cursor's current line
set cursorline

" show a vertical line under the cursor's current line
" set cursorcolumn

" enable all Python syntax highlighting features
let python_highlight_all=1





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Key Mapping
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Command Mapping
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add `:Prettier` command to run prettier on current file
" Note: Requires `coc-prettier`
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add `:Eslint` command to execute eslint autofix on current file
" Note: Requires `coc-eslint`
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:Ogranize` command for organize imports of the current buffer.
command! -nargs=0 Organize :call CocAction('runCommand', 'editor.action.organizeImport')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Custom Variables
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $MYVIMRC = '~/.vimrc'

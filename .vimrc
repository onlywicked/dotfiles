"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" General
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set nocompatible
filetype off


"" Mapping leader to space
let mapleader = "\<space>"

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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
map <C-n> :NERDTreeToggle<CR>

" Auto Pair
" Plug 'jiangmiao/auto-pairs'

" Vim Surround 
Plug 'tpope/vim-surround'

" RipGrep
Plug 'jremmen/vim-ripgrep'
nnoremap <Leader>rg :Rg 

" FZF Vim Support
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :Files<CR>
nnoremap <M-p> :Buffers<CR>

" Vim Easy Align
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Vim Multiple Cursor
" Plug 'terryma/vim-multiple-cursors'

" Lightline
Plug 'itchyny/lightline.vim'
set noshowmode


" Plug 'neoclide/coc.nvim', { 'do': { -> coc#util#install() } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'
let g:coc_global_extensions = [
			\ 'coc-tsserver',
			\ 'coc-snippets',
			\ 'coc-prettier',
			\ 'coc-marketplace',
			\	'coc-json',
			\ 'coc-html',
			\ 'coc-css',
			\ 'coc-go',
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
nmap <silent> gI <Plug>(coc-implementation)

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Use K to show documentation in preview window.
" nmap <silent> K :call CocActionAsync('doHover')<cr>
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Format the select line of code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" inoremap <silent><expr> <TAB>
" 	\ pumvisible() ? "\<C-n>" :
" 	\ <SID>check_back_space() ? "\<TAB>" :
" 	\ coc#refresh()

" inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
" Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }

"" vim-go coc.nvim settings
"" disable settings conflicting with coc-go
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_gopls_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_fmt_autosave = 0
let g:go_disable_autoinstall = 1

"" vim-go highlight settings
" let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_metalinter_command = 'golangci-lint'
" let g:go_doc_window_popup_window = 1
" let g:go_auto_sameids = 0

"" vim-go other settings
" let g:go_fmt_command = 'goimports'

" Rust Support
" Plug 'rust-lang/rust.vim' 
" let g:rustfmt_autosave = 1

" Emmet Support
Plug 'mattn/emmet-vim', " { 'for': ['html', 'css'] }
let g:user_emmet_mode = 'a'


"" Language Support
" Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['python']
" let g:rustfmt_autosave = 1

"" Firestore support
" Plug 'delphinus/vim-firestore'


"" Themes
Plug 'tomasiser/vim-code-dark' 
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'cocopon/iceberg.vim'
" Plug 'mhartington/oceanic-next'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rose-pine/vim', { 'as': 'rose-pine' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
"let g:lightline = {'colorscheme': 'catppuccin_mocha'}


Plug 'morhetz/gruvbox'
Plug 'wojciechkepka/vim-github-dark'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'arcticicestudio/nord-vim'
Plug 'onlywicked/oceanic-next', { 'branch': 'feature/dark-theme' }
Plug 'haishanh/night-owl.vim'


Plug 'nicwest/vim-http'

Plug 'vimwiki/vimwiki'
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
			\	'path': '~/code/notes', 'path_html': '~/code/notes_html',
			\ 'syntax': 'markdown', 'ext': '.md', 'auto_toc': 1
			\ }]
let g:vimwiki_links_space_char = '_'

Plug 'github/copilot.vim'
imap <silent><script><expr> <C-k> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Plug 'zbirenbaum/copilot.lua'

Plug 'tpope/vim-fugitive'

Plug 'prisma/vim-prisma'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Plug 'huggingface/hfcc.nvim'


call plug#end()




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax Highlighting, Numbers, Linebreaks
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax Highlighting
" syntax enable
" Enable filetype plugins
" filetype plugin indent on

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

let s:base = "#0F1419"
let s:text = "#CDD6F4"

function! s:hi(group, guisp, guifg, guibg, gui, cterm)
  let cmd = ""
  if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
  endif
  if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
  endif
  if a:gui != ""
    let cmd = cmd . " gui=" . a:gui
  endif
  if a:cterm != ""
    let cmd = cmd . " cterm=" . a:cterm
  endif
  if cmd != ""
    exec "hi " . a:group . cmd
  endif
endfunction

call s:hi("Normal", "NONE", s:text, s:base, "NONE", "NONE")


" colorscheme gruvbox
" colorscheme OceanicNextDark
" colorscheme gruvbox-material
" colorscheme ghdark
" colorscheme ayu

" colorscheme onehalfdark
" let g:lightline = {
" 	\ 'colorscheme': 'onehalfdark',
" 	\ 'active': {
" 	\   'left': [ [ 'mode', 'paste' ],
" 	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
" 	\ },
" 	\ 'component_function': {
" 	\   'cocstatus': 'coc#status'
" 	\ },
" 	\ }
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

let g:netrw_banner = 0 " Disable netrw banner
let g:netrw_liststyle = 3 " Tree style
let g:netrw_localrmdir = 'rm -rf'
" let g:netrw_browse_split = 1 " Open files in a new horizontal split 







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
set expandtab




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
set colorcolumn=80
" highlight ColorColumn ctermbg=238 guibg=#424450

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

"" Moving multiple lines and preserving indentation
" Respectfully, *cough* *cough* copied from Ryan Florence
" https://gist.github.com/ryanflorence/6d92b7495873263aec0b4e3c299b3bd3
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tree Sitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF

-- local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "vimdoc", "c", "lua", "vim", "vimdoc", "query", 
    "typescript", "tsx", "javascript",
    "go", "gomod", "gosum", "gotmpl",
    "diff",
    "sql",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "markdown" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },


	-- parser_config.gotmpl = {
	-- 	install_info = {
	-- 		url = "https://github.com/ngalaiko/tree-sitter-go-template",
	-- 		files = {"src/parser.c"}
	-- 	},
	-- 	filetype = "gotmpl",
	-- 	used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
	-- }
}
EOF

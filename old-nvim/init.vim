" vim:foldmethod=marker

" bare essentials {{{
" nvim default
" not vi compatible
" set nocompatible

" less swap file clutter
" set directory^=$HOME/.vim/tmp//
set noswapfile

" nvim invalid
" set noesckeys " single esc key immediately works in insert mode

inoremap kj <Esc>

" }}}

" vim-plug {{{

call plug#begin('~/.config/nvim/plugged')

if !exists('g:vscode')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'raimondi/delimitmate'
    Plug 'tpope/vim-fugitive'
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }

    Plug 'pangloss/vim-javascript', { 'if': 'javascript' }
    Plug 'leafgarland/typescript-vim', { 'if': 'typescript' }
    Plug 'hashivim/vim-terraform', { 'if': 'terraform' }
    Plug 'ignatov/kotlin-vim', { 'if': 'kotlin' }
    Plug 'neovimhaskell/haskell-vim', { 'if': 'haskell' }
    Plug 'jparise/vim-graphql', { 'if': 'graphql' }
    Plug 'maxmellon/vim-jsx-pretty', { 'if': 'javascriptreact' }
    Plug 'maxmellon/vim-jsx-pretty', { 'if': 'typescriptreact' }

    call plug#end()
else
    " using vscode nvim extension, don't load plugins
endif

" }}}

" leader key remappings {{{

" unbind space to avoid conflicts
nnoremap <Space> <NOP> 
let mapleader="\<Space>"
let maplocalleader=","

nnoremap <Leader>w :wa<CR>
nnoremap <Leader>q :wqa<CR>

nnoremap <Leader>o :on<CR>

" copy and paste to system clipboard
" TODO: check copy / paste performace and decide if needed
" DONE: no longer needed
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+b
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <Leader><Leader> V

" leader key + fzf
" TODO: bring across if needed with fzf
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>

" }}}

" syntax and indent {{{

syntax on
set showmatch " show matching braces when text indicator is over them

" for indentation without tabs, as per vim wiki
set expandtab
set shiftwidth=4
set softtabstop=4

" override per file type
autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sw=2 expandtab

" coc syntax extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-json']

" conditionally use prettier & eslint
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" nvim default
" set autoindent " carry indentation level to next new line

" }}}

" appearance {{{

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" enable italics
let g:dracula_italic = 1

" Must have run PlugInstall before setting colour schemes
" autocmd ... ensures other plugins load OK first
autocmd vimenter * ++nested colorscheme dracula

set shortmess+=i " disable vim startup message
set number " show line numbers
set relativenumber " line numbers relative to position
set laststatus=2 " always show status bar
set hidden " can hide an unsaved buffer
set scrolloff=5 " show lines above and below cursor when possible

:command H set invcursorline

" remove filler in vertical split divider
" PORT TODO
:set fillchars+=vert:\ 

" fix bad background colour on floating windows
" hi Pmenu ctermbg=244

" }}}

" search {{{

set ignorecase " case insensitive search with lower case query
set smartcase " case sensitive search with upper/mix case entry
" nvim default
" set incsearch " search as you type
set hlsearch " highlight search

" use :C to clear search highlighting
:command C let @/=""

" TODO: replace usage of these with use of substitute command
" replace in visual block
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" better search and replace
" search with /<search term>
" cs to change selection, then hit esc
" n.n.n.n. to review and replace
" credit to https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
\:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>


" }}}

" navigation {{{

set mouse+=a " enable mouse support
" nvim default
" set backspace=indent,eol,start " allow backspace over anything

" PORT TODO
" line numbering tied to modes
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" }}}

" file access / management {{{

filetype plugin on " turns on built in filebrowsing plugin
set path+=**

set rtp+=/usr/local/opt/fzf

" nvim default
" set wildmenu " visual autocomplete for commands

" splits to open below or to right
set splitbelow
set splitright

" nvim default
" set undofile " maintain undo history between sessions
" set undodir=~/.vim/undodir

" }}}

" plugin key mappings {{{

" coc {{{

set cmdheight=2
set updatetime=300

" Use <cr> to confirm completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

" Use tab to scroll autocomplete
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" }}}

" }}}

" behavioural fixes {{{
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>
set noerrorbells visualbell t_vb= " disable audible bell

" }}}

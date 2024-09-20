"*******************************************************************************
"" Basic Setup
"*******************************************************************************

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Some language servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

"" Short update times mean LSP diagnostics update sooner
set updatetime=300

"" Always show the sign column (aka gutter)
set signcolumn=yes

"" Map leader to <Space>
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/bin/sh
endif


"*******************************************************************************
"" Vim-Plug
"*******************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
	execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " .shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))


"*******************************************************************************
"" NERDTree
"*******************************************************************************

Plug 'scrooloose/nerdtree' "NERDTree: tree view of workspace. :help nerdtree
Plug 'jistr/vim-nerdtree-tabs' " Make NERDTree behave like a GUI side panel. :help nerdtree-tabs

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-S-n> :NERDTreeFocusToggle<CR>
nnoremap <silent> <leader>n :NERDTreeFind<CR>


"*******************************************************************************
"" Git
"*******************************************************************************

Plug 'tpope/vim-fugitive' " Git plugin. :help fugitive
Plug 'tpope/vim-rhubarb' " Required by fugitive to :GBrowse
Plug 'airblade/vim-gitgutter' " Shows git diff indicators in the gutter, adds hunk textobject, and adds functions for staging/undoing hunks. :help gitgutter

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

noremap <leader>gw :Gwrite<CR>
noremap <leader>gc :Git commit --verbose
noremap <leader>gsh :Git push<CR>
noremap <leader>gl :Gclog<CR>
noremap <leader>gll :Git pull<CR>
noremap <leader>gs :Git<CR>
noremap <leader>gb :Git blame<CR>
noremap <leader>gd :Gvdiffsplit<CR>
noremap <leader>gr :GRemove<CR>


"*******************************************************************************
"" Statusline
"*******************************************************************************

Plug 'vim-airline/vim-airline' " Statusline at the bottom of each window. :help airline
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline/vim-airline. Switch theme with :AirlineTheme <theme>. :help airline-themes.txt

let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = '▶'
  let g:airline_left_alt_sep = '»'
  let g:airline_right_sep = '◀'
  let g:airline_right_alt_sep = '«'
  left g:airline#extensions#branch#prefix = '⤴'
  let g:airline#extensions#readonly#symbol = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol = 'ρ'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


"*******************************************************************************
"" Session management
"*******************************************************************************

Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1

nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>


"*******************************************************************************
"" Miscellaneous plugins
"*******************************************************************************

Plug 'tpope/vim-commentary' " Un/comment stuff with [count]gcc, gc<motion>, gc. :help commentary
Plug 'vim-scripts/grep.vim' " :Grep, :Rgrep, :Bgrep etc
Plug 'vim-scripts/CSApprox' " Adapts gVim themes to terminal Vim
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale' " linting and indenting
Plug 'Yggdroot/indentLine'
Plug 'tomasr/molokai' " molokai theme
"Plug 'lambdalisue/vim-nerdfont'
Plug 'ryanoasis/vim-devicons' " For displaying nerd font icons eg in file trees, status lines, etc
Plug 'tpope/vim-sleuth' " Auto-detects shiftwidth, expandtab etc based on file contents, editorconfig etc
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP server

"" fzf.vim
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' } " Shows file previews in fuzzy file picker


"*******************************************************************************
"" Custom bundles
"*******************************************************************************

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax' " CSS3 syntax
Plug 'gko/vim-coloresque' " Colour previews in CSS
Plug 'tpope/vim-haml' " HAML, SCSS and Sass features
Plug 'mattn/emmet-vim' " Expand emmet abbreviations with <C-y> (default)

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax' " JavaScript syntax

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'


"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Visual Settings
"*****************************************************************************

syntax on
set ruler
set number

let no_buffers_menu=1
colorscheme molokai


" Better command line completion 
set wildmenu

" mouse support
set mouse=a

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn="Caskaydia Cove NF"\ 14

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = ''
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif

endif


if &term =~ '256color'
  set t_ut=
endif


"" Disable the blinking cursor.
set gcr=a:blinkon0

set scrolloff=3


"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\


"*****************************************************************************
"" Abbreviations
"*****************************************************************************

" Mis-capitalisation of w, q etc
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'


"*****************************************************************************
"" Commands
"*****************************************************************************

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e


"*****************************************************************************
"" Functions
"*****************************************************************************

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread


"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Pastes the file path of the open buffer into the command line
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" List active buffers (fzf.vim)
nnoremap <silent> <leader>b :Buffers<CR>

" Open fuzzy finder (fzf.vim)
nnoremap <silent> <leader>e :FZF -m<CR>

noremap <leader>y "*y
noremap <leader>Y "*Y
noremap <leader>p "*p<CR>
noremap <leader>P "*P<CR>

" Buffer nav
nnoremap gp :bprev<CR>
nnoremap gn :bnext<CR>

"" Close buffer
nnoremap <leader>c :bd<CR>

"" Clean search highlight
nnoremap <silent> <BS> :noh<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <leader>o :.GBrowse<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" grep in open workspace (grep.vim)
nnoremap <silent> <leader>/ :Rgrep<CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"" LSP actions
" Tab either triggers completion, or cycles through completion options
" Not sure what <C-h> is for...?
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Navigate diagnostics
nnoremap <silent> [d <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
" Hover
nnoremap <silent> <leader>k :call ShowDocumentation()<CR>
" Rename
nnoremap <leader>r <Plug>(coc-rename)
" Formatting selected code
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)
" Code actions
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-cursor)
nmap <leader>ab <Plug>(coc-codeaction-source)
" Refactoring actions
nmap <leader>rf <silent> <Plug>(coc-codeaction-refactor)
xmap <leader>rf <silent> <Plug>(coc-codeaction-refactor-selected)

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover)
        call CocActionAsync('doHover')
    else
           call feedkeys('K', 'in')
    endif
endfunction

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path '*node_modules/**' -prune -o -path '*target/**' -prune -o -path '*dist/**' -prune -o -path '*coverage/** -prune -o  -type f -print -o -type l -print 2> /dev/null"

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_linters = {}

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif


"*****************************************************************************
"" Custom configs
"*****************************************************************************

" javascript
let g:javascript_enable_domhtmlcss = 1

" typescript
let g:yats_host_keyword = 1

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif


"*****************************************************************************
"" Convenience variables
"*****************************************************************************

"" coc.nvim extensions
" For up-to-date list, see:
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [
    \ 'coc-angular',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-diagnostic',
    \ 'coc-docker',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-fzf-preview',
    \ 'coc-git',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-htmlhint',
    \ 'coc-html-css-support',
    \ 'coc-java',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-prettier',
    \ 'coc-tsserver',
    \ 'coc-yaml',
\]
autocmd VimEnter silent * CocUpdate

"" CoC workspace roots
autocmd FileType typeescript let b:coc_root_patterns ['tsconfig.json', 'package.json', 'yarn.lock', '.git']

" Loads vimrc from current working directory
set exrc

packadd! editorconfig

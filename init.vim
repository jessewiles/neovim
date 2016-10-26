execute pathogen#infect()
syntax on

set runtimepath^=~/.config/nvim/bundle/ctrlp.vim

set wildignore+=*Zend*,.git,*.pyc,*bundles*,*jpgraph*,*Smarty*
set wildignore+=*smarty*,django_test*,backups/2010*,images*
set wildignore+=graphs*,*amcharts*,.csv,*un~*,*swp*,library/adodb*
set wildignore+=current/*,*node_modules*,_site/*,ENV*,BASELINE*
set wildignore+=htmlcov*,coverage_html_report*,rank_*.out,tmp*_*

let mapleader = ","
filetype plugin indent on
set colorcolumn=81,101

highlight ColorColumn ctermbg=black
set modelines=20

map <ESC>[1;5A <C-Up>
map <ESC>[1;5B <C-Down>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>
map! <ESC>[1;5A <C-Up>
map! <ESC>[1;5B <C-Down>
map! <ESC>[1;5D <C-Left>
map! <ESC>[1;5C <C-Right>

augroup filetype
  au!
  au! BufRead,BufNewFile *.phtml set ft=php.html " For SnipMate
  au! BufRead,BufNewFile *.tpl set ft=html " For SnipMate
  au! BufRead,BufNewFile *.yaml set syntax=off
  au! BufRead,BufNewFile *.yml set syntax=off
  au BufNewFile,BufRead .tmux.conf*,tmux.conf*,tmux.* setf tmux
augroup END

" Got te end of yanked block after yank
au FileType * vmap y y`]

" Go to last part of file edited after re-opening buffer
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


set tabstop=4
set shiftwidth=4
set cmdheight=2
set complete-=i " Searching includes can be slow
set dictionary+=/usr/share/dict/words
set display=lastline
set nofoldenable

" set encoding=utf-8
set smartindent
set autoindent
set showmode
" set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell

" Carriage return goes to next buffer
nnoremap <CR> :wa<CR><C-^>

 
" set ttyfast " Disable - slows down vim
" set ruler " Disable - slows down vim
set backspace=indent,eol,start
set laststatus=2
set number
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
augroup myCursorLine
  autocmd!
  autocmd InsertEnter * set cursorline
  autocmd InsertLeave * set nocursorline
augroup end

set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch
set bg=dark
set nowrap
set gdefault

nnoremap <leader><space> :noh<CR>
noremap <leader>y y :PBCopy<CR>
noremap <leader>g :set paste!<CR>
nnoremap <leader>s /<C-p>
nnoremap <leader>gg <C-g>
nnoremap <leader>w :w<CR>
nnoremap <leader>m 0<C-w>\|
nnoremap <leader>k :nohlsearch<CR>

" Make splits the same width
nnoremap <leader>z <C-w>=

" Open a vertically-split window
nnoremap <leader>v <C-w>v

"sudo vim <file> if vim <file> complains about permissions
cnoremap w!! w !sudo tee % >/dev/null

"strip trailing whitespace
nnoremap <leader>c :%s/\s\+$<CR>

" Better scrolling
nnoremap <Space> <C-F>
nnoremap t <C-B>

" Smooth scroll up one line
nnoremap r <C-Y>
" Smooth scroll down one line
"nnoremap f <C-E>

set directory=/home/vagrant/.swp

" For Postgres comments
autocmd FileType sql setlocal commentstring=--\ %s

" Easier splits navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-t> <C-w>t
"nnoremap <C-v> "ayaw :%s/\=@a/\=@a/gn
inoremap <C-t> <ESC>


" Neovim
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)


" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Show next 10 lines while scrolling.
if !&scrolloff
  set scrolloff=10       
endif

" Show next 5 columns while side-scrolling.
if !&sidescrolloff
  set sidescrolloff=5   
endif
set display+=lastline
set nostartofline 


" Autocomplete
let g:deoplete#enable_at_startup = 1


" CtrlP
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlPClearCache<CR>
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:20'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_cache_dir = '/home/vagrant/.ctrlpcachedir'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_match_current_file = 1


" Neomake
let search=system('/home/vagrant/bin/find_up tox.ini')
if !v:shell_error
  let g:tox_ini_exists=1
else
  let g:tox_ini_exists=0
endif

if g:tox_ini_exists == 1
  let g:neomake_python_enabled_makers = ['flake8']
else
  let g:neomake_python_enabled_makers = []
endif

function! s:lint()
  if g:tox_ini_exists == 1
    echo g:neomake_python_enabled_makers
  else
    echo 'Linting is disabled'
  endif
endfunction
command! -nargs=0 -bar Lint call s:lint()
"autocmd VimEnter * silent !/home/vagrant/bin/setup_pre_commit_linter


augroup filetype
  au BufRead,BufWritePost *.py Neomake
augroup END


" http://vi.stackexchange.com/questions/7615/neomake-prints-results-to-terminal-when-invoking-upon-wq
autocmd! QuitPre * let g:neomake_verbose = 0


" Vim-gitgutter
set updatetime=250

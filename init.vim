syntax on

set shell=/bin/zsh

set number
set relativenumber

filetype plugin indent on
set tabstop=2

set shiftwidth=2
set expandtab

let mapleader="\<Space>"

call plug#begin('~/.local/share/nvim/plugged')

" new color theme
Plug 'joshdick/onedark.vim'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" call tmux from vim
Plug 'benmills/vimux'

Plug 'airblade/vim-gitgutter'

" snips
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'tpope/vim-abolish'
call plug#end()


nmap ll :w<CR>
inoremap jj <Esc>

" <Leader>s{char} to move to {char}
map  <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)

" f{char}{char} to move to {char}{char}
nmap <Leader>a <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)


" replacing vims searcher
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" jsdocs
let g:javascript_plugin_jsdoc = 1

"
" Theme
syntax enable
set termguicolors
" in your .vimrc or init.vim
" if you use airline / lightline
 colorscheme onedark

" default theme
let g:airline_theme='onedark' "  deus
let g:tmuxline_theme='powerline'
"let g:airline#extensions#tmuxline#enabled = 0

" set the way splits open - more natural from right and bottom
set splitbelow
set splitright

" bind some gitfugitive commands
map <Leader>gs :G status<CR>
map <Leader>ge :G edit<CR>
map <Leader>ggp :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)<CR>
map <Leader>gp :G push<CR>
map <Leader>gl :G log<CR>
map <Leader>gd :G diff<CR>
map <Leader>gc :G commit<CR>

command! Greview :Git! diff --staged
nnoremap <leader>gr :Greview<cr>

" bind crtl-, to inspect VimuxInspectRunner
nmap <C-l> :VimuxInspectRunner<CR>
" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Interrupt any command running in the runner pane map
map <Leader>vs :VimuxInterruptRunner<CR>

" Prompt for a command to run yarn test
autocmd FileType javascript map <Leader>t :VimuxPromptCommand("yarn test")<CR><CR>
autocmd FileType javascript map <Leader>T :VimuxPromptCommand("yarn lint")<CR><CR>
autocmd FileType js map <Leader>t :VimuxPromptCommand("yarn test")<CR><CR>
autocmd FileType js map <Leader>T :VimuxPromptCommand("yarn lint")<CR><CR>
autocmd FileType javascript.jsx map <Leader>t :VimuxPromptCommand("yarn test")<CR><CR>
autocmd FileType javascript.jsx map <Leader>T :VimuxPromptCommand("yarn lint")<CR><CR>
autocmd FileType go map <Leader>r :VimuxPromptCommand("go run -race *.go")<CR><CR>
autocmd FileType go map <Leader>t :VimuxPromptCommand("go test")<CR><CR>
autocmd FileType elixir map <Leader>t :VimuxPromptCommand("mix test lib")<CR><CR>
autocmd FileType elixir map <Leader>tf :VimuxPromptCommand("mix test lib --failed")<CR><CR>
autocmd FileType elixir map <Leader>T :VimuxPromptCommand("mix credo")<CR><CR>


set clipboard=unnamed
set autoread

set backupdir=~/.vim-tmp
set directory=~/.vim-tmp


"" extra settings stolen of that youtube dude
set autoindent              " automatically set indent of new line
set smartindent

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" make backspace behave in a sane manner
set backspace=indent,eol,start

set magic                   " Set magic on, for regex

set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" error bells
set noerrorbells
set visualbell


" Textmate style indentation
vmap <leader>[ <gv
vmap <leader>] >gv
nmap <leader>[ <<
nmap <leader>] >>

let g:VimuxOrientation = "h"
let g:VimuxHeight = "30"

" faster resizing
nnoremap <expr> <C-w>+ v:count1 * 15 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 15 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 15 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 15 . '<C-w>>'


autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


" window navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" easier pastin
" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>


" enable emmet just for html/css
let g:user_emmet_install_global = 0


" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes


"" hard
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


"" fold settings
set foldmethod=indent
set nofoldenable        "dont fold by default
set foldlevel=1
set foldnestmax=10

"FileType elixir imap <C-f> :set foldlevel=1

"" filetype for surface - elixir component lib
autocmd BufNewFile,BufRead *.sface set ft=elixir

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

" faster html
Plug 'mattn/emmet-vim'

Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-fugitive'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" call tmux from vim
Plug 'benmills/vimux'

Plug 'dense-analysis/ale'

Plug 'airblade/vim-gitgutter'

Plug 'posva/vim-vue'

Plug 'andys8/vim-elm-syntax'

" apparent solution to my life
Plug 'sheerun/vim-polyglot'
call plug#end()


"elm
autocmd BufWrite *.elm :call CocAction('format')


let g:ale_lint_on_save = 1
let g:ale_javascript_eslint_use_global = 0
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'javascript': ['eslint'], 'vue': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint'], 'vue': ['eslint']}

map <Leader>el :ALEFix<CR>
autocmd FileType go map <Leader>el :GoBuild<CR><CR>

:imap jj <Esc>
:nmap ll :w<CR>
:nmap jj :q<CR>

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

" fuzzy finder
nnoremap <C-p> :FuzzyOpen<CR>

" jsdocs
let g:javascript_plugin_jsdoc = 1

"
" Theme
syntax enable
set termguicolors
colorscheme onedark


map <C-m> :NERDTreeToggle<CR>
map <C-n> :NERDTreeFind<CR>

" set the way splits open - more natural from right and bottom
set splitbelow
set splitright

" bind some gitfugitive commands
map <Leader>gs :Gstatus<CR>:20wincmd_<CR>
map <Leader>ge :Gedit<CR>
map <Leader>ggp :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)<CR>
map <Leader>gp :Gpush<CR>
map <Leader>gl :Glog<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gb :Gbrowse<CR>

command! Greview :Git! diff --staged
nnoremap <leader>gr :Greview<cr>

" go stuff
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" disables <C-[> as go pop/go exploration
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"let g:go_metalinter_command = "golangci-lint"

let g:go_def_mapping_enabled = 0
map gd :GoDef<CR>
map <leader>gt :GoDefPop<CR>
map <leader>uc :GoSameIdsAutoToggle<CR>

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
noremap <C-[> :cnext<CR>
noremap <C-]> :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

autocmd FileType go nmap <leader>tt <Plug>(go-test)
autocmd FileType go nmap <Leader>tc <Plug>(go-coverage-toggle)
autocmd FileType go map <leader>tf :GoTestFunc<CR>
autocmd FileType go map <leader>tm :GoMetaLinter<CR>

autocmd FileType go map <leader>a :GoAlternate<CR>

"automatically shows type info
let g:go_auto_type_info = 1
autocmd FileType go nmap <Leader>i <Plug>(go-info)
set updatetime=500

" highlights matching words
let g:go_auto_sameids = 1
let g:go_fmt_fail_silently = 1

autocmd FileType go map <leader>d. :GoDecls<CR>
autocmd FileType go map <leader>dd :GoDeclsDir<CR>
au FileType go nmap <Leader>,f <Plug>(go-def-tab)

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" automatically does the imports exports 
let g:go_fmt_command = "goimports"

"make shit more pretty
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 0

"" end go stuff

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


" new fuzzy finder ctrlp being replaced with fzf
"set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"fzf good stuff
nnoremap <c-p> :GFiles<cr>
nnoremap <c-g> :GFiles?<cr>
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" default theme
let g:airline_theme='onedark' "deus
let g:tmuxline_theme='powerline'
"let g:airline#extensions#tmuxline#enabled = 0


" faster resizing
nnoremap <expr> <C-w>+ v:count1 * 15 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 15 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 15 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 15 . '<C-w>>'


" we have our own shit for jsx & go atm
let g:polyglot_disabled = [ 'go', 'vue', 'coffee-script', 'elm' ]
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


let NERDCreateDefaultMappings=0
map <leader>cs <plug>NERDCommenterMinimal
map <leader>c$ <plug>NERDCommenterToEOL
map <leader>ca <plug>NERDCommenterAppend
map <leader>c<space> <plug>NERDCommenterToggle

" nerd tree ignore css 
let NERDTreeIgnore = ['\.css$']

let NERDTreeMapOpenSplit='x'
let NERDTreeMapOpenVSplit='v'


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


" below for coc
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
autocmd FileType html,css,vue EmmetInstall


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


" Remap keys for gotos
" i like being able to 'pop' so using :GoDef for go, but coc-def for else
autocmd FileType elm nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" Show signature help on placeholder jump
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

hi! CocErrorSign guifg=#d1666a

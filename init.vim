syntax on

set number
set relativenumber

filetype off
filetype plugin indent on
set tabstop=2

set shiftwidth=2
set expandtab

let mapleader="\<Space>"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'othree/yajs.vim'
Plug 'othree/html5.vim'
Plug 'ternjs/tern_for_vim'
Plug 'mhartington/oceanic-next'
Plug 'pangloss/vim-javascript'
Plug 'ruanyl/vim-fixmyjs', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" generate tags
"Plug 'fntlnz/atags.vim'
"Plug 'isRuslan/vim-es6'

" project wide search
Plug 'eugen0329/vim-esearch'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" terraform
Plug 'hashivim/vim-terraform'

"snippets
Plug 'SirVer/ultisnips'

" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets', { 'for': 'javascript' }

" React code snippets
Plug 'epilande/vim-react-snippets', { 'for': 'javascript' }

" emmet
Plug 'mattn/emmet-vim'

"easy align
Plug 'junegunn/vim-easy-align'

" call tmux from vim
Plug 'benmills/vimux'
" better vim 
Plug 'tpope/vim-unimpaired'

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/molokai'
"Plug 'ctrlpvim/ctrlp.vim' using fuzzy
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"cool bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'edkolev/tmuxline.vim'

Plug 'xojs/vim-xo'

" linter
"Plug 'w0rp/ale'
call plug#end()

:imap jj <Esc>
:nmap ll :w<CR>
:nmap jj :q<CR>
"bind to save file
"noremap <Leader>ll :w<CR>


" tag bar
"nmap <Leader>p :TagbarToggle<CR>

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


"" ALE STUFF NEW thing to call linter
" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.
"let g:ale_fixers = {
"\   'javascript': ['eslint'],
"\}

"" hit el for autofixing
"nnoremap <leader> el :ALEFix<CR>
"let g:ale_use_ch_sendraw = 1

"" NEOMAKE STUFF WE USE TO USE
let g:neomake_javascript_enabled_makers = ['eslint', 'xo']
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
autocmd BufWritePost,BufEnter * Neomake
function ESLintFix()
  silent execute "!./node_modules/.bin/eslint --fix %"
  edit! %
  Neomake
endfunction

function XOLintFix()
  silent execute "!xo --fix %"
  edit! %
  Neomake
endfunction

""" hit el for autofixing
nnoremap <leader>el :call ESLintFix()<CR>
nnoremap <leader>xo :call XOLintFix()<CR>

" fuzzy finder
nnoremap <C-p> :FuzzyOpen<CR>

" jsdocs
let g:javascript_plugin_jsdoc = 1

" For Neovim 0.1.3 and 0.1.4
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
"
if has("termguicolors")     " set true colors
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
endif
"set termguicolors
"" set Vim-specific sequences for RGB colors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
""if (has("termguicolors"))
 ""set termguicolors
""endif
"" use 256 colors in terminal
"set t_Co=256
"
" Theme
syntax enable
colorscheme OceanicNext
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai


" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-l>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" generate tags on save
" autocmd BufWritePost * call atags#generate()
" random shit to get ctags
let g:tlist_javascript_settings = 'javascript;r:var;s:string;a:array;o:object;u:function'


map <C-n> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree
"autocmd VimEnter * wincmd p



" easier split screen navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set the way splits open - more natural from right and bottom
set splitbelow
set splitright

"" jsx is used by .js files
let g:jsx_ext_required = 0


let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}



" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" bind some gitfugitive commands
map <Leader>gs :Gstatus<CR>
map <Leader>ge :Gedit<CR>
map <Leader>gp :Gpush<CR>
map <Leader>gl :Glog<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gc :Gcommit<CR>

command Greview :Git! diff --staged
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

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
map <C-[> :cnext<CR>
map <C-]> :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

autocmd FileType go nmap <leader>tt <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
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
autocmd FileType js map <Leader>t :VimuxPromptCommand("yarn test")<CR><CR>
autocmd FileType js map <Leader>T :VimuxPromptCommand("yarn lint")<CR><CR>
autocmd FileType javascript.jsx map <Leader>t :VimuxPromptCommand("yarn test")<CR><CR>
autocmd FileType javascript.jsx map <Leader>T :VimuxPromptCommand("yarn lint")<CR><CR>
autocmd FileType go map <Leader>r :VimuxPromptCommand("go run -race *.go")<CR><CR>


set clipboard=unnamed
set autoread

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


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
let g:airline_theme='deus'
let g:tmuxline_theme='powerline'
"let g:airline#extensions#tmuxline#enabled = 0

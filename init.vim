syntax on

set shell=/bin/zsh

set number
set relativenumber

filetype off
filetype plugin indent on
set tabstop=2

set shiftwidth=2
set expandtab

let mapleader="\<Space>"

call plug#begin('~/.local/share/nvim/plugged')
"" terraform
Plug 'hashivim/vim-terraform', {'for': 'terraform' }

Plug 'easymotion/vim-easymotion'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim', { 'for': ['html', 'javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }

"javascript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ruanyl/vim-fixmyjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" for gbrowse
Plug 'tpope/vim-rhubarb'

" project wide search
Plug 'eugen0329/vim-esearch'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"snippets
Plug 'SirVer/ultisnips'

" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets', { 'for': ['javascript', 'javascript.jsx'] }

" React code snippets
Plug 'epilande/vim-react-snippets', { 'for': ['javascript', 'javascript.jsx'] }

" emmet
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript.jsx', 'javascript'] }

"easy align
Plug 'junegunn/vim-easy-align'

" call tmux from vim
Plug 'benmills/vimux'
" weird kepmapping don't think i use it
" Plug 'tpope/vim-unimpaired'

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"cool bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'edkolev/tmuxline.vim'

"Plug 'xojs/vim-xo', { 'for': ['javascript', 'javascript.jsx'] }

" apparent solution to my life
Plug 'sheerun/vim-polyglot'

"" unstyled
Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for':['javascript', 'javascript.jsx'] }

" new color theme
Plug 'joshdick/onedark.vim'

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

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

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

"
" Theme
syntax enable
"colorscheme OceanicNext
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
let g:onedark_termcolors=256
colorscheme onedark
"let g:rehash256 = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" deoplete tab-complete
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"snippets
let g:UltiSnipsExpandTrigger="<C-l>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:tlist_javascript_settings = 'javascript;r:var;s:string;a:array;o:object;u:function'


map <C-n> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree
"autocmd VimEnter * wincmd p


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
map <Leader>ggp :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)<CR>
map <Leader>gp :Gpush<CR>
map <Leader>gl :Glog<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gb :Gbrowse<CR>

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
let g:airline_theme='onedark' "deus
let g:tmuxline_theme='powerline'
"let g:airline#extensions#tmuxline#enabled = 0


" faster resizing
nnoremap <expr> <C-w>+ v:count1 * 15 . '<C-w>+'
nnoremap <expr> <C-w>- v:count1 * 15 . '<C-w>-'
nnoremap <expr> <C-w>< v:count1 * 15 . '<C-w><'
nnoremap <expr> <C-w>> v:count1 * 15 . '<C-w>>'


" we have our own shit for jsx & go atm
let g:polyglot_disabled = [ 'javascript', 'jsx', 'go', 'js', 'terraform']
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"pangloss folding -- could slow down js keep an eye on it
"augroup javascript_folding
  "au!
  "au FileType javascript setlocal foldmethod=syntax
"augroup END
"set foldmethod=indent
"set foldlevel=20

let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1


"" set python
let g:python_host_prog = '/Users/nathan/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/nathan/.pyenv/versions/neovim3/bin/python'


" nerd tree ignore css 
let NERDTreeIgnore = ['\.css$']

let NERDTreeMapOpenSplit='x'
let NERDTreeMapOpenVSplit='v'


" window navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

syntax on

set number
set relativenumber

filetype plugin indent on
set tabstop=2

set shiftwidth=2
set expandtab

let mapleader="\<Space>"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'cloudhead/neovim-fuzzy'
Plug 'easymotion/vim-easymotion'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'othree/yajs.vim'
Plug 'othree/html5.vim'
Plug 'ternjs/tern_for_vim'
Plug 'mhartington/oceanic-next'
Plug 'pangloss/vim-javascript'
Plug 'ruanyl/vim-fixmyjs'
Plug 'mxw/vim-jsx'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"tag sidebar
"Plug 'majutsushi/tagbar'

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
Plug 'epilande/vim-es2015-snippets'

" React code snippets
Plug 'epilande/vim-react-snippets'

" emmet
Plug 'mattn/emmet-vim'

"easy align
Plug 'junegunn/vim-easy-align'

" call tmux from vim
Plug 'benmills/vimux'
" better vim 
Plug 'tpope/vim-unimpaired'
call plug#end()

:imap jj <Esc>
:nmap ll :w<CR>
:nmap jj :q<CR>
"bind to save file
"noremap <Leader>ll :w<CR>


" tag bar
"nmap <Leader>p :TagbarToggle<CR>

" <Leader>f{char} to move to {char}
map  <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
"autocmd BufWritePost *.js !'./node_modules/.bin/eslint' --fix %
autocmd BufWritePost,BufEnter * Neomake

" fuzzy finder
nnoremap <C-p> :FuzzyOpen<CR>

" jsdocs
let g:javascript_plugin_jsdoc = 1

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

function ESLintFix()
  silent execute "!./node_modules/.bin/eslint --fix %"
  edit! %
  Neomake
endfunction

"" hit el for autofixing
nnoremap <leader>el :call ESLintFix()<CR>

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
map <Leader>vt :VimuxPromptCommand("yarn test")<CR><CR>
map <Leader>vT :VimuxPromptCommand("yarn lint")<CR><CR>


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

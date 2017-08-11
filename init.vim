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
Plug 'majutsushi/tagbar'

" generate tags
Plug 'fntlnz/atags.vim'
Plug 'isRuslan/vim-es6'

" project wide search
Plug 'eugen0329/vim-esearch'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" terraform
Plug 'hashivim/vim-terraform'

call plug#end()

" tag bar
nmap <Leader>p :TagbarToggle<CR>

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
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" generate tags on save
" autocmd BufWritePost * call atags#generate()
" random shit to get ctags
let g:tlist_javascript_settings = 'javascript;r:var;s:string;a:array;o:object;u:function'


map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p



" easier split screen navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set the way splits open - more natural from right and bottom
set splitbelow
set splitright



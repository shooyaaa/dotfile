
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'joonty/vdebug'
Plugin 'altercation/vim-colors-solarized'
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
"
"" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Install L9 and avoid a Naming conflict if you've already installed a
" " different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
" "
"set rnu
set nu
syntax on
filetype plugin on
filetype indent on

set ruler
set ignorecase
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set background=dark
"colorscheme solarized

set wildmenu
"au VimEnter *  NERDTree

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap {<CR> {<CR>}<ESC><S-o>
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
"
"function ClosePair(char)
"    if getline('.')[col('.') - 1] == a:char
"        return "/<Right>"
"    else
"        return a:char
"    endif
"endf

autocmd BufRead,BufNewFile *.as set filetype=as3

set showcmd

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
map qq <ESC>:q!<ENTER>
map qw <ESC>:w<ENTER>

set clipboard=unnamed

" Plugin syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php']
"let g:syntastic_php_checkers = ['php'], 'phpcs', 'phpmd']
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]



"start config of airline
set laststatus=2
set t_Co=256
set encoding=utf-8
set hlsearch

let g:ycm_auto_trigger = 1

function MyTabBuffer()
    echo 'tab buffer'
endfunction
map <TAB> <C-W>W

"remove trailing whitespace when write
function RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

function BuildJs()
    let g:buildFile = getcwd() . "/build.sh"
    if !empty(glob(g:buildFile))
        silent execute "!" . g:buildFile . " 2>&1 >/dev/null &"
    endif
endfunction

autocmd BufWritePost *.js call BuildJs()

"au BufWritePost *.js silent! !~/code/shooyaaa/js_bubble/build.sh 2>&1 >/dev/null &
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]
"
set cursorcolumn
set cursorline
"show  error  when line length bigger then 120
match ErrorMsg '\%>120v.\+'

"show invisible blank or tab
"set listchars=tab:>-,trail:·
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→

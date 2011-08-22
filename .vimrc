""""""""""""""""""""""""""""""""""""""""""""""""""
""" basics
""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=0
set autoindent
set wrap
set wrapscan
set wildmenu

set noignorecase
set smartcase

set showcmd
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set ruler

set number
set title
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab

set nobackup
set writebackup

set foldmethod=manual
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""
""" insert mode
""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-d> <Delete>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" search result highlight
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Esc><Esc> :<C-u>set hlsearch!<CR>
nnoremap n :<C-u>set hlsearch<CR>n
nnoremap N :<C-u>set hlsearch<CR>N
nnoremap / :<C-u>set hlsearch<CR>/
nnoremap ? :<C-u>set hlsearch<CR>?
nnoremap * :<C-u>set hlsearch<CR>*
nnoremap # :<C-u>set hlsearch<CR>#

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Space>t t
nnoremap <Space>T T
nnoremap t <Nop>
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""
function! SOLSpaceHilight()
  syntax match SOLSpace "^\s\+" display containedin=ALL
  highlight SOLSpace term=underline ctermbg=darkblue
endf
function! SOLSpaceHilightEnd()
  syntax match SOLSpace "\s\+$" display containedin=ALL
  highlight SOLSpace term=underline ctermbg=darkblue
endf
function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=darkblue
endf
if has("syntax")
  augroup invisible
  autocmd! invisible
  autocmd BufNew,BufRead * call SOLSpaceHilight()
  autocmd BufNew,BufRead * call SOLSpaceHilightEnd()
  autocmd BufNew,BufRead * call JISX0208SpaceHilight()
  augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
" yank from cursol to the end of line
nnoremap Y y$

source ~/.vimrc.local

" rename opened file: http://vim-users.jp/2009/05/hack17/
"   usage: :Rename newfilename.txt
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
""" vundle
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/dotfiles/.vim/vundle.git/
call vundle#rc()

Bundle 'Shougo/neocomplcache'
Bundle 'hrp/EnhancedCommentify'
Bundle 'vim-scripts/yanktmp.vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-rails'
Bundle 'vim-scripts/svn-diff.vim'
Bundle 'tsaleh/vim-align'
Bundle 'janx/vim-rubytest'
Bundle 'Shougo/unite.vim'
Bundle 'othree/eregex.vim'
Bundle 'thinca/vim-ref'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-start neocomplcache withtout :NeoCompleCasheEnable
let g:neocomplcache_enable_at_startup = 1
" smartcase setting ignore case till capped input
let g:neocomplcache_enable_smart_case = 1
" not good for performance, but efficienct for java
"   example: NeoCompleCache can complete NCC (N*C*C*)
autocmd FileType java let g:neocomplcache_enable_camel_case_completion = 1
" enable completion words include underbar ( _ )
let g:neocomplcache_enable_underbar_completion = 1
" completion menimum lentgh for cache, default: 4
let g:neocomplcache_min_syntax_length = 4
" auto lock buffer pattern for bad compatibility with neocomplcache
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" emmulate SuperTab behavior
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?  "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

nnoremap Ns <Plug>(neocomplcache_snippets_expand)

""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=0
nnoremap Ua :<C-u>Unite buffer<CR>
nnoremap Uf :<C-u>Unite file<CR>
nnoremap Um :<C-u>Unite file_mru<CR>
nnoremap Uu :<C-u>Unite buffer file_mru<CR>
nnoremap Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap Ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap Ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap Ru :<C-u>Unite ref/refe<CR>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" yanktmp.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" eregex.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

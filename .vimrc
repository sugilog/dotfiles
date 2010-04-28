"file settings
set fileformat=unix
set fileencoding=utf-8

"basic settings
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
set nocompatible

set nobackup
set writebackup

syntax on
filetype on
filetype indent on
filetype plugin on

"settings for insert mode
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-d> <Delete>

"settings for highlight
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

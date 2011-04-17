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
set nocompatible

set nobackup
set writebackup

set foldmethod=manual

syntax enable
filetype on
filetype indent on
filetype plugin on

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
""" http://blog.appling.jp/archives/140
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


""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
""" pathogen.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#runtime_append_all_bundles()


""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplcache settings
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?  "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"


""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=1
nnoremap <silent> Ub :<C-u>Unite buffer<CR>
nnoremap <silent> Uf :<C-u>Unite file<CR>
nnoremap <silent> Um :<C-u>Unite file_mru<CR>
nnoremap <silent> Uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> Ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> Ur :<C-u>Unite -buffer-name=register register<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" yanktmp
""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>


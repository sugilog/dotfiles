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
Bundle 'tpope/vim-haml'
Bundle 'vim-ruby/vim-ruby'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""
""" basics
""""""""""""""""""""""""""""""""""""""""""""""""""
language mes C

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
autocmd FileType * setlocal formatoptions-=ro

set nobackup
set writebackup

syntax enable

set foldmethod=syntax
set foldlevel=1
set foldnestmax=2
" ref: http://d.hatena.ne.jp/thinca/20110523/1306080318
augroup foldmethod-syntax
  autocmd!
  autocmd InsertEnter * if &l:foldmethod ==# 'syntax'
  \                   |   setlocal foldmethod=manual
  \                   | endif
  autocmd InsertLeave * if &l:foldmethod ==# 'manual'
  \                   |   setlocal foldmethod=syntax
  \                   | endif
augroup END

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
highlight WhitespaceEOL ctermfg=Red ctermbg=Red guibg=Red
au BufWinEnter,VimEnter,WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\s\+$')

highlight WhitespaceBOL ctermfg=Red ctermbg=Red guibg=Red
au BufWinEnter,VimEnter,WinEnter * let w:m2 = matchadd("WhitespaceBOL", '^\s\+')

highlight ZenkakuSpace ctermfg=Red ctermbg=Red guibg=Red
au BufWinEnter,VimEnter,WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

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
""" neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-start neocomplcache withtout :NeoCompleCacheEnable
let g:neocomplcache_enable_at_startup = 1
" smartcase setting ignore case till capped input
let g:neocomplcache_enable_smart_case = 1
" not good for performance, but efficienct for java
"   example: NeoCompleCache can complete NCC (N*C*C*)
autocmd FileType java let g:neocomplcache_enable_camel_case_completion = 1
" enable completion words include underbar ( _ )
let g:neocomplcache_enable_underbar_completion = 1
" completion menimum lentgh for cache, default: 4
let g:neocomplcache_min_syntax_length = 6
" emmulate SuperTab behavior
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?  "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

nnoremap Ns <Plug>(neocomplcache_snippets_expand)
nnoremap Ne <C-u>:NeoComplCacheEnable<CR>
nnoremap Nd <C-u>:NeoComplCacheDisable<CR>

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
" required to reference from http://doc.okkez.net/archives/
" and add its directory to PATH
" ref: http://d.hatena.ne.jp/arcright/20110814/1313331345
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

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=controller()

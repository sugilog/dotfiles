""""""""""""""""""""""""""""""""""""""""""""""""""
""" vundle
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/dotfiles/neobundle.vim

if has('vim_starting')
  set runtimepath+=~/dotfiles/neobundle.vim
  call neobundle#rc(expand('~/.vim/'))
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'hrp/EnhancedCommentify'
NeoBundle 'vim-scripts/yanktmp.vim'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-scripts/svn-diff.vim'
NeoBundle 'tsaleh/vim-align'
NeoBundle 'janx/vim-rubytest'
NeoBundle 'othree/eregex.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'mattn/zencoding-vim'

filetype plugin indent on

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
""" search setting
""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
nnoremap <silent> <Esc><Esc> :<C-u>set hlsearch!<CR>
nnoremap n :<C-u>set hlsearch<CR>n
nnoremap N :<C-u>set hlsearch<CR>N
nnoremap / :<C-u>set hlsearch<CR>/
nnoremap ? :<C-u>set hlsearch<CR>?
nnoremap * :<C-u>set hlsearch<CR>*
nnoremap # :<C-u>set hlsearch<CR>#

""""""""""""""""""""""""""""""""""""""""""""""""""
""" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""
highlight WhitespaceEOL ctermfg=Red ctermbg=Red guibg=Red
au BufWinEnter,VimEnter,WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\s\+$')

highlight WhitespaceBOL ctermfg=Red ctermbg=Red guibg=Red
au BufWinEnter,VimEnter,WinEnter * let w:m2 = matchadd("WhitespaceBOL", '^\s\+')

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
" yank from cursol to the end of line
nnoremap Y y$

source ~/.vimrc.local

" rename opened file: http://vim-users.jp/2009/05/hack17/
"   usage: :Rename newfilename.txt
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" temp file
command! Tmpfile :edit `=tempname()`
map <leader>s :Tmpfile<CR>

au FileType sql command! -nargs=1 Mysql :! mysql -u root -D <args> < % -t

""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
autocmd FileType java let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

imap <expr><Tab> neocomplcache#sources#snippets_complete#expandable() ? "<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> neocomplcache#cancel_popup()."\<C-n>"

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=0
nnoremap Ua :<C-u>Unite buffer<CR>
nnoremap Uf :<C-u>Unite file<CR>
nnoremap Um :<C-u>Unite file_mru<CR>
nnoremap Ub :<C-u>Unite buffer<CR>
nnoremap Uu :<C-u>Unite buffer file_mru<CR>
nnoremap Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap Ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap Ur :<C-u>Unite -buffer-name=register register<CR>

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
nnoremap ,/ :M/
nnoremap ,? :M?
"" call Explore only E; to prevent ambiguous command with E2v
command! E :Explore

""""""""""""""""""""""""""""""""""""""""""""""""""
""" rails.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=controller()

""""""""""""""""""""""""""""""""""""""""""""""""""
""" zencoding.vim
""""""""""""""""""""""""""""""""""""""""""""""""""


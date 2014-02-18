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

NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'Shougo/vimproc', {
      \ "build" : {
      \     "mac"  : "make -f make_mac.mak",
      \     "unix" : "make -f make_unix.mak",
      \   },
      \ }
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'marijnh/tern_for_vim', {
      \   "build" : {
      \     "mac"  : "npm install",
      \     "unix" : "npm install",
      \   },
      \   "autoload": {
      \     "filetypes": ["javascript", "typescript"]
      \   },
      \ }
NeoBundle 'zhaocai/unite-scriptnames'
NeoBundle 'basyura/unite-rails'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'janx/vim-rubytest'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/tracwiki'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-scripts/yanktmp.vim'
NeoBundle 'hrsh7th/vim-versions'
" fork from 'tomasr/molokai' 
NeoBundle 'sugilog/molokai' 
" NeoBundle 'mattn/benchvimrc-vim'
" require to install https://github.com/koron/cmigemo
NeoBundle 'haya14busa/vim-migemo'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-over'
" Gist-vim required webapi-vim
" and set: git config --global github.user Username
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'


filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""
""" basics
""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=0
set autoindent
set wrap
set wrapscan
set wildmenu

set smartcase

set showcmd
set laststatus=2
set statusline=%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set number
set title
set tabstop=2
set shiftwidth=2
set expandtab

set nobackup
set nowritebackup
set noswapfile

colorscheme molokai
let g:rehash256=1
set background=dark

syntax enable

set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932

set suffixesadd+=.js

" setting for ambiguous characters
" on Mac Terminal.app, use with https://github.com/Nyoho/TerminalEastAsianAmbiguousClearer
set ambiwidth=double
set display+=lastline

if $TERM != "screen"
  set clipboard=unnamed
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
let loaded_matchparen = 1

" yank from cursol to the end of line
nnoremap Y y$

""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('lua')
imap <C-y> <Plug>(neosnippet_expand_or_jump)
smap <C-y> <Plug>(neosnippet_expand_or_jump)
xmap <C-y> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
endif

let g:neocomplete#force_overwrite_completefunc = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=1
nnoremap Uu :<C-u>Unite file_mru<CR>
nnoremap Um :<C-u>Unite menu:shortcut<CR>
vmap     Um :<C-u>Unite menu:shortcut<CR>
nnoremap Ug :<C-u>Unite menu:gist<CR>
nnoremap Us :<C-u>Unite source<CR>
nnoremap Ur :<C-u>Unite source<CR>rails/ 
nnoremap Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap Ub :<C-u>Unite buffer<CR>
nnoremap Uo :<C-u>Unite outline<CR>
nnoremap Uv :<C-u>UniteVersions status<CR>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

let g:unite_source_menu_menus = {
      \   "shortcut" : {
      \       "description" : "unite-menu",
      \       "command_candidates" : [
      \           ["invoke over",           "OverCommandLine"],
      \           ["invoke over (visual)",  "'<,'>OverCommandLine"],
      \           ["svn commit",   "UniteSvnDiff"],
      \           ["dir",          "UniteWithBufferDir -buffer-name=files file"],
      \           ["file mru",     "Unite file_mru"],
      \           ["unite",        "UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file"],
      \           ["register",     "Unite -buffer-name=register register"],
      \           ["unite source", "Unite source"],
      \           ["edit vimrc",   "edit $MYVIMRC"],
      \           ["source vimrc", "source $MYVIMRC"],
      \       ],
      \   },
      \   "gist" : {
      \       "description" : "unite-gist-menu",
      \       "command_candidates" : [
      \           ["my gists",     "Gist -l sugilog"],
      \           ["post gist",    "Gist -p"],
      \           ["update gist",  "Gist -e"],
      \       ],
      \   },
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""
""" yanktmp.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> ty :call YanktmpYank()<CR>
map <silent> tp :call YanktmpPaste_p()<CR>
map <silent> tP :call YanktmpPaste_P()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" easy-motion and anzu
""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
set hlsearch

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

nnoremap <silent> <Esc><Esc> :set hlsearch!<CR>:echo<CR>
map  n <Plug>(anzu-n-with-echo)zz
map  N <Plug>(anzu-N-with-echo)zz
nmap * :set hlsearch<CR>zz<Plug>(anzu-star-with-echo)
nmap # :set hlsearch<CR>zz<Plug>(anzu-sharp-with-echo)
let g:anzu_no_match_word = '%#ErrorMsg#Pattern not found: %p'

vnoremap * "zy:let @/ = @z<CR>n

let g:EasyMotion_use_migemo = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
""" actionscript.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.as set filetype=actionscript


""""""""""""""""""""""""""""""""""""""""""""""""""
""" emmet-vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_zen_settings = { 'indentation' : '  ' }


""""""""""""""""""""""""""""""""""""""""""""""""""
""" alignta.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leader>a :Alignta =><CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" sudo.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>s :e sudo:%<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""
""" trackwiki.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.tracwiki
  \ if &ft == '' |
  \   set ft=tracwiki |
  \ else |
  \   setf tracwiki |
  \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-versions
""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:UniteVersionsWithDiff(type)
  tabnew
  silent! setlocal ft=diff nobackup noswf nobuflisted nowrap buftype=nofile
  exe "silent! read !LANG=C " . a:type . " diff"
  setlocal nomodifiable
  goto 1
  redraw!
  exe "silent! Unite versions/" . a:type . "/status"
endfunction
command! -nargs=0 UniteSvnDiff call s:UniteVersionsWithDiff("svn")
command! -nargs=0 UniteGitDiff call s:UniteVersionsWithDiff("git")

let g:versions#type#svn#status#ignore_status = [
  \  "X"
  \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""
""" over
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>o :OverCommandLine<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" gist
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1


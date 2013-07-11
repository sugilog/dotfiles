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
NeoBundle 'othree/eregex.vim'
NeoBundle 'vim-scripts/svn-diff.vim'
NeoBundle 'Shougo/vimproc', {
      \ "build" : {
      \     "mac"  : "make -f make_mac.mak",
      \     "unix" : "make -f make_unix.mak",
      \   },
      \ }
" Make following plugins lazy and set autoload hook
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'zhaocai/unite-scriptnames'
NeoBundle 'basyura/unite-rails'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'janx/vim-rubytest'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'jeroenbourgois/vim-actionscript'
NeoBundle 'vim-scripts/tracwiki'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-scripts/yanktmp.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'Lokaltog/powerline'
set rtp+=~/.vim/powerline/powerline/bindings/vim

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
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set number
set title
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab

set nobackup
set nowritebackup

syntax enable

set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932

" setting for ambiguous characters
" on Mac Terminal.app, use with https://github.com/Nyoho/TerminalEastAsianAmbiguousClearer
" set ambiwidth=double
set display+=lastline

if $TERM != "screen"
  set clipboard=unnamed
endif

if $TERM == "xterm-256color"
  colorscheme molokai
end


""""""""""""""""""""""""""""""""""""""""""""""""""
""" search setting
""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
nnoremap <silent> <Esc><Esc> :<C-u>set hlsearch!<CR>
nnoremap n :<C-u>set hlsearch<CR>nzz
nnoremap N :<C-u>set hlsearch<CR>Nzz
nnoremap / :<C-u>set hlsearch<CR>/
nnoremap ? :<C-u>set hlsearch<CR>?
nnoremap * :<C-u>set hlsearch<CR>*zz
nnoremap # :<C-u>set hlsearch<CR>#zz

nnoremap mc /\(<\\|=\\|>\)\{6\}<CR>
au QuickfixCmdPost vimgrep cw

""""""""""""""""""""""""""""""""""""""""""""""""""
""" highlight
""""""""""""""""""""""""""""""""""""""""""""""""""
if $TERM == "xterm-256color"
  highlight myWhitespace ctermbg=241
  " highlight CursorColumn ctermbg=241 term=reverse
  "
  function s:myWhitespaceHighlight()
    syntax match myWhitespace "\s\+$"
    syntax match myWhitespace "^\s\+"
    syntax match myWhitespace "^<%\s\+"
  endfunction
  au BufWinEnter,VimEnter,WinEnter * call s:myWhitespaceHighlight()
endif

" set cursorcolumn

" disable highlight parenthesis
" enable on file editing do :DoMatchParen
let loaded_matchparen = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
" yank from cursol to the end of line
nnoremap Y y$

""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
""" neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('lua')
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
""" unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert=1
nnoremap Uu :<C-u>Unite file_mru<CR>
nnoremap Um :<C-u>Unite menu:shortcut<CR>
nnoremap Us :<C-u>Unite source<CR>
nnoremap Ur :<C-u>Unite source<CR>rails/ 
nnoremap Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap Ub :<C-u>Unite buffer<CR>
nnoremap Uo :<C-u>Unite outline<CR>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

let g:unite_source_menu_menus = {
      \   "shortcut" : {
      \       "description" : "unite-menu",
      \       "command_candidates" : [
      \           ["dir",          "UniteWithBufferDir -buffer-name=files file"],
      \           ["file mru",     "Unite file_mru"],
      \           ["unite",        "UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file"],
      \           ["register",     "Unite -buffer-name=register register"],
      \           ["unite source", "Unite source"],
      \           ["edit vimrc",   "edit $MYVIMRC"],
      \           ["source vimrc", "source $MYVIMRC"],
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
""" eregex.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,/ :M/
nnoremap ,? :M?
"" call Explore only E; to prevent ambiguous command with E2v
command! E :Explore

""""""""""""""""""""""""""""""""""""""""""""""""""
""" actionscript.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.as set filetype=actionscript


""""""""""""""""""""""""""""""""""""""""""""""""""
""" zencoding.vim
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

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
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'zhaocai/unite-scriptnames'
" fork from 'basyura/unite-rails'
NeoBundle 'sugilog/unite-rails'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/tracwiki'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'hrsh7th/vim-versions'
" fork from 'tomasr/molokai' 
NeoBundle 'sugilog/molokai' 
NeoBundle 'osyo-manga/vim-anzu'
" Gist-vim required webapi-vim
" and set: git config --global github.user Username
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'benmills/vimux'
NeoBundle 'pgr0ss/vimux-ruby-test'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'kannokanno/unite-dwm'
NeoBundle 'AndrewRadev/linediff.vim'

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""
""" basics
""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=0
set autoindent
set wrap
set wrapscan
set wildmenu

set ignorecase
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
nnoremap Uu :<C-u>Unite neomru/file<CR>
nnoremap Um :<C-u>Unite menu:shortcut<CR>
vmap     Um :<C-u>Unite menu:shortcut<CR>
nnoremap Ug :<C-u>Unite menu:gist<CR>
nnoremap Ud :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap UD :<C-u>Unite directory<CR>
nnoremap Ub :<C-u>Unite buffer -default-action=dwm_open<CR>
nnoremap Uv :<C-u>UniteVersions status<CR>
nnoremap Uo :<C-u>Unite outline<CR>

nnoremap U/ :<C-u>Unite line:all<CR>

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

nnoremap Rc :<C-u>Unite rails/controller<CR>
nnoremap Rm :<C-u>Unite rails/model<CR>
nnoremap Rv :<C-u>Unite rails/view<CR>
nnoremap Rh :<C-u>Unite rails/helper<CR>
nnoremap Rl :<C-u>Unite rails/lib<CR>
nnoremap Rp :<C-u>Unite rails/public<CR>
nnoremap Rj :<C-u>Unite rails/javascript<CR>
nnoremap Rf :<C-u>Unite rails/public -input=framework/<CR>
nnoremap Rs :<C-u>Unite rails/spec<CR>

let g:unite_source_menu_menus = {
      \   "shortcut" : {
      \       "description" : "unite-menu",
      \       "command_candidates" : [
      \           ["svn commit",   "UniteSvnDiff"],
      \           ["file mru",     "Unite neomru/file"],
      \           ["unite",        "UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file"],
      \           ["register",     "Unite -buffer-name=register register"],
      \           ["edit vimrc",   "edit $MYVIMRC"],
      \           ["source vimrc", "source $MYVIMRC"],
      \           ["console",      "VimConsoleOpen"],
      \           ["console redraw", "VimConsoleRedraw"],
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
      \ }

let s:action = {
      \ 'description' : 'open with dwm',
      \ 'is_selectable' : 1,
      \ }
function! s:action.func(candidates)
  for l:candidate in a:candidates
    if bufexists(l:candidate.action__path)
      let l:winnr = bufwinnr(l:candidate.action__path)

      if l:winnr == -1
        call DWM_Stack(1)
        split
        call unite#take_action('open', l:candidate)
        call DWM_AutoEnter()
      else
        exec l:winnr . "wincmd w"
        call DWM_AutoEnter()
      endif
    else
      call DWM_New()
      call unite#take_action("open", l:candidate)
    endif
  endfor

  call CleanEmptyBuffers()
endfunction
call unite#custom_action('openable', 'dwm_open', s:action)
call unite#custom#default_action("file", "dwm_open")
unlet s:action

function! CleanEmptyBuffers()
  let l:i = 0
  let l:n = bufnr('$')
  let l:bufs = []

  while l:i <= l:n
    if bufexists(l:i) && empty(bufname(l:i)) && buflisted(l:i)
      call add(l:bufs, l:i)
    endif
    let l:i += 1
  endwhile

  if len(l:bufs) > 0
    exe 'bdelete' join(l:bufs)
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
""" search and anzu
""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch
set hlsearch

nnoremap <silent> <Esc><Esc> :set hlsearch!<CR>:echo<CR>
map  n <Plug>(anzu-n-with-echo)zz
map  N <Plug>(anzu-N-with-echo)zz
nmap * :set hlsearch<CR>zz<Plug>(anzu-star-with-echo)
nmap # :set hlsearch<CR>zz<Plug>(anzu-sharp-with-echo)
let g:anzu_no_match_word = '%#ErrorMsg#Pattern not found: %p'

vnoremap * "zy:let @/ = @z<CR>n

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
  call DWM_New()
  silent! setlocal ft=diff nobackup noswf nobuflisted nowrap buftype=nofile
  exe "read !LANG=C " . a:type . " diff"
  setlocal nomodifiable
  goto 1
  exe "silent! Unite versions/" . a:type . "/status"
endfunction
command! -nargs=0 UniteSvnDiff call s:UniteVersionsWithDiff("svn")
command! -nargs=0 UniteGitDiff call s:UniteVersionsWithDiff("git")

let g:versions#type#svn#status#ignore_status = [
  \  "X"
  \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""
""" gist
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1

""" vimux

let g:VimuxRunnerIndex = 2
let g:VimuxUseNearest = 0
let g:VimuxResetSequence = ""
let g:vimux_ruby_clear_console_on_run = 0

nmap <leader>t :RunRailsFocusedTest<CR>
nmap <leader>T :RunAllRailsTest<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" LineDiff
""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <leader>d :Linediff<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""" vundle
""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif
filetype off
set runtimepath+=~/.config/nvim/dein.vim

if dein#load_state(expand('~/.config/nvim/dein'))
  call dein#begin(expand('~/.config/nvim/dein'))
  call dein#load_toml(expand('~/.config/nvim/dein.toml'), {'lazy': 0})
  call dein#load_toml(expand('~/.config/nvim/dein.lazy.toml'), {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if !has("gui_running")
  set runtimepath+=~/.config/nvim/local.vim
  " TO Clean disused repos: call map(dein#check_clean(), "delete(v:val, 'rf')")
  if localvim#time_elapsed( 'update', 24 * 60 * 60 )
    call localvim#save_time_state( 'update' )
    call dein#update()
  elseif dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on

let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" basics
""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=0
set autoindent
set wrap
set wrapscan
set breakindent

try
  set wildmenu
endtry

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
set fileencodings=utf-8,cp932,euc-jp

set suffixesadd+=.js

" setting for ambiguous characters
" on Mac Terminal.app, use with https://github.com/Nyoho/TerminalEastAsianAmbiguousClearer
set ambiwidth=double
set display+=lastline

if $TERM != "screen"
  set clipboard=unnamed
endif

set maxmempattern=10000

set exrc
set secure


""""""""""""""""""""""""""""""""""""""""""""""""""
""" paste ...
""""""""""""""""""""""""""""""""""""""""""""""""""
" https://dev.classmethod.jp/tool/trouble-shoot-ctrlv-in-vim/
set nocompatible
map ^[OA ^[ka
map ^[OB ^[ja
map ^[OC ^[la
map ^[OD ^[ha


""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
let loaded_matchparen = 1

" insert tab
inoremap <S-Tab> <C-V><Tab>

" yank from cursol to the end of line
nnoremap Y y$

au FileType ruby,eruby vmap <leader>r :s/:\([^ ]*\) *=> /\1: /gc<CR>

nnoremap <leader>j :Jq<CR>

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "normal! ^v$"
    execute "normal! :"
    execute "'<,'>! jq \"" . l:arg . "\""
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
""" deoplete.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
      \ 'auto_complete': v:true,
      \ 'auto_complete_delay': 0,
      \ 'auto_complete_popup': 'auto',
      \ 'auto_reflesh_delay': 50,
      \ 'camel_case': v:true,
      \ 'smart_case': v:true,
      \ })

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
""" denite.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap Uu :<C-u>Denite file_mru -split=floating_relative_cursor -vertical-preview -floating-preview -preview-width=80<CR>
nnoremap Ud :<C-u>DeniteBufferDir file -split=floating_relative_cursor -vertical-preview -floating-preview -preview-width=80<CR>
nnoremap UD :<C-u>Denite file -split=floating_relative_cursor -vertical-preview -floating-preview -preview-width=80<CR>
nnoremap Ub :<C-u>Denite buffer -split=floating_relative_cursor -vertical-preview -floating-preview -preview-width=80<CR>
nnoremap Uo :<C-u>Denite outline -split=floating_relative_cursor<CR>
nnoremap U/ :<C-u>Denite line:all -split=floating_relative_cursor<CR>

function! s:tileropen(context)
  " if 'file' == a:context.targets[0].kind
    for target in a:context.targets
      execute 'TilerOpen ' . target.action__path
    endfor
  " else
  "   PP(a:context)
  "   return call denite#do_action(a:context, a:context.default_action, a:context.targets)
  " endif
endfunction
" call denite#custom#action('buffer,directory,file,openable', 'tiler', function('s:tileropen'))
call denite#custom#action('buffer,file', 'tiler', function('s:tileropen'))

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tiler')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
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
""" emmet-vim
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_zen_settings = { 'indentation' : '  ' }


""""""""""""""""""""""""""""""""""""""""""""""""""
""" alignta.vim
""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leader>a :Alignta =><CR>


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
""" LineDiff
""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <leader>d :Linediff<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" ale
""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:ale_linters = {}
" let g:ale_fixers = {}

let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_completion_enabled = 1

let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_fix_on_save = 1

nmap <leader>a :ALEDetail<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_version_warning = 0
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

""""""""""""""""""""""""""""""""""""""""""""""""""
""" window manager / tiler.vim
""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-j> <C-w>w
nmap <C-k> <C-w>W
nmap <C-n> <C-w>v
nmap <C-s> <C-w>s
nmap <C-c> <C-w>c

nmap <C-w>n <plug>TilerNew
nmap <C-w>v <plug>TilerNew
nmap <C-w>s <plug>TilerNew
nmap <C-w>c <plug>TilerClose
nmap <C-space> <plug>TilerRotateForwards


""""""""""""""""""""""""""""""""""""""""""""""""""
""" git-messenger.vim
""""""""""""""""""""""""""""""""""""""""""""""""""

nmap gm <Plug>(git-messenger)


""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-terraform
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:terraform_align=1
let g:terraform_fmt_on_save=1


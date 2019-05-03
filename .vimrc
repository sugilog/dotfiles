""""""""""""""""""""""""""""""""""""""""""""""""""
""" vundle
""""""""""""""""""""""""""""""""""""""""""""""""""

if &compatible
  set nocompatible
endif
filetype off
set runtimepath+=~/dotfiles/dein.vim

if dein#load_state(expand('~/.vim/dein'))
  call dein#begin(expand('~/.vim/dein'))
  call dein#load_toml(expand('~/dotfiles/dein.toml'),      {'lazy': 0})
  call dein#load_toml(expand('~/dotfiles/dein_lazy.toml'), {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if !has("gui_running")
  set runtimepath+=~/dotfiles/local.vim
  " TO Clean disused repos: call map(dein#check_clean(), "delete(v:val, 'rf')")
  if localvim#time_elapsed( 'update', 24 * 60 * 60 )
    call localvim#save_time_state( 'update' )
    call dein#update()
  elseif dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on

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
set showtabline=2

if $TERM != "screen"
  set clipboard=unnamed
endif

set maxmempattern=10000

set exrc
set secure

""""""""""""""""""""""""""""""""""""""""""""""""""
""" Others
""""""""""""""""""""""""""""""""""""""""""""""""""
let loaded_matchparen = 1

" insert tab
inoremap <S-Tab> <C-V><Tab>

" yank from cursol to the end of line
nnoremap Y y$

au FileType ruby vmap <leader>r :s/:\([^ ]*\)\( *\)=> /\1:\2/gc<CR>

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
""" neocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""
if has('lua')
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
""" denite.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap Uu :<C-u>Denite file_mru<CR>
nnoremap Ud :<C-u>DeniteBufferDir file<CR>
nnoremap UD :<C-u>Denite directory file<CR>
nnoremap Ub :<C-u>Denite buffer<CR>
nnoremap Uo :<C-u>Denite outline<CR>
nnoremap U/ :<C-u>Denite line:all<CR>

au FileType denite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType denite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

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
""" vim-rubytest
""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rubytest_in_quickfix = 1

function! SwitchRubytest()
  if glob("Gemfile") == "Gemfile"
    let g:rubytest_cmd_test = "bundle exec rails test %p"
    let g:rubytest_cmd_testcase = "bundle exec rails test %p -n '/%c/'"
    let g:rubytest_cmd_spec = "bundle exxec rspec -f specdoc %p"
    let g:rubytest_cmd_example = "bundle exec rspec -f specdoc %p -e '%c'"
  else
    let g:rubytest_cmd_test = "ruby %p"
    let g:rubytest_cmd_testcase = "ruby %p -n '/%c/'"
    let g:rubytest_cmd_spec = "spec -f specdoc %p"
    let g:rubytest_cmd_example = "spec -f specdoc %p -e '%c'"
  endif
endfunction
autocmd BufNewFile,BufRead *.rb :call SwitchRubytest()

au FileType ruby nmap <Leader>t <Plug>RubyTestRun
au FileType ruby nmap <Leader>T <Plug>RubyFileRun


""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)


""""""""""""""""""""""""""""""""""""""""""""""""""
""" LineDiff
""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <leader>d :Linediff<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" tab
""""""""""""""""""""""""""""""""""""""""""""""""""

" The prefix key.
" nnoremap [Tag] <Nop>
" nmap     t [Tag]

for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'

  if has("gui_running")
    execute 'nnoremap <D-'.n.'> :tabn '.n.'<CR>'
  endif
endfor

map <silent> tc :tablast <bar> tabnew<CR>
map <silent> tx :tabclose<CR>
map <silent> tn :tabnext<CR>
map <silent> tp :tabprevious<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
""" ale
""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:ale_linters = {}
" let g:ale_fixers = {}

let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
let g:ale_completion_enabled = 1

let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_fix_on_save = 1

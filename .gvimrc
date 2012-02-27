""""""""""""""""""""""""""""""""""""""""""""""""""
""" for macvim
""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_macvim')
  colorscheme torte
  set imdisable
  set nobackup
  set visualbell t_vb=
  set antialias
  set showtabline=2
  set guioptions-=T
  set guifont=Ricty:h13
  " http://code.google.com/p/macvim-kaoriya/wiki/Readme
  set transparency=20
  " http://vim-users.jp/2011/10/hack234/
  augroup hack234
    autocmd!
    if has('mac')
      autocmd FocusGained * set transparency=20
      autocmd FocusLost * set transparency=40
    endif
  augroup END

  autocmd NeoComplCacheDisable
endif

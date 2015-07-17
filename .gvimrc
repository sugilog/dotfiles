""""""""""""""""""""""""""""""""""""""""""""""""""
""" for macvim
""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_macvim')
  colorscheme molokai
  set imdisable
  set nobackup
  set visualbell t_vb=
  set antialias
  set showtabline=2
  set guioptions-=T
  set guifont=Ricty:h13
  " http://code.google.com/p/macvim-kaoriya/wiki/Readme
  set transparency=20

  set lines=100 columns=180

  autocmd NeoComplCacheDisable
endif

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

  " set printencoding=utf-8
  set printfont=Ricty:h11

  " set printmbcharset=JIS_X_1990
  set printmbfont=r:Ricty,b:Ricty

  set printoptions=number:y,wrap:y,duplex:off,collate:y,portrait:y,paper:A4,syntax:n,left:3pc,right:3pc,top:5pc,bottom:5pc

  autocmd NeoComplCacheDisable
endif

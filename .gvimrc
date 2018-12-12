""""""""""""""""""""""""""""""""""""""""""""""""""
""" for macvim
""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_macvim')
  colorscheme molokai
  highlight Normal guibg=#002f51
  highlight LineNr guibg=#002f51
  set imdisable
  set nobackup
  set visualbell t_vb=
  set antialias
  set showtabline=2
  set guioptions-=T
  set guifont=Ricty:h13
  " http://code.google.com/p/macvim-kaoriya/wiki/Readme
  set transparency=65

  set lines=100 columns=180

  nnoremap <D-t> :tabnew<CR>
  macm File.Open\.\.\. key=<D-o> action=fileOpen:
  macm File.Close      key=<D-w> action=performClose:

  macm Edit.Cut<Tab>"+x       key=<D-x> action=cut:
  macm Edit.Copy<Tab>"+y      key=<D-c> action=copy:
  macm Edit.Paste<Tab>"+gP    key=<D-v> action=paste:
endif

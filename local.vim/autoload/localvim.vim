let g:localvim_time_cachefile = "~/.vim/local.time.cache"

function! localvim#load( filepath )
  if filereadable( a:filepath )
    return readfile( a:filepath )
  else
    throw printf( "No such file `%s'", a:filepath )
  endif
endfunction

function! localvim#newfile( filepath )
  echo printf( "Create new file `%s'", a:filepath )
  call writefile( [], a:filepath )
endfunction

function! localvim#convert_cache( list )
  let converted = {}
  for item in a:list
    let cache = eval( item )
    let converted[ cache[ 0 ] ] = cache[ 1 ]
  endfor
  return converted
endfunction

function! localvim#convert_cache_list( dict )
  let converted = []
  for key in keys( a:dict )
    let cache = string( [ key, a:dict[ key ] ] )
    call add( converted, cache )
  endfor
  return converted
endfunction

function! localvim#time_elapsed( key, threshold )
  let filepath = expand( g:localvim_time_cachefile )

  try
    let cache = localvim#convert_cache( localvim#load( filepath ) )
  catch
    echo v:exception
    call localvim#newfile( filepath )
    let cache = {}
  endtry

  let now = localtime()
  let past = get( cache, a:key, now )

  return ( now - past ) > a:threshold
endfunction

function! localvim#save_time_state( key )
  let filepath = expand( g:localvim_time_cachefile )

  try
    let cache = localvim#convert_cache( localvim#load( filepath ) )
  catch
    echo v:exception
    call localvim#newfile( filepath )
    let cache = {}
  endtry

  let cache[ a:key ] = localtime()
  call writefile( localvim#convert_cache_list( cache ), filepath )
endfunction

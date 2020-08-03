function! Spec(bang)
  " attempt to find the project root
  let l:root = finddir('.git', '.;')

  " if no root, exit
  if empty(l:root)
    echohl Error | echo 'Not a git project' | echohl None
    return
  endif

  " find all spec files
  let l:files = glob(fnamemodify(l:root, ':h') . '/**/*' . expand('%:r') . '.{spec,test}.' . expand('%:e'), 1, 1)

  if empty(l:files)
    echohl Error | echo 'No spec' | echohl None
    return
  endif

  " if we only have a file, jump to it immediately
  if len(l:files) == 1
    execute 'edit' . a:bang l:files[0]
    return
  endif

  " otherwise, show a picker
  let l:choice = inputlist(['Multiple specs:'] + map(copy(l:files), 'v:key+1 . ": " . v:val'))

  if l:choice > 0
    execute 'edit' . a:bang l:files[l:choice-1]
  endif
endfunction

" jump to spec
command! -bang Spec :call Spec('<bang>')


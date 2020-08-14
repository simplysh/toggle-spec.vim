function! Spec(bang)
  " attempt to find the project root
  let l:root = finddir('.git', '.;')

  " if no root, exit
  if empty(l:root)
    echohl Error | echo 'Not a git project' | echohl None
    return
  endif

  " read all the top-level directories
  let l:base = fnamemodify(l:root, ':h:h')
  let l:dirs = join(filter(globpath(l:base, '*', 0, 1), {_, name -> isdirectory(name)}), ',')

  " find all spec files
  " only recurse through toplevel directories
  let l:files = globpath(l:base, expand('%:r') . '.test.' . expand('%:e'), 0, 1)
        \+ globpath(l:base, expand('%:r') . '.spec.' . expand('%:e'), 0, 1)
        \+ globpath(l:dirs, '**/' . expand('%:r') . '.test.' . expand('%:e'), 0, 1)
        \+ globpath(l:dirs, '**/' . expand('%:r') . '.spec.' . expand('%:e'), 0, 1)

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


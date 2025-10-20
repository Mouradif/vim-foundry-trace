" Detect Foundry traces by filename or by content
augroup foundry_trace_ftdetect
  autocmd!
  " Common extensions
  autocmd BufRead,BufNewFile *.trace,*.foundrytrace setfiletype foundry-trace

  " Heuristic: lines that look like Foundry traces
  autocmd BufReadPost * if &ft ==# '' |
        \   if getline(1) =~# '^\s*\[\d\+\]\s\h\w\+::' ||
        \      search('^\s*[│├└].\s\[\d\+\]\s\%(\x\{40}\|0x\)', 'nw') > 0 ||
        \      search('^.\{-}← \[\%(\u\l\+\)\]', 'nw') > 0
        \   |   setfiletype foundry-trace
        \   | endif
        \ | endif
augroup END

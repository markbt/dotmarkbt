
hi def link cSubType mbtSubType

let s:tagfile = findfile("tags", ".;")
if !empty(s:tagfile)
  let s:tagvim = substitute(s:tagfile, "tags$", ".tags.vim", "")
endif

function! s:UpdateTagSyntax()
  if !empty(s:tagfile) && !empty(s:tagvim)
    let l:tagfiletime = getftime(s:tagfile)
    let l:tagvimtime = getftime(s:tagvim)
    if l:tagfiletime > l:tagvimtime && l:tagfiletime != -1
      call system("python ".$HOME."/.markbt/vim/utils/types_from_tags.py > ".s:tagvim)
    endif
    execute "source ".s:tagvim
  endif
endfunction

call s:UpdateTagSyntax()

syn match mbtTrailSpace /\s\+$/

let &colorcolumn="80,100,120"



hi def link cSubType mbtSubType

let s:tagfile = findfile("tags", ".;")
let s:tagvim = findfile(".tags.vim", ".;")
if empty(s:tagvim)
  let s:tagvim = substitute(s:tagfile, "tags$", ".tags.vim", "")
endif

function! s:UpdateTagSyntax()
  let l:tagfiletime = getftime(s:tagfile)
  let l:tagvimtime = getftime(s:tagvim)
  if l:tagfiletime > l:tagvimtime
    call system("python ".$HOME."/.markbt/vim/utils/types_from_tags.py > ".s:tagvim)
  endif
  execute "source ".s:tagvim
endfunction

call s:UpdateTagSyntax()

syn match mbtTrailSpace /\s\+$/

let &colorcolumn="80,100,120"



set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "markbt"

function! s:H(group, gfg, gbg, gstyle, cfg, cbg, cstyle, tfg, tbg, tstyle)

  if empty(a:group)
    return
  endif

  if &t_Co == 8

    let l:cmd = ""
    if !empty(a:tfg)
      let l:cmd = l:cmd." ctermfg=".a:tfg
    endif
    if !empty(a:tbg)
      let l:cmd = l:cmd." ctermbg=".a:tbg
    endif
    if !empty(a:tstyle)
      let l:cmd = l:cmd." cterm=".a:tstyle
    endif

    if l:cmd != ""
      execute "hi ".a:group.l:cmd
    endif

  else

    let l:cmd = ""
    if !empty(a:cfg)
      let l:cmd = l:cmd." ctermfg=".a:cfg
    endif
    if !empty(a:cbg)
      let l:cmd = l:cmd." ctermbg=".a:cbg
    endif
    if !empty(a:cstyle)
      let l:cmd = l:cmd." cterm=".a:cstyle
    endif
    if !empty(a:gfg)
      let l:cmd = l:cmd." guifg=".a:gfg
    endif
    if !empty(a:gbg)
      let l:cmd = l:cmd." guibg=".a:gbg
    endif
    if !empty(a:gstyle)
      let l:cmd = l:cmd." gui=".a:gstyle
    endif
    if l:cmd != ""
      execute "hi ".a:group.l:cmd
    endif

  endif

endfunction

" CRGB (range 0..5)
function! s:CRGB(r, g, b)
  return a:r * 36 + a:g * 6 + a:b + 16
endfunction

" CGREY (range 0..23)
function! s:CGREY(grey)
  return a:grey + 232
endfunction

call s:H("Normal",       "", "", "",            s:CGREY(20), "", "",                    "", "", "")
call s:H("ColorColumn",  "", "", "",            "", s:CGREY(2), "",                     "", "", "")
call s:H("StatusLine",   "", "", "",            "0", s:CRGB(0,4,5), "NONE",             "6", "", "")
call s:H("Visual",       "", "", "",            "", s:CGREY(4), "",                     "", "", "")

call s:H("CursorLine",   "", "", "",            "", s:CGREY(4), "NONE",                 "", "", "")
call s:H("CursorColumn", "", "", "",            "", s:CGREY(2), "NONE",                 "", "", "")
call s:H("MatchParen",   "", "", "",            "", s:CRGB(0,1,1), "",                  "", "", "")

call s:H("Folded",       "", "", "",            "", s:CGREY(4), "",                             "", "", "")

call s:H("LineNr",       "", "", "",            s:CGREY(8), s:CGREY(4), "NONE",         "7", "8", "reverse")
call s:H("CursorLineNr", "", "", "",            "", s:CGREY(6), "NONE",                 "", "", "")

call s:H("IncSearch",    "", "", "",            s:CRGB(0,0,0), s:CRGB(1,1,0), "NONE",   "", "", "")
call s:H("Search",       "", "", "",            s:CRGB(0,0,0), s:CRGB(3,1,0), "NONE",   "", "", "")

call s:H("DiffAdd",      "", "", "",            "", s:CRGB(0,0,2), "",                  "", "", "")
call s:H("DiffChange",   "", "", "",            "", s:CRGB(0,0,1), "",                  "", "", "")
call s:H("DiffDelete",   "", "", "",            "0", s:CRGB(1,0,0), "",                 "", "", "")
call s:H("DiffText",     "", "", "",            "NONE", s:CRGB(1,0,1), "",              "", "", "")

call s:H("TabLineSel",   "", "", "",            "11", "", "",                           "", "", "")

call s:H("",             "", "", "",            "", "", "",                             "", "", "")

call s:H("Comment",      "#808080", "", "",     s:CGREY(10), "", "",                    "0", "", "bold")

call s:H("Type",         "", "", "",            s:CRGB(1,5,1), "", "",                  "", "", "")
call s:H("mbtSubType",   "", "", "",            s:CRGB(0,3,0), "", "",                  "2", "", "NONE")

delfunction s:H   
delfunction s:CRGB
delfunction s:CGREY


hi def link cSubType mbtSubType

for subtype in systemlist("python ".$HOME."/.markbt/vim/util/types_from_tags.py")
  execute "syn keyword cSubType ".subtype
endfor


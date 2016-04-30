
hi def link cSubType mbtSubType

for subtype in split(system("python ".$HOME."/.markbt/vim/utils/types_from_tags.py"), '\n')
  execute "syn keyword cSubType ".subtype
endfor


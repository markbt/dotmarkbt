
"syn region cppTemplate start="<" end=">" contains=TOP transparent
"syn match cppTemplateParam "[a-zA-Z_][a-zA-Z_0-9]*" contained containedin=NONE,cppTemplate
"hi def link cppTemplateParam mbtTemplate


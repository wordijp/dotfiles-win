syn keyword cppNo false
syn keyword cppYes true

syn match cppNoWrong /!==\|!!!/ containedin=ALL
syn match cppYesWrong /===/ containedin=ALL
syn match cppNo /!=/ containedin=ALL
" syntaxÉGÉâÅ[ëŒçÙ
syn match cppNo2 /[^!]!.\+)/hs=s+1,he=s+2 containedin=ALL
syn match cppNo3 /[^!]!/hs=s+1 containedin=ALL
syn match cppYes /==\|!!/ containedin=ALL
hi link cppNoWrong  Error
hi link cppYesWrong Error
hi link cppNo		No
hi link cppNo2		No
hi link cppNo3		No
hi link cppYes		Yes

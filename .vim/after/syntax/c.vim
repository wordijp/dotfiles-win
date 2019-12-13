syn keyword cNo false
syn keyword cYes true

syn match cNoWrong /!==\|!!!/ containedin=ALL
syn match cYesWrong /===/ containedin=ALL
syn match cNo /!=/ containedin=ALL
" syntaxÉGÉâÅ[ëŒçÙ
syn match cNo2 /[^!]!/hs=s+1,he=s+2 containedin=ALL
syn match cNo3 /(!.\+)/hs=s+1,he=s+2 containedin=ALL
syn match cYes /==\|!!/ containedin=ALL
hi link cNoWrong  Error
hi link cYesWrong Error
hi link cNo		No
hi link cNo2		No
hi link cNo3		No
hi link cYes		Yes

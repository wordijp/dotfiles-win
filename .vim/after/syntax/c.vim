syn keyword cNo false
syn keyword cYes true

syn match cNo /!=\?/ containedin=CONTAINED
syn match cYes /==\|!!/ containedin=CONTAINED
syn match cNoWrong /!==\|!!!/ containedin=CONTAINED
syn match cYesWrong /===/ containedin=CONTAINED

hi link cNo		No
hi link cYes		Yes
hi link cNoWrong  Error
hi link cYesWrong Error

syn keyword rbNo false
syn keyword rbYes true

syn match rbNo /!=\?/ containedin=CONTAINED
syn match rbYes /===\?\|!!/ containedin=CONTAINED
syn match rbNoWrong /!==\|!!!/ containedin=CONTAINED
syn match rbYesWrong /====/ containedin=CONTAINED

hi link rbNo		No
hi link rbYes		Yes
hi link rbNoWrong  Error
hi link rbYesWrong Error

syn keyword rbNo false
syn keyword rbYes true

syn match rbNoWrong /!==\|!!!/ containedin=ALL
syn match rbYesWrong /====/ containedin=ALL
syn match rbNo /!=/ containedin=ALL
syn match rbNo2 /[^!]!/hs=s+1 containedin=ALL
syn match rbYes /===\|!!/ containedin=ALL
syn match rbYes2 /[^!]==/hs=s+1 containedin=ALL
hi link rbNoWrong  Error
hi link rbNo		No
hi link rbNo2		No
hi link rbYesWrong Error
hi link rbYes		Yes
hi link rbYes2		Yes

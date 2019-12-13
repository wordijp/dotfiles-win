syn keyword     goConstants         iota nil
syn keyword goNo false
syn keyword goYes true
syn keyword goErr err

syn match goNoWrong /!==\|!!!/ containedin=ALL
syn match goYesWrong /===/ containedin=ALL
syn match goYes /==\|!!/ containedin=ALL
syn match goNo /!=/ containedin=ALL
syn match goNo2 /[^!]!/hs=s+1 containedin=ALL
hi link goNoWrong  Error
hi link goYesWrong Error
hi link goYes		Yes
hi link goNo		No
hi link goNo2		No
hi link goConstants Constant
" http://yuroyoro.hatenablog.com/entry/2014/08/12/144157
hi link goErr      goError

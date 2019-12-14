syn keyword     goConstants         iota nil
syn keyword goNo false
syn keyword goYes true
syn keyword goErr err

syn match goNo /!=\?/ containedin=CONTAINED
syn match goYes /==\|!!/ containedin=CONTAINED
syn match goNoWrong /!==\|!!!/ containedin=CONTAINED
syn match goYesWrong /===/ containedin=CONTAINED

hi link goConstants Constant
hi link goNo		No
hi link goYes		Yes
hi link goNoWrong  Error
hi link goYesWrong Error
" http://yuroyoro.hatenablog.com/entry/2014/08/12/144157
hi link goErr      goError

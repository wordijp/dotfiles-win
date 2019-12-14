syn keyword jsNo false
syn keyword jsYes true

syn match jsNo /!=\?=\?/ containedin=CONTAINED
syn match jsYes /===\?\|!!/  containedin=CONTAINED
syn match jsNoWrong /!===\|!!!/ containedin=CONTAINED
syn match jsYesWrong /====/  containedin=CONTAINED

hi link jsNo		No
hi link jsYes		Yes
hi link jsNoWrong  Error
hi link jsYesWrong Error
" vim-javascriptëŒçÙ
hi link jsBooleanFalse         No
hi link jsBooleanTrue          Yes

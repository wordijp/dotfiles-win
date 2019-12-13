syn keyword cppNo false
syn keyword cppYes true

syn match cppNoWrong /!===\|!!!/ containedin=ALL
syn match cppYesWrong /====/ containedin=ALL
syn match cppNo /!==\|!=/ containedin=ALL
syn match cppNo2 /[^!]!/hs=s+1 containedin=ALL
syn match cppYes /===\|!!/ containedin=ALL
syn match cppYes2 /[^!]==/hs=s+1 containedin=ALL
hi link cppNoWrong  Error
hi link cppNo		No
hi link cppNo2		No
hi link cppYesWrong Error
hi link cppYes		Yes
hi link cppYes2		Yes
" vim-javascriptëŒçÙ
hi link jsBooleanFalse         No
hi link jsBooleanTrue          Yes

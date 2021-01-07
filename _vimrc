
"----------------------
" 編集に関する設定: {{{
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,utf-16le
set fileformats=unix,dos,mac
augroup dosbatch_settings
  au!
  au FileType dosbatch set fenc=cp932
  au FileType dosbatch set fileformat=dos
augroup END
" ヤンクしたテキストをそのままクリップボードへ
set clipboard+=unnamed

augroup fold_settings
  au!
  au FileType * set foldmethod=indent
  au FileType vim set foldmethod=marker
augroup END
set foldlevel=100 "Don't autofold anything

" 貼り付け自にyankされるのを防ぐ
vnoremap <silent> <C-p> "0p
"inoremap <silent> <C-v> <ESC>pa
" ヤンク方法に影響されない、インデントの深さに合わせた貼り付け
inoremap <silent><C-v> <Space><BS><ESC>:call <SID>trimRegContents()<CR>]p
function! s:trimRegContents()
  let v = getreg(v:register, 1, 1)
  let v[0] = trim(v[0], 0, 1)
  let e = len(v) - 1
  if e > 0 && v[e] == '' | unlet v[e] | endif
  call setreg(v:register, v, 'v')
endfunction

" 改行でコメントを入れない
autocmd FileType * setlocal formatoptions-=ro
" C++11用
" ※({ の時にインデントが上手く働かないので
set noautoindent
" バックアップファイルの設定
set backupdir=$HOME/.vim/tmp/backupfiles
" viminfoファイルの設定
set viminfo+=n~/.vim/tmp/_viminfo
" タブサイズ
set tabstop=4
" タブを挿入する時の幅
set shiftwidth=4
" タブをタブとして扱う(スペースに展開しない)
set noexpandtab
" 折り返し OFF
set nowrap
" undoファイルを作らない
set noundofile
" swpを作らない
set noswapfile
" 不要と感じたエラー音をOFF
set belloff+=ctrlg
" 検索時の現在番号を表示
set shortmess-=S
" }}}

"-----------------------------------
" GUI固有ではない画面表示の設定: {{{
" メニューは使わない
set guioptions+=M
set guioptions-=m

set conceallevel=2 concealcursor=i

" 目印をnumberカラムに表示する
set signcolumn=number
" }}}


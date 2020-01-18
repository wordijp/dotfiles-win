
"----------------------
" 編集に関する設定: {{{
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,utf-16le
set fileformats=unix,dos,mac
au FileType dosbatch set fenc=cp932
au FileType dosbatch set fileformat=dos
" ヤンクしたテキストをそのままクリップボードへ
set clipboard+=unnamed

au FileType * set foldmethod=indent
au FileType vim set foldmethod=marker
set foldlevel=100 "Don't autofold anything

" 貼り付け自にyankされるのを防ぐ
vnoremap <silent> <C-p> "0p
inoremap <silent> <C-v> <ESC>pa
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


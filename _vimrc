
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
autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

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

vnoremap zm :call <SID>rangeFoldZM()<CR>
function! s:rangeFoldZM() range
  " type: [lnum, col]
  let l:start_cursor = getpos("'<")[1:2]
  let l:end_cursor = getpos("'>")[1:2]

  let l:max_foldlevel = max(map(range(a:firstline, a:lastline), '(foldclosed(v:val) < 0) ? foldlevel(v:val) : -1'))
  call map(range(a:firstline, a:lastline),'foldclosed(v:val) < 0 && foldlevel(v:val) == l:max_foldlevel ? execute("normal! ".v:val."Gzc") : 0')

  call cursor(l:start_cursor)
  silent execute "normal! v"
  call cursor(l:end_cursor)
endfunction

vnoremap zr :call <SID>rangeFoldZR()<CR>
function! s:rangeFoldZR() range
  let l:start_cursor = getpos("'<")[1:2]
  let l:end_cursor = getpos("'>")[1:2]

  let l:min_foldlevel = min(map(range(a:firstline, a:lastline), '(foldclosed(v:val) > 0) ? foldlevel(v:val) : 99999'))
  call map(range(a:firstline, a:lastline), 'foldclosed(v:val) > 0 && foldlevel(v:val) == l:min_foldlevel ? execute("normal! ".v:val."Gzo") : 0')

  call cursor(l:start_cursor)
  silent execute "normal! v"
  call cursor(l:end_cursor)
endfunction

" v[count]iBの逆版
vnoremap B :<C-u>call <SID>vNiB(v:count)<CR>
function! s:vNiB(count) range
  let l:n = max([1, s:blocklevel()-a:count])
  execute 'normal! v'.l:n.'iB'
endfunction

function! s:blocklevel() range
  " NOTE: getposの更新
  execute "normal! v\<ESC>"
  let l:start = s:get_position()

  let l:level = 0
  while 1
    let l:next = s:get_NiB_position(l:level + 1)
    if l:next.eq(l:start)
      break
    endif

    let l:level += 1
  endwhile

  return l:level
endfunction

function! s:get_NiB_position(N)
  let l:winview = winsaveview()
  
  execute 'normal! v'
  execute 'silent! normal '.a:N.'iB'
  execute "normal! \<ESC>"
  let l:ret = s:get_position()

  call winrestview(l:winview)
  return l:ret
endfunction

function! s:get_position()
  let l:pos = {
    \ 'start': getpos("'<")[1:2],
    \ 'end': getpos("'>")[1:2],
    \ }
  function! l:pos.eq(o)
    return self['start'] == a:o['start'] && self['end'] == a:o['end']
  endfunction
  
  return l:pos
endfunction

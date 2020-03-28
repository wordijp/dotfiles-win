scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version gvimrc file.
" 日本語版のデフォルトGUI設定ファイル(gvimrc) - Vim 8.1
"
" Last Change: 27-Dec-2018.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、GUI関連の設定が書かれていま
" す。編集時の挙動に関する設定はvimrcに書かかれています。
"
" 個人用設定は_gvimrcというファイルを作成しそこで行ないます。_gvimrcはこの
" ファイルの後に読込まれるため、ここに書かれた内容を上書きして設定することが
" 出来ます。_gvimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIM
" よりも優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/gvimrc_local.vim)が存在するならば、本設
" 定ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:gvimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help gvimrc
"   :echo $HOME
"   :echo $VIM
"   :version

" このgvimrcだけ使用する
let g:gvimrc_first_finish = 1

"let g:molokai_original = 1
" 共通

" カラースキーム {{{
au VimEnter * call timer_start(0, function('s:changeColorschemeLazy'))
function! s:changeColorschemeLazy(_)
  if &ft == 'python'
    call s:ifNeedColorScheme('darkblue')
  elseif &ft == 'cs'
    call s:ifNeedColorScheme('slate')
  elseif &ft == 'markdown'
    call s:ifNeedColorScheme('peachpuff')
  else
    call s:ifNeedColorScheme('desert')
  end
endfunction

function! s:ifNeedColorScheme(scheme)
  if get(g:, 'colors_name', '') != a:scheme
    execute 'ColorScheme ' . a:scheme
  end
endfunction

syntax on

command! -nargs=1 ColorScheme call ColorScheme(<f-args>)
function! ColorScheme(scheme)
  execute 'colorscheme ' . a:scheme
  try
    execute 'colorscheme ' . a:scheme.'_after'
  catch
  endtry
endfunction
" }}}

" 非アクティブの色を暗めにする
autocmd ColorScheme * highlight NormalNC guifg=#a0a0a0 guibg=#121212
autocmd WinEnter,BufWinEnter * setlocal wincolor=
autocmd WinLeave * setlocal wincolor=NormalNC
" エディタがフォーカス失った時も暗めにする
autocmd FocusGained * setlocal wincolor=
autocmd FocusLost * setlocal wincolor=NormalNC

" カーソル位置の表示 {{{
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI * call Auto_cursorline('CursorMoved')
    "autocmd CursorHold,CursorHoldI * call Auto_cursorline('CursorHold')
    autocmd WinEnter * call Auto_cursorline('WinEnter')
    autocmd WinLeave * call Auto_cursorline('WinLeave')
    
    " 強制で表示
    nnoremap <silent><Space>c :call Force_cursormoved()<CR>
    function! Force_cursormoved()
	setlocal cursorline
	setlocal cursorcolumn
	let g:cursorline_lock = 1
    endfunction

    let g:cursorline_lock = 0
    function! Auto_cursorline(event)
        if a:event ==# 'WinEnter'
            setlocal cursorline
            setlocal cursorcolumn
            let g:cursorline_lock = 2
        elseif a:event ==# 'WinLeave'
            setlocal nocursorline
            setlocal nocursorcolumn
        elseif a:event ==# 'CursorMoved'
            if g:cursorline_lock
                if 1 < g:cursorline_lock
                    let g:cursorline_lock = 1
                else
                    setlocal nocursorline
                    setlocal nocursorcolumn
                    let g:cursorline_lock = 0
                endif
            endif
        elseif a:event ==# 'CursorHold'
            setlocal cursorline
            setlocal cursorcolumn
            let g:cursorline_lock = 1
        endif
    endfunction
augroup END
" }}}

" mswin.vim {{{
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" CTRL-S are Save
noremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>gi
" }}}


" ウインドウの位置とサイズを記憶する {{{
let g:save_window_file = expand('~/.vim/tmp/_vimwinpos')
" 終了時に設定ファイルへ書きこむ
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END


" 起動時に設定ファイルがあれば読み込む
if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
" }}}

" 追加ここまで -------------------------------------------------------------
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/gvimrc_local.vim)があれば読み込む。読み込んだ後
" に変数g:gvimrc_local_finishに非0な値が設定されていた場合には、それ以上の設
" 定ファイルの読込を中止する。
if 1 && filereadable($VIM . '/gvimrc_local.vim')
  source $VIM/gvimrc_local.vim
  if exists('g:gvimrc_local_finish') && g:gvimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.gvimrc_first.vim)があれば読み込む。読み込んだ後に変
" 数g:gvimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.gvimrc_first.vim')
  unlet! g:gvimrc_first_finish
  source $HOME/.gvimrc_first.vim
  if exists('g:gvimrc_first_finish') && g:gvimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_gvimrc_exampleに非0な値を設定しておけばインクルードしない。
if 1 && (!exists('g:no_gvimrc_example') || g:no_gvimrc_example == 0)
  source $VIMRUNTIME/gvimrc_example.vim
endif

"---------------------------------------------------------------------------
" カラー設定:
"colorscheme morning

" 端末モード関連の色設定
"highlight Terminal guifg=lightgrey guibg=grey20

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
  " Windows用
  "set guifont=Ricty:h10,Lucida_Console:h12:w5
  " MSゴシック改造版、0と\を斜線にする
  set guifont=MS_GothicK:h10,Lucida_Console:h12:w5
  "set guifontwide=MS_Gothic:h9
  "set guifont=MS_Gothic:h10:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=0
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
"set columns=80
" ウインドウの高さ
"set lines=25
" コマンドラインの高さ(GUI使用時)
"set cmdheight=2
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (GUI使用時)

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  " (8.0.1114 でデフォルトになったが念のため残してある)
  "set iminsert=0 imsearch=0
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a

"---------------------------------------------------------------------------
" メニューに関する設定:
"
" 解説:
" "M"オプションが指定されたときはメニュー("m")・ツールバー("T")供に登録され
" ないので、自動的にそれらの領域を削除するようにした。よって、デフォルトのそ
" れらを無視してユーザが独自の一式を登録した場合には、それらが表示されないと
" いう問題が生じ得る。しかしあまりにレアなケースであると考えられるので無視す
" る。
"
if &guioptions =~# 'M'
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
endif

"---------------------------------------------------------------------------
" その他、見栄えに関する設定:
"
" 検索文字列をハイライトしない(_vimrcではなく_gvimrcで設定する必要がある)
"set nohlsearch

"---------------------------------------------------------------------------
" 印刷に関する設定:
"
" 注釈:
" 印刷はGUIでなくてもできるのでvimrcで設定したほうが良いかもしれない。この辺
" りはWindowsではかなり曖昧。一般的に印刷には明朝、と言われることがあるらし
" いのでデフォルトフォントは明朝にしておく。ゴシックを使いたい場合はコメント
" アウトしてあるprintfontを参考に。
"
" 参考:
"   :hardcopy
"   :help 'printfont'
"   :help printing
"
" 印刷用フォント
if has('printer')
  if has('win32')
    set printfont=MS_Mincho:h12:cSHIFTJIS
    "set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif

" Copyright (C) 2009-2018 KaoriYa/MURAOKA Taro

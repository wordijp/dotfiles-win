scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim 8.1
"
" Last Change: 20-Jan-2019.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version
" このvimrcだけ使用する
let g:vimrc_first_finish = 1

" Windows用設定
" afterを追加する
if has('win32')
  set runtimepath^=~/.vim,~/.vim/after
endif

"---------
" Plug {{{
let s:plug_dir = expand('~/.vim/plugged')
let s:plug_repo_dir = s:plug_dir . '/vim-plug'

" plug.vimがなければclone
if !isdirectory(s:plug_repo_dir)
  echo 'install vim-plug...'
  call system('mkdir -p '.s:plug_repo_dir)
  call system('git clone https://github.com/junegunn/vim-plug.git '.s:plug_repo_dir.'/autoload')
end
if &rtp !~# 'vim-plug'
  set nocompatible
  execute 'set rtp+='.fnamemodify(s:plug_repo_dir, ':p')
endif

call plug#begin(s:plug_dir)
Plug 'junegunn/vim-plug', {
  \ 'dir': expand('~/.vim/plugged/vim-plug/autoload')
  \ }

" コード補完
Plug 'Valloric/YouCompleteMe'
" Linter
Plug 'w0rp/ale'
" 色んな言語のsyntax
Plug 'sheerun/vim-polyglot', {'do': 'sh build'}
" filetype切り替え
Plug 'osyo-manga/vim-precious'
Plug 'Shougo/context_filetype.vim'
" 言語サーバープロトコル
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'wordijp/LanguageServer-php-tcp-neovim', {
  \ 'do': 'bash ./install.sh && composer install && composer run-script parse-stubs'
  \ }
" ビルド、Linter、etc
Plug 'thinca/vim-quickrun'
" 整形
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'javascript.jsx', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'blade'] }
" 辞書
Plug 'thinca/vim-ref'
" React(TypeScript)
"Plug 'leafgarland/typescript-vim'
"Plug 'peitalin/vim-jsx-typescript'
Plug 'othree/yajs.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
" HTML
Plug 'mattn/emmet-vim'
" Go
"Plug 'fatih/vim-go'
" Python
"Plug 'davidhalter/jedi-vim' " pylsもrename対応したらコメントアウトも削除
" PHP
Plug 'stephpy/vim-php-cs-fixer'
" Utility
"Plug 'cpiger/NeoDebug'
Plug 'wordijp/NeoDebug' " バグ修正 & cgdbライクに使えるようにした版
Plug 'airblade/vim-rooter' " .gitプロジェクトでは常にルートをカレントディレクトリへ
Plug 'Shougo/denite.nvim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimproc', {'do': 'make'}
Plug 'majutsushi/tagbar'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 't9md/vim-quickhl'
Plug 'yami-beta/vim-responsive-tabline'
Plug 'scrooloose/nerdcommenter'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
"Plug 'vim-scripts/BlockDiff'
Plug 'mah/BlockDiff' " クリップボード対応版
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-smooth-scroll'
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/clever-f.vim'
Plug 'mattesgroeger/vim-bookmarks'
"Plug 'soramugi/auto-ctags.vim'
Plug 'wordijp/auto-ctags.vim' " tagsファイル名固定版
Plug 'jlanzarotta/bufexplorer'
"Plug 'thinca/vim-poslist'
Plug 'tyru/open-browser.vim'
" Other
Plug 'mattn/vim-pixela' " Vim利用履歴
call plug#end()
" }}}

"--------------
" emmet-vim {{{
let g:user_emmet_removetag_key='<c-t>'
" }}}

" pretteir {{{
let g:prettier#autoformat = 0
" }}}

" 負荷対策
set synmaxcol=500
set ttyfast
set lazyredraw

" <leader>をスペースへ
let mapleader = "\<Space>"

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
"let g:rooter_manual_only = 1

"-----------------
" NERD comment {{{
let g:NERDDefaultAlign = 'left'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

vmap <Leader>/  <Plug>NERDCommenterToggle
" トグル後次へ(末尾のj)
nmap <Leader>/  <Plug>NERDCommenterTogglej
" }}}

"-------------
" VimFiler {{{
let g:vimfiler_as_default_explorer = 1
" VimFilerTree {{{
command! VimFilerTree call VimFilerTree()
function VimFilerTree()
    exec ':VimFiler -buffer-name=explorer -split -simple -winwidth=40 -toggle -no-quit'
    wincmd t
    setl winfixwidth
endfunction
command! VimFilerTreeRefresh call VimFilerTreeRefresh()
" explorerのカレントディレクトリを更新する
function VimFilerTreeRefresh()
  exec ':VimFilerClose explorer'
  exec ':bdelete explorer'
  " NOTE : 一端BufferDirで開くと、カレントディレクトリを変更できる
  exec ':VimFilerBufferDir'
  exec ':VimFilerClose default'
endfunction

autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
    nmap     <buffer><expr><CR> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
    nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<CR>
    nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<CR>
endfunction
"    }}}
" }}}

"------------------
" vim-bookmarks {{{
let g:bookmark_auto_save_file = expand('~/.vim/tmp/.vim-bookmarks')
" }}}


" ---------------------
" ale(非同期Linter) {{{
" エラー一覧はquickfixを使う
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" NOTE: 未指定でdisableになる
"       lsp側のみ使う場合にdisable
let g:ale_linters = {
  \ 'c': [],
  \ 'cpp': [],
  \ 'python': [],
  \ 'php': ['phpstan'],
  \ 'rust': ['cargo'],
  \ 'go': ['golint', 'gobuild'],
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'typescript': ['tsserver'],
  \ 'ruby': ['ruby'],
  \}
  "\ 'python': ['pylint'],
  "\ 'ruby': ['rubocop'],

" global config files
let g:ale_php_phpstan_configuration = $HOME . '\.phpstan\phpstan.neon'
let g:ale_typescript_tslint_config_path = $HOME . '\tslint.json'
" 無くても動く
"let g:ale_javascript_eslint_options = '--config '.$HOME.'\.eslintrc.yml'

" NOTE: Pythonはlspを使う
"let g:ale_python_pylint_options = '--rcfile '.$HOME.'\.pylintrc'
"let g:ale_python_auto_pipenv = 0
" }}}

" -----------
" rainbow {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
      \  'guifgs': ['lightblue', 'darkcyan', 'lightmagenta', 'lightgreen'],
      \}
augroup rainbow_toggle_on
  autocmd!
  autocmd VimEnter,BufEnter,BufWritePost * :RainbowToggleOn
augroup END
" }}}

" ------------------
" ショートカット {{{
" 新規タブ
nmap <C-N> :tabnew<CR>
nmap <A-Left> :-tabnext<CR>
nmap <A-Right> :+tabnext<CR>
nmap <S-A-Left> :tabmove -1<CR>
nmap <S-A-Right> :tabmove +1<CR>

" 行削除
inoremap <S-Del> <esc>ddi
nnoremap <S-Del> dd

" 全選択
noremap <C-A> ggVG

"editexisting.vim
" 同じファイルを開いた時に開き済みのvimを前面に持ってくる
"runtime macros/editexisting.vim
packadd! editexisting

" 1画面用
"nmap <C-F1> :set columns=120<CR> :set lines=50<CR>

" 画面リサイズ {{{
nmap <C-E> [winsize]
nnoremap <silent> [winsize]^ :resize 5<CR>
nnoremap <silent> [winsize]_ :call <SID>resizeMax(5)<CR>
nnoremap <silent> [winsize]\ :call <SID>resizeMax(5)<CR>
nnoremap <silent> [winsize]- :resize -3<CR>
nnoremap <silent> [winsize]+ :resize +3<CR>
nnoremap <silent> [winsize]; :resize +3<CR>
function! s:resizeMax(invsize)
  silent! execute "normal! \<C-W>_"
  silent! execute "resize " . (winheight(0) - a:invsize)
endfunction

nnoremap <silent> [winsize]m :vertical resize 20<CR>
nnoremap <silent> [winsize]< :vertical resize -3<CR>
nnoremap <silent> [winsize], :vertical resize -3<CR>
nnoremap <silent> [winsize]> :vertical resize +3<CR>
nnoremap <silent> [winsize]. :vertical resize +3<CR>
nnoremap <silent> [winsize]/ :call <SID>verticalResizeMax(20)<CR>
function! s:verticalResizeMax(invsize)
  silent! execute "normal! \<C-W>|"
  silent! execute "vertical resize " . (winwidth(0) - a:invsize)
endfunction
" }}}

" :q等をスペースqでも押せるように
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

" ()入力
inoremap <C-8> (
inoremap <C-F8> (
inoremap <F8> (
inoremap <C-9> )
inoremap <C-F9> )
inoremap <F9> )

" smooth_scroll.vim {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 1)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 2)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 2)<CR>
"    }}}

" easymotion {{{
" http://blog.remora.cx/2012/08/vim-easymotion.html
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue
"    }}}

" denite {{{
" ctrlp like
nnoremap <silent> <C-p> :<C-u>Denite file_rec<CR>
" grep(選択単語)
nnoremap + :<C-u>Denite -buffer-name=search -no-empty grep -input=<C-R><C-W>
" grep
nnoremap <silent> ;g :<C-u>Denite -buffer-name=search -no-empty grep<CR>
" 検索
nnoremap <silent> ;/ :<C-u>Denite -buffer-name=search -auto-resize line<CR>
" 閉じたバッファをまた開く
nnoremap <silent> ;r :<C-u>Denite -buffer-name=search -resume<CR>
" 次へ
nnoremap <silent> ;n :<C-u>Denite -buffer-name=search -resume -immediately -select=+1<CR>
" 前へ
nnoremap <silent> ;p :<C-u>Denite -buffer-name=search -resume -immediately -select=-1<CR>
"    }}}

" IDE風の画面
nmap <F3> :VimFilerTree<CR> :Tagbar<CR>
" Tagbar更新
nmap <F8> :TagbarTogglePause<CR>:TagbarTogglePause<CR>

" poslist {{{
"map <C-o> <Plug>(poslist-prev-pos)
"map <C-i> <Plug>(poslist-next-pos)

"map <C-S-o> <Plug>(poslist-prev-buf)
"map <C-S-i> <Plug>(poslist-next-buf)
"    }}}
" }}}

" NeoDebug {{{
let g:neodbg_keymap_print_variable = '<C-Enter>' " defaul(<C-P>)はctrlpと被る
let g:neodbg_openbreaks_default    = 1 " breakpoints
let g:neodbg_openwatchs_default    = 1 " watchpoints: expressionsと共用窓なので、ONにしとく
" }}}

" termdebug.vim
"packadd termdebug

" ------------
" QuickFix {{{
" Enterでジャンプ
autocmd FileType * noremap <Enter> <Enter>
autocmd FileType qf noremap <Enter> :.ll<CR>
" }}}

" ---------------------------------------
" 検索、大文字と小文字区別 & 単語単位 {{{
" カーソル単語検索
nmap * "zyiw:let @/ = '\C\<'.@z.'\>'<CR><Right><S-N>
" 選択文字列検索
vmap * "zy:let @/ = @z<CR><Right><S-N>

" denite {{{
" find source
" NOTE: 除外もこっち
call denite#custom#var('file_rec', 'command',
  \ ['fd', '.', '-HI', '--type', 'f',
  \ '-E', '.git',
  \ '-E', 'vendor',
  \ '-E', 'node_modules',
  \ '-E', 'target',
  \
  \ '-E', '*.bak',
  \ '-E', '*.o',
  \ '-E', '*.obj',
  \ '-E', '*.pdb',
  \ '-E', '*.exe',
  \ '-E', '*.bin',
  \ '-E', '*.dll',
  \ '-E', '*.a',
  \ '-E', '*.lib',
  \ '-E', '.gitignore',
  \ '-E', '.*.*',
  \ ])
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy'])

" grep source
" NOTE: ptでutf8、sjis両対応
call denite#custom#var('grep', 'command',
  \ ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden',
  \ '--ignore', '.git',
  \ '--ignore', 'vendor',
  \ '--ignore', 'node_modules',
  \ '--ignore', 'target',
  \
  \ '--ignore', '*.bak',
  \ '--ignore', '*.o',
  \ '--ignore', '*.obj',
  \ '--ignore', '*.pdb',
  \ '--ignore', '*.exe',
  \ '--ignore', '*.bin',
  \ '--ignore', '*.dll',
  \ '--ignore', '*.a',
  \ '--ignore', '*.lib',
  \ '--ignore', '.gitignore',
  \ '--ignore', '.*.*',
  \ ])
call denite#custom#var('grep', 'default_opts', [])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#source('grep', 'matchers', ['matcher_fuzzy'])

" denite/insert モードの時に移動できるようにする
call denite#custom#map('insert', "<C-j>" , '<denite:move_to_next_line>')
call denite#custom#map('insert', "<down>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>" , '<denite:move_to_previous_line>')
call denite#custom#map('insert', "<up>"  , '<denite:move_to_previous_line>')
" prompt
call denite#custom#option('_', 'prompt', '>')
"    }}}

" 検索・ハイライト取り消し
nmap <Esc> :nohlsearch<CR> :call <SID>trySearchReset()<CR><Left>
function! s:trySearchReset()
  try
    " t9md/vim-quickhl用
    :call quickhl#manual#reset()
    :call quickhl#cword#disable()
  catch
  endtry
endfunction

" quickhl.vim {{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
nmap <Space>j <Plug>(quickhl-cword-toggle)
"    }}}
" }}}

" --------------------------------------------------
" コード整形 
" {{{
noremap <Space><Tab> :call <SID>format()<CR>
function! s:format()
  if &ft == 'javascript' || &ft == 'javascript.jsx' || &ft == 'typescript' ||
    \ &ft == 'css' || &ft == 'less' || &ft == 'scss' ||
    \ &ft == 'json' || &ft == 'graphql' || &ft == 'markdown' || &ft == 'yaml' || &ft == 'html'
    :PrettierAsync
  elseif &ft == 'blade'
    :Prettier
    :call <SID>basicFormat()
  elseif &ft == 'php'
    silent call PhpCsFixerFixFile()
    silent call <SID>basicFormat()
  else
    :call <SID>basicFormat()
  end
endfunction

function! s:basicFormat()
  let view = winsaveview()
  normal ggVG=
  silent call winrestview(view)

  try
    :%:s/\s\+$//g
  catch
  finally
    echo '末尾の空白を削除'
  endtry
endfunction

nnoremap :trim :call Trim()
command! -bar Trim call Trim()
function! Trim()
  try
    let view = winsaveview()
    " こっちやりたいが上手くいかない
    "silent! execute "normal! a \<bs>\<esc>" | undojoin | execute "normal! :%:s/\\s\\+$//g\<cr>"
    " \<c-g>uでundo履歴を区切る、undo二回必要だがとりあえず動く
    execute "normal! a \<bs>\<c-g>u\<esc>:%:s/\\s\\+$//g\<cr>"
    ":%:s/\s\+$//g
    silent call winrestview(view)
  catch
  finally
    echo '末尾の空白を削除'
  endtry
endfunction

" 空白削除
command! -range CollectSpace <line1>,<line2>call s:CollectSpace()
function! s:CollectSpace() range
  :'<,'>:s/\%V[ ]\+/ /g
endfunction
" }}}

autocmd FileType markdown noremap <Space><Tab> "\<Tab>"
" HTML内の/開始パスも開けるように
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

" ------------
" filetype {{{
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
" VB
autocmd BufRead,BufNewFile *.{cls,dcm,frm} set filetype=vb
" ruby
autocmd BufNewFile,BufRead Guardfile  set filetype=ruby
" typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
" }}}

" --------------
" インデント {{{
autocmd! FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" Haskell
autocmd! FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" Ruby
autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
autocmd BufNewFile,BufRead *.{erb} setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" Vim Script
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" HTML & CSS
" template files(PHP blade)
autocmd FileType html,css,blade setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" VB
autocmd FileType vb setlocal shiftwidth=4 tabstop=4 softtabstop=4 | set expandtab
"autocmd BufNewFile,BufRead *.{cls,dcm,frm} setlocal shiftwidth=4 tabstop=4 softtabstop=4 | set expandtab
" JavaScript
"autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" Vue
autocmd FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
autocmd FileType vue syntax sync fromstart
" React
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" sh
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" AutoHotkey
autocmd FileType autohotkey setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
" }}}

" ------------
" 短縮入力 {{{
" VimFiler
nnoremap :vf :VimFiler
nnoremap :vft :VimFilerTree
nnoremap :vfr :VimFilerTreeRefresh
let g:vimfiler_enable_auto_cd = 1

" QuickRun
nnoremap :qr :QuickRun
" BlockDiff
nnoremap :dfu :diffupdate 

" バッファ操作
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>
"nnoremap <silent>bd :bdelete<CR>
nnoremap <silent>be :BufExplorer<CR>
" easy-align
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
vmap ea <Plug>(EasyAlign)
" 正規表現起動
vmap ear :EasyAlign *//<Left>

" PPx(ファイラ)拡張 {{{
" PPxで開く
function! Open_ppx()
  call vimproc#system_bg("E:/tool/favorite/PPX/PPCW.EXE -r /k *jumppath '".expand('%:p')."'")
endfunction
" 「:PPx」「:ppx」の両対応
nnoremap :ppx :call Open_ppx()
command! -bar PPx call Open_ppx()
"    }}}
" }}}

" vim-operator-flashy(コピーしたら光るやつ)
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#flash_time = 120
let g:operator#flashy#group = "MatchParen"

" -----------------
" YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = $HOME . '/.ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 読み込むかの確認ダイアログを 1:出す 0:出さない
let g:ycm_confirm_extra_conf = 0
" Ycmサーバ再起動(補完候補の更新)
autocmd FileType php imap <C-Space> <ESC>:call <SID>ycmRestartServer()<CR>a <BS>
function s:ycmRestartServer()
  :YcmRestartServer
  sleep 350m
endfunction
" }}}

" --------
" tags {{{
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_tags_name_fixed = 'tags' " 全filetype共通名

" tagsファイル作成
au FileType * call s:tagBuildCmd()
function s:tagBuildCmd()
  if &filetype == 'go'
    nnoremap :tags :GoBuildTags mycustomtag
  else
    nnoremap :tags :Ctags
  endif
endfunction

set tags+=.git/tags
" }}}

" ----------------------
" タグ、実装ジャンプ {{{
let g:go_def_mapping_enabled = 0 "自前でマッピング
nnoremap <F12> :call <SID>defJump()<CR>
nnoremap <C-]> :call <SID>defJump()<CR>
nnoremap <C-h> :vsp<CR>:call <SID>defJump()<CR>
nnoremap <C-k> :split<CR>:call <SID>defJump()<CR>
function s:defJump()
  if &ft == 'go' || &ft == 'c' || &ft == 'cpp' || &ft == 'php' || &ft == 'ruby' || &ft == 'python'
    " 実装へジャンプ
    :call LanguageClient#textDocument_definition()
  elseif &ft == 'rust' || &ft == 'javascript' || &ft == 'javascript.jsx' || &ft == 'typescript'
    :YcmCompleter GoToDefinition
  else
    :exe("tjump ".expand('<cword>'))
  end
endfunction

nnoremap <A-]> :call <SID>decJump()<CR>
function s:decJump()
  if &ft == 'cpp'
    " 定義へジャンプ
    :YcmCompleter GoToDeclaration
  else
    echo "noop"
  end
endfunction
" }}}

" ------------
" QuickRun {{{
" ビルド設定
let g:loaded_quicklaunch = 1
let g:quickrun_config = {
\  "_": {
\      "runner/vimproc/updatetime" : 40,
\      "outputter/buffer/split" : ":botright 10sp",
\      "outputter/error/split" : ":botright 10sp",
\      "runner" : "vimproc",
\      "outputter": "loclist",
\  },
\  "make" : {
\      "command"   : "make",
\      "exec" : "%c %o 1>nul",
\  },
\  "make-run" : {
\      "command"   : "make",
\      "cmdopt": "run",
\      "exec" : "%c %o",
\      "outputter": "buffer",
\  },
\  "make-run-shell" : {
\      "command"   : "make",
\      "cmdopt": "run",
\      "exec" : "%c %o",
\      "runner" : "shell",
\  },
\  "make-clean" : {
\      "command"   : "make",
\      "cmdopt": "clean",
\      "exec" : "%c %o",
\  },
\
\  "cargo-build" : {
\      "command" : "cargo",
\      "cmdopt": "build",
\      "args": "--quiet",
\      "exec" : "%c %o %a 2>\\&1",
\  },
\  "cargo-build-lib" : {
\      "cmdopt": "build --lib",
\      "exec" : "cargo %o",
\      "runner" : "shell",
\  },
\  "cargo-run" : {
\      "command" : "cargo",
\      "cmdopt": "run",
\      "exec" : "%c %o",
\      "outputter": "buffer",
\  },
\  "cargo-run-shell" : {
\      "command" : "cargo",
\      "cmdopt": "run",
\      "exec" : "%c %o",
\      "runner": "shell",
\  },
\
\  "go-build": {
\      "command" : "go",
\      "cmdopt": "build",
\      "exec" : "%c %o",
\  },
\  "go-run" : {
\      "command" : "go",
\      "cmdopt": "run",
\      "exec" : "%c %o .",
\      "outputter": "buffer",
\  },
\  "go-run-shell" : {
\      "command" : "go",
\      "cmdopt": "run",
\      "exec" : "%c %o .",
\      "runner" : "shell",
\  },
\
\  "php-linter": {
\      "command": "php-linter",
\      "cmdopt": "php-l",
\      "exec": "%c %o",
\  },
\  "php-linter-phpmd": {
\      "command": "php-linter",
\      "cmdopt": "phpmd",
\      "args": "text codesize,design,unusedcode",
\      "exec": "%c %o %a",
\  },
\  "php-linter-phan": {
\      "command": "php-linter",
\      "cmdopt": "phan",
\      "exec": "%c %o",
\  },
\  "php-linter-multi": {
\      "command": "php-linter",
\      "cmdopt": "multi",
\      "exec": "%c %o",
\  },
\  "php-linter-laravel": {
\      "command": "php-linter",
\      "cmdopt": "php-l,phpmd",
\      "exec": "%c %o",
\  },
\}
" }}}

" --------------
" 言語別設定 {{{
" C++
autocmd FileType cpp nmap <F2> :call LanguageClient#textDocument_rename()<CR>
autocmd FileType cpp nmap <F5> :QuickRun make-run<CR>
autocmd FileType cpp nmap <C-F5> :QuickRun make-run-shell<CR>
autocmd FileType cpp nmap <F7> :QuickRun make<CR>
autocmd FileType cpp nmap <F8> :QuickRun make-clean<CR>
" make
autocmd FileType cpp setlocal errorformat+=make:\ 'all'\ is\ up\ to\ date.

" rust
autocmd FileType rust nmap <F1> :call <SID>getDocRust()<CR>
function! s:getDocRust()
  let l:prev_winids = s:getWinDict()
  :call LanguageClient#textDocument_hover()
  let l:after_winids = s:getWinDict()

  " NOTE: hoverは非同期・同期が混ざっているので、ポーリングで待つ
  let l:i = 0
  while len(l:prev_winids) == len(l:after_winids) && l:i < 3 " 3で十分
    redraw
    sleep 100m
    let l:after_winids = s:getWinDict()
    let l:i += 1
  endwhile

  " XXX: 既に開いている時はフォーカスしない
  if len(l:prev_winids) != len(l:after_winids)
    " success
    for l:key in keys(l:after_winids)
      if !has_key(l:prev_winids, l:key)
        :call win_gotoid(l:after_winids[l:key])
        ":set filetype=rustdoc
        break
      endif
    endfor
  endif
endfunction
function! s:getWinDict()
  let l:dic = {}

  for l:i in range(1, bufnr('$'))
    let l:winid = bufwinid(l:i)
    if l:winid > 0
      let l:dic[l:i] = l:winid
    endif
  endfor

  return l:dic
endfunction

autocmd FileType rust nmap <F2> :call LanguageClient#textDocument_rename()<CR>
autocmd FileType rust nmap <F5> :QuickRun cargo-run<CR>
autocmd FileType rust nmap <C-F5> :QuickRun cargo-run-shell<CR>
autocmd FileType rust nmap <F7> :QuickRun cargo-build<CR>
"autocmd FileType rust nmap <F8> :QuickRun cargo-build-lib<CR>
autocmd FileType rust nmap <F8> :call <SID>cargo_build_lib()<CR>
function! s:cargo_build_lib()
  silent write
  silent execute "normal! :QuickRun cargo-build-lib\<CR>"
  echo "cargo build --lib"
endfunction

" Go
autocmd FileType go nmap <F1> :GoDoc<CR>
autocmd FileType go nmap <F2> :call LanguageClient#textDocument_rename()<CR>
autocmd FileType go nmap <F5> :QuickRun go-run<CR>
autocmd FileType go nmap <C-F5> :QuickRun go-run-shell<CR>
autocmd FileType go nmap <F7> :QuickRun go-build<CR>
"autocmd FileType go nmap <F7> :QuickRun make<CR>

" PHP
"autocmd FileType php nmap <F7> :QuickRun php-linter<CR>
"autocmd FileType php nmap <F7> :QuickRun php-linter-phpmd<CR>
"autocmd FileType php nmap <F7> :QuickRun php-linter-phan<CR>
autocmd FileType php nmap <F7> :QuickRun php-linter-multi<CR>
" Linter用 errorformat
" php -l
autocmd FileType php setlocal errorformat+=PHP\ Parse\ error:\ %m\ in\ %f\ on\ line\ %l
" phpmd
autocmd FileType php setlocal errorformat+=%f\	-\	%m\\,\ line:\ %l\\,\ col:\ %c\\,\ file:\ %.%#.
autocmd FileType php setlocal errorformat+=%f:%l\	%m
" phan
autocmd FileType php setlocal errorformat+=%f:%l\ %m

" JavaScript
autocmd FileType javascript,javascript.jsx,typescript nmap <F2> :YcmCompleter RefactorRename 
autocmd FileType javascript nmap <F7> :QuickRun eslint-all<CR>

" Python
autocmd FileType python nmap <F1> :call <SID>getDocPython()<CR>
function! s:getDocPython()
  " 1. try jedi
  "let l:prev_bufnr = bufnr('%')
  ":call jedi#show_documentation()
  "if bufnr('%') != l:prev_bufnr
  "  " success
  "  return
  "endif

  " 2. try YouCompleteMe
  let l:prev_winids = s:getWinDict()
  :YcmCompleter GetDoc
  let l:after_winids = s:getWinDict()

  if len(l:prev_winids) != len(l:after_winids)
    " success
    for l:key in keys(l:after_winids)
      if !has_key(l:prev_winids, l:key)
        :call win_gotoid(l:after_winids[l:key])
        ":set filetype=rustdoc
        break
      endif
    endfor
  endif
endfunction

"autocmd FileType python nmap <F2> :call jedi#rename()<CR>
" }}}

" ----------------
" QuickFix移動 {{{
" 次へ
nnoremap <F4> :call <SID>lNext()<CR>
nnoremap ]q :call <SID>lNext()<CR>
function s:lNext()
  try
    :ll
    :lne
  catch
  endtry
endfunction
" 前へ
nnoremap <S-F4> :call <SID>lPrev()<CR>
nnoremap [q :call <SID>lPrev()<CR>
function s:lPrev()
  try
    :ll
    :lp
  catch
  endtry
endfunction

" 最初へ
nnoremap [Q :call <SID>lFirst()<CR>
function s:lFirst()
  :ll
  while 1
    try
      :lp 999
    catch
      break
    endtry
  endwhile
endfunction
" 最後へ
nnoremap ]Q :call <SID>lLast()<CR>
function s:lLast()
  :ll
  while 1
    try
      :lne 999
    catch
      break
    endtry
  endwhile
endfunction
" }}}

" -----------------------------------------------
" 各言語の開発設定

"-----------
" Golang {{{
" 保存時に自動整形
let g:go_fmt_autosave = 1
command! -bar GoFmtOff let g:go_fmt_autosave = 0
command! -bar GoFmtOn let g:go_fmt_autosave = 1

let g:go_fmt_command = "gofmt"

let g:go_build_tags = "mycustomtag"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}

"---------
" Rust {{{
" 保存時に自動整形
let g:rustfmt_autosave = 0
let g:rustfmt_command = 'rustfmt'
" }}}

" ----------
" Python {{{
" pythonのrename用のマッピングがquickrunとかぶるため回避させる
"autocmd FileType python
"let g:jedi#completions_enabled = 0
"let g:jedi#force_py_version = 3

"let g:jedi#rename_command = ""
"let g:jedi#documentation_command = ""
" }}}

" -------
" C++ {{{
" コード整形
augroup Formatter
  au!
  " 選択範囲のコードを整形する
  autocmd FileType c,cpp xnoremap <buffer> <Space>f :call <SID>formatClang()<CR>
augroup END

" コード整形(外部コマンドを直接利用)
" url) https://qiita.com/CutBaum/items/924fe338bb690f1d4a4a
function! s:formatClang() range
  let cmd = ':silent %! clang-format '
      \ .'-lines='.a:firstline.':'.a:lastline.' '
      \ .'-style="{
      \   BasedOnStyle                     : Google        ,
      \   AlignConsecutiveAssignments      : true          ,
      \   Cpp11BracedListStyle             : true          ,
      \   DerivePointerAlignment           : false         ,
      \   IndentCaseLabels                 : true          ,
      \   IndentWidth                      : 4             ,
      \   KeepEmptyLinesAtTheStartOfBlocks : true          ,
      \   PointerAlignment                 : Left          ,
      \   SpacesBeforeTrailingComments     : 1             ,
      \   Standard                         : Cpp11         ,
      \   TabWidth                         : 4             ,
      \   UseTab                           : ForIndentation,
      \ }"'
  call s:keepPosExec(cmd)
endfunction

function! s:keepPosExec(cmd)
  let view = winsaveview()
  silent! execute "normal! a \<bs>\<esc>" | undojoin | execute a:cmd
  silent call winrestview(view)
endfunction
" }}}

" -----------------------------
" LanguageClient-neovim {{{ ---
" NOTE: PHPは'wordijp/LanguageServer-php-tcp-neovim'で設定
let g:LanguageClient_serverCommands = {
  \ 'c': ['clangd'],
  \ 'cpp': ['clangd'],
  \ 'go': ['gopls', '-mode', 'stdio'],
  \ 'python': ['pyls'],
  \ 'ruby': ['cmd', '/c', 'solargraph stdio'],
  \ }
  "\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  "\ 'vue': ['vls'],
  "\ 'c': ['cquery', '--init={"cacheDirectory": "C:/Users/f/.cquery/cache"}'],
  "\ 'cpp': ['cquery', '--init={"cacheDirectory": "C:/Users/f/.cquery/cache"}'],
  "\ 'c': ['clangd'],
  "\ 'cpp': ['clangd'],
" }}}

" --------
" HTML {{{
" emmet-vim
let g:user_emmet_mode='n'    "only enable normal mode functions.
" vim-css-color
let g:cssColorVimDoNotMessMyUpdatetime = 1
" }}}
" --------------
" JavaScript {{{
" JsDocを折り畳む
"setlocal foldmethod=marker
"setlocal foldmarker=/*,*/
" }}}

" -------
" PHP {{{
" PHP-CS-Fixer(コード整形) {{{
let g:php_cs_fixer_cache = expand('~/.cache/php_cs.cache')

autocmd FileType php nnoremap <silent><Space>pcd :call PhpCsFixerFixDirectory()<CR>
"autocmd FileType php nnoremap <silent><Space>pcf :call PhpCsFixerFixFile()<CR>
"    }}}

" vim-ref {{{
"inoremap <silent><C-k> <C-o>:call<Space>ref#K('normal')<CR><ESC>
nmap <F1> <Plug>(ref-keyword)
let g:ref_no_default_key_mappings = 1
let g:ref_cache_dir = $HOME . '/.vim/vim-ref/cache'
let g:ref_detect_filetype = {
  \ 'php': 'phpmanual'
  \}

let g:ref_phpmanual_path = $HOME . '/.vim/vim-ref/php-chunked-xhtml'
let g:ref_use_vimproc = 1
"    }}}
" }}}

" vim-pixela(草生やすやつ) {{{
source $HOME/.vimrc_pixela_private.vim
"let g:pixela_username = 'XXXXX'
"let g:pixela_token = 'XXXXXXXXXX'
" }}}

" 追加ここまで -------------------------------------------------------------
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

" plugins下のディレクトリをruntimepathへ追加する。
"for s:path in split(glob($VIM.'/plugins/*'), '\n')
"  if s:path !~# '\~$' && isdirectory(s:path)
"    let &runtimepath = &runtimepath.','.s:path
"  end
"endfor
"unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
"source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
"if !(has('win32') || has('mac')) && has('multi_lang')
"  if !exists('$LANG') || $LANG.'X' ==# 'X'
"    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
"      language ctype ja_JP.eucJP
"    endif
"    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
"      language messages ja_JP.eucJP
"    endif
"  endif
"endif
"" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
"if has('mac')
"  set langmenu=japanese
"endif
"" 日本語入力用のkeymapの設定例 (コメントアウト)
"if has('keymap')
"  " ローマ字仮名のkeymap
"  "silent! set keymap=japanese
"  "set iminsert=0 imsearch=0
"endif
"" 非GUI日本語コンソールを使っている場合の設定
"if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
"  set termencoding=cp932
"endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
    " やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
    " とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
    " まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
    " 化けてしまう。
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set noautoindent
" バックスペースでインデントや改行を削除できるようにする
"set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を非表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags+=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
"set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
"if kaoriya#switch#enabled('disable-vimdoc-ja')
"  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
"endif

" vimproc: 同梱のvimprocを無効化する
"if kaoriya#switch#enabled('disable-vimproc')
"  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
"endif

" go-extra: 同梱の vim-go-extra を無効化する
"if kaoriya#switch#enabled('disable-go-extra')
"  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
"endif

" Copyright (C) 2009-2018 KaoriYa/MURAOKA Taro

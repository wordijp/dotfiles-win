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
"Plug 'Valloric/YouCompleteMe', { 'for': ['cpp'] }
" Linter
Plug 'w0rp/ale'
" 色んな言語のsyntax
Plug 'sheerun/vim-polyglot'
Plug 'wordijp/vim-vimscript-scope-syntax'
" filetype切り替え
Plug 'osyo-manga/vim-precious'
Plug 'Shougo/context_filetype.vim'
" 言語サーバープロトコル
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'make',
  \ 'for': ['dart'],
  \ }
Plug 'lifepillar/vim-mucomplete' " autocomplete用
Plug 'wordijp/vim-quickfixsync' " quickfixをsignsなどへ反映
"
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'machakann/asyncomplete-ezfilter.vim' " fuzzyマッチ用
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" ビルド、Linter、etc
Plug 'thinca/vim-quickrun'
" 整形
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'blade'] }
" 辞書
Plug 'thinca/vim-ref'
" React(TypeScript)
"Plug 'leafgarland/typescript-vim'
"Plug 'peitalin/vim-jsx-typescript'
Plug 'othree/yajs.vim'
"Plug 'MaxMEllon/vim-jsx-pretty'
" HTML
Plug 'mattn/emmet-vim'
" Go
"Plug 'fatih/vim-go'
" Dart
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
" PHP
Plug 'stephpy/vim-php-cs-fixer'
" Utility
Plug 'itchyny/lightline.vim'
"Plug 'cpiger/NeoDebug'
Plug 'wordijp/NeoDebug' " バグ修正 & cgdbライクに使えるようにした版
Plug 'airblade/vim-rooter' " .gitプロジェクトでは常にルートをカレントディレクトリへ
"
Plug 'Shougo/denite.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"
Plug 'Shougo/unite.vim'
Plug 'Shougo/defx.nvim'
Plug 'Shougo/vimproc', {'do': 'make'}
Plug 'liuchengxu/vista.vim'
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

" --------
" Defx {{{
call defx#custom#column('filename', {
  \ 'min_width': 40,
  \ 'max_width': 40,
  \ })

call defx#custom#option('_', {
  \ 'columns': 'mark:indent:icon:filename:type:size:time',
  \ })
augroup defx_settings
  autocmd!
  autocmd FileType defx call s:defx_my_settings()
augroup END
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> <C-CR>
    \ defx#do_action('open')
  nnoremap <silent><buffer><expr> h
    \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> <Left>
    \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> l
    \ defx#do_action('open_tree')
  nnoremap <silent><buffer><expr> <Right>
    \ defx#do_action('open_tree')
  nnoremap <silent><buffer> ~
    \ :call <SID>defxRoot()<CR>
  nnoremap <silent><buffer><expr> <BS>
    \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
endfunction
function! s:defxRoot() abort
  " 開きなおしてプロジェクトRootに戻る
  call defx#call_action('quit', [])
  :DefxTree
endfunction

" current file path
command! DefxCurrent :Defx `expand('%:p:h')` -search=`expand('%:p')`
" tree
command! DefxTree :Defx -split=vertical -winwidth=50 -direction=topleft
" }}}

"------------------
" vim-bookmarks {{{
let g:bookmark_auto_save_file = expand('~/.vim/tmp/.vim-bookmarks')
" }}}

" -----------------
" lightline.vim {{{
let g:lightline = {'colorscheme': 'wombat'}
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
  \ 'dart': [],
  \ 'python': [],
  \ 'php': [],
  \ 'rust': ['cargo'],
  \ 'go': ['golint', 'gobuild'],
  \ 'javascript': ['eslint', 'flow'],
  \ 'typescript': ['tsserver'],
  \ 'ruby': ['ruby'],
  \}
  "\ 'python': ['pylint'],
  "\ 'ruby': ['rubocop'],

" global config files
"let g:ale_php_phpstan_configuration = $HOME . '\.phpstan\phpstan.neon'
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
" "入力
inoremap <C-2> "
inoremap <C-F2> "
inoremap <F2> "
" '入力
inoremap <C-7> '
inoremap <C-F7> '
inoremap <F7> '

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
nmap ; [denite]
" ctrlp like
nnoremap <silent> <C-p> :<C-u>Denite file/rec<CR>
" grep(選択単語)
nnoremap + :<C-u>Denite -buffer-name=search -no-empty grep -input=<C-R><C-W>
" grep
nnoremap <silent> [denite]g :<C-u>Denite -buffer-name=search -no-empty grep<CR>
" 検索
nnoremap <silent> [denite]/ :<C-u>Denite -buffer-name=search -auto-resize line<CR>
" 閉じたバッファをまた開く
nnoremap <silent> [denite]r :<C-u>Denite -buffer-name=search -resume<CR>
" 次へ
nnoremap <silent> [denite]n :<C-u>Denite -buffer-name=search -resume -immediately -cursor-pos=+1<CR>
" 前へ
nnoremap <silent> [denite]p :<C-u>Denite -buffer-name=search -resume -immediately -cursor-pos=-1<CR>
"    }}}

" IDE風の画面
nmap <F3> :call <SID>ideStyle()<CR>
function s:ideStyle()
  let l:id = bufnr('%')
  :DefxTree
  sleep 200m " ウィンドウが開くまで待つ、適当
             " TODO: 開いたのを検知する方法へ
  :call win_gotoid(bufwinid(l:id))
  :Vista
  sleep 1000m " TODO: 同じく
  :call win_gotoid(bufwinid(l:id))
endfunction

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
augroup qf_jump
  autocmd!
  autocmd FileType * noremap <Enter> <Enter>
  autocmd FileType qf noremap <Enter> :call <SID>quickFixJump()<CR>
augroup END
function! s:quickFixJump()
  let wi = getwininfo(win_getid())[0]
  if wi.loclist
    :.ll
  elseif wi.quickfix
    :.cc
  endif
endfunction
" }}}

" ---------------------------------------
" 検索、大文字と小文字区別 & 単語単位 {{{
" カーソル単語検索
nmap * "zyiw:let @/ = '\C\<'.@z.'\>'<CR><Right><S-N>
" 選択文字列検索
vmap * "zy:let @/ = @z<CR><Right><S-N>

" denite {{{
" denite実行窓
augroup denite_settings
  autocmd!
  autocmd FileType denite call s:denite_my_settings()
  autocmd FileType denite-filter call s:denite_filter_my_settings()
augroup END
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-[>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
endfunction
" 絞り込み窓
function! s:denite_filter_my_settings() abort
  imap <silent><buffer><expr> <C-[>
  \ denite#do_map('quit')
endfunction

" find source
" NOTE: 除外もこっち
call denite#custom#var('file/rec', 'command',
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
call denite#custom#source('file/rec', 'matchers', ['matcher/fuzzy'])

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
call denite#custom#source('grep', 'matchers', ['matcher/fuzzy'])

" denite/insert モードの時に移動できるようにする
"call denite#custom#map('insert', "<C-j>" , '<denite:move_to_next_line>', 'noremap')
"call denite#custom#map('insert', "<down>", '<denite:move_to_next_line>', 'noremap')
"call denite#custom#map('insert', "<C-k>" , '<denite:move_to_previous_line>', 'noremap')
"call denite#custom#map('insert', "<up>"  , '<denite:move_to_previous_line>', 'noremap')

" prompt
call denite#custom#option('_', 'prompt', '>')
"    }}}

" 検索・ハイライト取り消し
nmap <Esc> :nohlsearch<CR>:call <SID>trySearchReset()<CR>
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
  if &ft == 'javascript' || &ft == 'typescript' ||
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

augroup filetype_edit
  autocmd!
  autocmd FileType markdown noremap <Space><Tab> "\<Tab>"
  " HTML内の/開始パスも開けるように
  autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
augroup END

" ------------
" filetype {{{
augroup set_filetype
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  " VB
  autocmd BufRead,BufNewFile *.{cls,dcm,frm} set filetype=vb
  " ruby
  autocmd BufNewFile,BufRead Guardfile  set filetype=ruby
  " typescript.tsx
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
augroup END
" }}}

" --------------
" インデント {{{
augroup set_indent
  autocmd!
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
  autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
  " Vue
  autocmd FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
  autocmd FileType vue syntax sync fromstart
  " sh
  autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
  " AutoHotkey
  autocmd FileType autohotkey setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
  " Dart
  autocmd FileTYpe dart setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
augroup END
" }}}

" ------------
" 短縮入力 {{{
" Defx
nnoremap :df :Defx
nnoremap :dfc :DefxCurrent
nnoremap :dft :DefxTree

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
"let g:ycm_global_ycm_extra_conf = $HOME . '/.ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 読み込むかの確認ダイアログを 1:出す 0:出さない
"let g:ycm_confirm_extra_conf = 0
" LSPサーバ再起動(補完候補の更新)
nnoremap <C-Space> :call <SID>lspRestartServer()<CR>
function s:lspRestartServer()
  " NOTE: dartは再起動しなくても更新してくれてる
  if &ft == 'dart' | return | endif

  "if &ft == 'cpp'
  "  :YcmRestartServer
  "endif
  :LspStopServer

  let l:i = 0
  while execute(':LspStatus') =~ 'running' && l:i < 5
    let l:i += 1
    sleep 100m
  endwhile

  " 発火
  try
    :e
  catch
    :update
  endtry
endfunction
" }}}

" --------
" tags {{{
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_filetype_mode = 1
let g:auto_ctags_tags_name_fixed = 'tags' " 全filetype共通名

" tagsファイル作成
"augroup tag_make
"  au!
"  au FileType * call s:tagBuildCmd()
"augroup END
"function s:tagBuildCmd()
"  if &filetype == 'go'
"    nnoremap :tags :GoBuildTags mycustomtag
"  else
"    nnoremap :tags :Ctags
"  endif
"endfunction
nnoremap :tags :Ctags

set tags+=.git/tags
" }}}

" ----------------------
" タグ、実装ジャンプ {{{
"let g:go_def_mapping_enabled = 0 "自前でマッピング
nnoremap <F12> :call <SID>defJump()<CR>
nnoremap <C-]> :call <SID>defJump()<CR>
nnoremap <C-h> :vsp<CR>:call <SID>defJump()<CR>
nnoremap <C-k> :split<CR>:call <SID>defJump()<CR>
function s:defJump()
  if &ft == 'dart'
    :call LanguageClient#textDocument_definition()
  elseif execute(':LspStatus') =~ 'running'
    :LspDefinition
  else
    :exe("tjump ".expand('<cword>'))
  end
endfunction

nnoremap <C-Enter> :call <SID>decJump()<CR>
function s:decJump()
  if &ft == 'dart'
    echo 'noop'
  elseif execute(':LspStatus') =~ 'running'
    :LspDeclaration
  else
    echo 'noop'
  endif
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
\      "outputter": "quickfix",
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

let s:hook = {
\ "name": 'quickfixsync',
\ 'kind': 'hook',
\ }

function! s:hook.on_exit(...)
  call quickfixsync#update()
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook
" }}}

" --------------
" 言語別設定 {{{
" C++
augroup cpp_settings
  autocmd!
  autocmd FileType cpp nmap <F1> :LspHover<CR>
  autocmd FileType cpp nmap <F2> :LspRename<CR>
  autocmd FileType cpp nmap <F5> :QuickRun make-run<CR>
  autocmd FileType cpp nmap <C-F5> :QuickRun make-run-shell<CR>
  autocmd FileType cpp nmap <F7> :QuickRun make<CR>
  autocmd FileType cpp nmap <F8> :QuickRun make-clean<CR>
  " make
  autocmd FileType cpp setlocal errorformat+=make:\ 'all'\ is\ up\ to\ date.
augroup END

" Dart
augroup dart_settings
  autocmd!
  autocmd FileType dart nmap <F1> :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType dart nmap <F2> :call LanguageClient#textDocument_rename({'newName': input('Rename to: ', expand('<cword>'))})<CR>
  autocmd FileType dart nmap <F7> :call <SID>lspDocumentDiagnostics()<CR>
augroup END
function! s:lspDocumentDiagnostics()
  ":LspDocumentDiagnostics
  "" 不要なら閉じる
  "" NOTE: call setloclist(0, l:result) でセットされている
  "if len(getloclist(0)) == 0 | :lclose | endif
  if len(getqflist()) > 0
    :copen
  else
    :cclose
  endif
endfunction

" rust
augroup rust_settings
  autocmd!
  autocmd FileType rust nmap <F1> :LspHover<CR>
  autocmd FileType rust nmap <F2> :LspRename<CR>
  autocmd FileType rust nmap <F5> :QuickRun cargo-run<CR>
  autocmd FileType rust nmap <C-F5> :QuickRun cargo-run-shell<CR>
  autocmd FileType rust nmap <F7> :QuickRun cargo-build<CR>
  "autocmd FileType rust nmap <F8> :QuickRun cargo-build-lib<CR>
  autocmd FileType rust nmap <F8> :call <SID>cargo_build_lib()<CR>
augroup END
function! s:cargo_build_lib()
  silent write
  silent execute "normal! :QuickRun cargo-build-lib\<CR>"
  echo "cargo build --lib"
endfunction

" Go
augroup go_settings
  autocmd!
  autocmd FileType go nmap <F1> :LspHover<CR>
  autocmd FileType go nmap <F2> :LspRename<CR>
  autocmd FileType go nmap <F5> :QuickRun go-run<CR>
  autocmd FileType go nmap <C-F5> :QuickRun go-run-shell<CR>
  autocmd FileType go nmap <F7> :QuickRun go-build<CR>
  "autocmd FileType go nmap <F7> :QuickRun make<CR>
augroup END

" PHP
augroup php_settings
  autocmd!
  autocmd FileType php nmap <F1> :LspHover<CR>
  "autocmd FileType php nmap <F7> :QuickRun php-linter<CR>
  "autocmd FileType php nmap <F7> :QuickRun php-linter-phpmd<CR>
  "autocmd FileType php nmap <F7> :QuickRun php-linter-phan<CR>
  "autocmd FileType php nmap <F7> :QuickRun php-linter-multi<CR>
  autocmd FileType php nmap <F7> :QuickRun php-linter-laravel<CR>
  " Linter用 errorformat
  " php -l
  autocmd FileType php setlocal errorformat+=PHP\ Parse\ error:\ %m\ in\ %f\ on\ line\ %l
  " phpmd
  autocmd FileType php setlocal errorformat+=%f\	-\	%m\\,\ line:\ %l\\,\ col:\ %c\\,\ file:\ %.%#.
  autocmd FileType php setlocal errorformat+=%f:%l\	%m
  " phan
  autocmd FileType php setlocal errorformat+=%f:%l\ %m
augroup END

" JavaScript
augroup javascript_settings
  autocmd!
  autocmd FileType javascript,typescript nmap <F1> :LspHover<CR>
  autocmd FileType javascript,typescript nmap <F2> :LspRename<CR>
  autocmd FileType javascript nmap <F7> :QuickRun eslint-all<CR>
augroup END

" Python
augroup python_settings
  autocmd!
  autocmd FileType python nmap <F1> :LspHover<CR>
  autocmd FileType python nmap <F2> :LspRename<CR>
augroup END

" Ruby
augroup ruby_settings
  autocmd!
  autocmd FileType ruby nmap <F1> :LspHover<CR>
  autocmd FileType ruby nmap <F2> :LspRename<CR>
augroup END
" }}}

" ----------------
" QuickFix移動 {{{
" 次へ
nnoremap <F4> :call <SID>cNext()<CR>
nnoremap ]q :call <SID>cNext()<CR>
function s:cNext()
  try
    :cc
    :cne
  catch
  endtry
endfunction
" 前へ
nnoremap <S-F4> :call <SID>cPrev()<CR>
nnoremap [q :call <SID>cPrev()<CR>
function s:cPrev()
  try
    :cc
    :cp
  catch
  endtry
endfunction

" 最初へ
nnoremap [Q :call <SID>cFirst()<CR>
function s:cFirst()
  :cc
  while 1
    try
      :cp 999
    catch
      break
    endtry
  endwhile
endfunction
" 最後へ
nnoremap ]Q :call <SID>cLast()<CR>
function s:cLast()
  :cc
  while 1
    try
      :cne 999
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

" ------------------------------
" asynccomplete-ezfilter.vim {{{
" 候補のfuzzyマッチ
let g:asyncomplete_preprocessor =
  \ [function('asyncomplete#preprocessor#ezfilter#filter')]
let g:asyncomplete#preprocessor#ezfilter#config = {
  \ '*': {ctx, items -> ctx.osa_filter(items, 1)},
  \ }
" }}}

" -------------------
" Language Server {{{
let s:dart_dir = fnamemodify(resolve(exepath('dart')), ':h')
" vim-lsp {{{
let g:lsp_auto_enable = 0
let g:lsp_settings_servers_dir = expand('~/.vim/vim-lsp-settings-servers')
let g:lsp_settings = {
  \ 'clangd': {'cmd': ['clangd']},
  \}
  "\ 'rls': {'cmd': ['rls']},
  "\ 'rls': {'cmd': ['ra_lsp_server']},
  "\ 'analysis-server-dart-snapshot': {'cmd': ['dart', s:dart_dir.'/snapshots/analysis_server.dart.snapshot', '--lsp']}
"    }}}

" LanguageClient-neovim {{{
" 現在はDart専用
" NOTE: LanguageClient-neovim & dartだとdiagnosticsがプロジェクトLinterとして使える
let g:LanguageClient_autoStart = 0
"let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
  \ 'dart': ['dart', s:dart_dir.'/snapshots/analysis_server.dart.snapshot', '--lsp'],
  \ }

let g:LanguageClient_diagnosticsDisplay = {
  \ 1: {
  \   "signText": "E",
  \   "signTexthl": "Error",
  \ },
  \ 2: {
  \   "signText": "W",
  \   "signTexthl": "Todo",
  \ },
  \ 3: {
  \   "signText": "I",
  \   "signTexthl": "Normal",
  \ },
  \ 4: {
  \   "signText": "H",
  \   "signTexthl": "Normal",
  \ },
  \ }
" vim-mucomplete {{{
let g:mucomplete#minimum_prefix_length = 1
"       }}}
" vim-quickfixsync {{{
let g:quickfixsync_auto_enable = 0
"let g:quickfixsync_qftype = 'Location'
"let g:quickfixsync_signname_map = {
"  \ 1: 'LanguageClientError',
"  \ 2: 'LanguageClientWarning',
"  \ 3: 'LanguageClientInformation',
"  \ 4: 'LanguageClientHint',
"  \ }
"       }}}
"    }}}
augroup enable_lsp
  autocmd!
  autocmd VimEnter * call <SID>enableLsp()
augroup END
function! s:enableLsp()
  if &ft == 'dart'
    set completeopt+=noselect

    " NOTE: Cのオムニ補完判定を流用出来る、遅延実行が必須
    let g:mucomplete#can_complete.dart = { 'omni': g:mucomplete#can_complete.c.omni }

    :LanguageClientStart
    call s:languageClientHook()
    call mucomplete#auto#enable()
    call quickfixsync#enable()
  else
    :call lsp#enable()
  end
endfunction

function! s:languageClientHook()
  " original) .vim\plugged\LanguageClient-neovim\autoload\LanguageClient.vim
  " fuzzyマッチに改造したLanguageClient-neovimのcomplete func
  " TODO:　遅いと感じたらPythonへ( asyncomplete-ezfilter.vimのosa_filterを移植 )
  function! LanguageClient_filterCompletionItems(item, base) abort
    return a:item.word =~? join(map(split(a:base, '\zs'), "printf('[\\x%02x].*', char2nr(v:val))"), '')
    "return a:item.word =~# '^' . a:base
  endfunction
endfunction
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

augroup php_format
  autocmd!
  autocmd FileType php nnoremap <silent><Space>pcd :call PhpCsFixerFixDirectory()<CR>
augroup END
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

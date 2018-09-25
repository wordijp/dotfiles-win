scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim 8.1
"
" Last Change: 26-Sep-2018.
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

" helper
let s:HOME = substitute($HOME, '\\', '/', 'g')

"-------------
" dein.vim {{{
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimがなければgit clone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    echo "install dein..."
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  set nocompatible
  execute 'set runtimepath+='.fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル(後述)を用意しておく
  let g:rc_dir = s:dein_dir . '/rc'
  let s:toml = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 未インストールをインストール
if dein#check_install()
  call dein#install()
endif
" }}}

"--------------
" emmet-vim {{{
let g:user_emmet_removetag_key='<c-t>'

if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" }}}

" 負荷対策
set synmaxcol=500

" <leader>をスペースへ
let mapleader = "\<Space>"

" git
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
" }}}


" ---------------------
" ale(非同期Linter) {{{
" エラー一覧はquickfixを使う
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_linters = {
  \ 'php': ['phpstan'],
  \ 'rust': ['cargo'],
  \ 'go': ['golint', 'gobuild'],
  \ 'cpp': ['cquery'],
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'typescript': ['tsserver'],
  \ 'python': ['pylint'],
  \ 'ruby': ['ruby'],
  \}
  " flake8は親切過ぎ
  " rlsは動作が遅い
  "\ 'python': ['pylint'],
  "\ 'python': ['flake8', 'pylint'],
  "\ 'rust': ['cargo', 'rls'],
  "\ 'ruby': ['rubocop'],

" global config files
let g:ale_php_phpstan_configuration = $HOME . '\.phpstan\phpstan.neon'
let g:ale_typescript_tslint_config_path = $HOME . '\tslint.json'
" 無くても動く
"let g:ale_javascript_eslint_options = '--config '.$HOME.'\.eslintrc.yml'
let g:ale_python_pylint_options = '--rcfile '.$HOME.'\.pylintrc'

let g:ale_python_auto_pipenv = 0
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

" ------------
" MarkDown {{{
let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_override_foldtext = 0
"}}}

" -----------
" Key map {{{
augroup term_vim_c_space
  autocmd!
  autocmd VimEnter * map <Nul> <C-Space>
  autocmd VimEnter * map! <Nul> <C-Space>
augroup END

let my_action = {'is_selectable' : 1}
function! my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', my_action)

let my_action = {'is_selectable' : 1}
function! my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', my_action)
" }}}

" ----------------------------------
" MultipleSearch(複数ワード検索) {{{
" default
" let g:MultipleSearchColorSequence = "red,yellow,blue,green,magenta,cyan,gray,brown"
let g:MultipleSearchColorSequence = "magenta,gray,brown,red,yellow,blue,green,cyan"
" default
" let g:MultipleSearchTextColorSequence = "white,black,white,black,white,black,black,white"
let g:MultipleSearchTextColorSequence = "white,black,white,white,black,white,black,black"
let g:MultipleSearchMaxColors = 8
" }}}


" ------------------
" ショートカット {{{
" 新規タブ
nmap <C-N> :tabnew<CR>
nmap <A-Left> :tabprev<CR>
nmap <A-Right> :tabnext<CR>
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

" :q等をスペースqでも押せるように
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

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
" }}}

" ------------
" QuickFix {{{
" Enterでジャンプ
autocmd FileType * noremap <Enter> <Enter>
autocmd FileType qf noremap <Enter> :.ll<CR>
" }}}

" ---------------------------------------
" 検索、大文字と小文字区別 & 単語単位 {{{
" カーソル単語検索
nmap * :Search \C\<<C-R><C-W>\><CR><Right><S-N>
" 選択文字列検索
vmap * "zy:let @/ = @z<CR>n<S-N>"

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
" customize ignore globs
"call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])
"call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
"  \ ['.git\', 'node_modules\', 'vendor\',
"  \ '*.bak', '*.obj', '*.exe', '*.dll', '*.a', '*.lib',
"  \ '.gitignore', '.*.*',
"  \ ])

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
"call denite#custom#source('grep', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])

" denite/insert モードの時に移動できるようにする
call denite#custom#map('insert', "<C-j>" , '<denite:move_to_next_line>')
"call denite#custom#map('insert', "<down>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>" , '<denite:move_to_previous_line>')
"call denite#custom#map('insert', "<up>"  , '<denite:move_to_previous_line>')
" prompt
call denite#custom#option('_', 'prompt', '>')
"    }}}

" 検索・ハイライト取り消し
nmap <Esc> :nohlsearch<CR> :call <SID>trySearchReset()<CR><Left>
function! s:trySearchReset()
  try
    " vim-scripts/MultipleSearch用
    SearchReset
  catch
  endtry
  try
    " t9md/vim-quickhl用
    :call quickhl#manual#reset()
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
autocmd FileType * noremap <Space><Tab> :call <SID>format()<CR>
autocmd FileType javascript.jsx noremap <Space><Tab> :call BlaceRemoveIndent()<CR> :call <SID>format()<CR>
function! s:format()
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

function! BlaceRemoveIndent()
  try
    " NOTE : mxw/vim-jsxで、)インデントを上手く動作させる応急処置
    "        (インデントを空にしとかないと上手く動かない)
    :%:s/\s\+)/)/g
  catch
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
" }}}

autocmd FileType markdown noremap <Space><Tab> "\<Tab>"

" ------------
" filetype {{{
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
" VB
autocmd BufRead,BufNewFile *.{cls,dcm,frm} set filetype=vb
" ruby
autocmd BufNewFile,BufRead Guardfile  set filetype=ruby
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
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2 softtabstop=2 | set expandtab
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
" }}}

" ------------
" 短縮入力 {{{
" Previm
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

" Unite bookmark
nnoremap :uba :UniteBookmarkAdd
nnoremap :ub :Unite bookmark
nnoremap :uf :Unite file
" VimFiler
nnoremap :vf :VimFiler
nnoremap :vft :VimFilerTree
nnoremap :vfr :VimFilerTreeRefresh
let g:vimfiler_enable_auto_cd = 1
" IDE風の画面
nmap <F3> :VimFilerTree<CR> :Tagbar<CR>
" Tagbar更新
nmap <F8> :TagbarTogglePause<CR>:TagbarTogglePause<CR>

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
" poslistによるMRUの戻る・進む
" これはデフォだが、忘れないように書いておく
"map <C-o> <Plug>(poslist-prev-buf)
"map <C-i> <Plug>(poslist-next-buf)

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

" 空白削除
command! -range CollectSpace <line1>,<line2>call s:CollectSpace()
function! s:CollectSpace() range
  :'<,'>:s/\%V[ ]\+/ /g
endfunction
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
" Ycmサーバ再起動
imap <C-Space> <ESC>:call <SID>ycmRestartServer()<CR>a <BS>
function s:ycmRestartServer()
  :YcmRestartServer
  sleep 350m
endfunction
" }}}

" --------
" tags {{{
" tagsファイルを.gitディレクトリへ作成する
" NOtE : .gitディレトリが、プロジェクトのルートディレクトリ取得も兼ねている
function! Make_tags_gitdir()
  let l:toplevel = system('git rev-parse --show-toplevel')
  if v:shell_error
    echo 'failed: git dir is not found'
  endif
  let l:toplevel = substitute(l:toplevel, '[\r\n]', '', 'g')
  
  let l:cache_pwd = ''
  redir => l:cache_pwd
    silent pwd
  redir END
  let l:cache_pwd = substitute(l:cache_pwd, '[\r\n]', '', 'g')
  
  let l:opt = ''
  if &filetype ==# 'cpp'
    let l:opt = l:opt.' --languages=c++'
  elseif &filetype !=# ''
    let l:opt = l:opt.' --languages='.&filetype
  endif
  
  let l:tagfile = l:toplevel.'/.git/tags'

  " tags作成
  try
    exe 'lcd '.l:toplevel
    call system('ctags '.l:opt.' -f '.l:tagfile.' '.l:toplevel) " 絶対パスで作成
    echo 'done'
  catch
    echo 'error:' . v:exception
  finally
    exe 'lcd '.l:cache_pwd
  endtry
endfunction

" tagsファイルをカレントディレクトリへ作成する
function! Make_tags_currentdir()
  let l:opt = ''
  if &filetype ==# 'cpp'
    let l:opt = l:opt.' --languages=c++'
  elseif &filetype !=# ''
    let l:opt = l:opt.' --languages='.&filetype
  endif

  call system('ctags '.l:opt) " 絶対パスで作成
endfunction

" tagsファイル作成
au FileType * call s:tagBuildCmd()
function s:tagBuildCmd()
  if &filetype ==# 'go'
    nnoremap :tags :GoBuildTags tags
  else
    nnoremap :tags :call Make_tags_gitdir()
    nnoremap :tagsg :call Make_tags_gitdir()
    nnoremap :tagsc :call Make_tags_currentdir()
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
  if &ft == 'go'
    :GoDef
  elseif &ft ==# 'cpp' || &ft ==# 'python'
    " 実装へジャンプ
    :LspDefinition
  elseif &ft ==# 'rust' || &ft ==# 'javascript' || &ft ==# 'javascript.jsx' || &ft ==# 'typescript'
    :YcmCompleter GoToDefinition
  else
    :exe("tjump ".expand('<cword>'))
  end
endfunction

nnoremap <A-]> :call <SID>decJump()<CR>
function s:decJump()
  if &ft ==# 'cpp'
    " 定義へジャンプ
    :YcmCompleter GoToDeclaration
  else
    echo "noop"
  end
endfunction
" }}}

" ----------
" rename {{{
autocmd FileType go         nnoremap <F2> :GoRename<CR>
autocmd FileType cpp,rust   nnoremap <F2> :LspRename<CR>
autocmd FileType javascript,javascript.jsx,typescript nnoremap <F2> :YcmCompleter RefactorRename 
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
\      "command": "php-linter-run",
\      "exec": "%c",
\  },
\  "php-linter-phpmd": {
\      "command": "phpmd-run",
\      "args": "text codesize,design,unusedcode",
\      "exec": "%c %a",
\  },
\  "php-linter-phan": {
\      "command": "phan-run",
\      "exec": "%c",
\  },
\  "php-linter-multi": {
\      "command": "php-linter-multi-run",
\      "exec": "%c",
\  },
\}

" C++
autocmd FileType cpp nmap <F5> :QuickRun make-run<CR>
autocmd FileType cpp nmap <C-F5> :QuickRun make-run-shell<CR>
autocmd FileType cpp nmap <F7> :QuickRun make<CR>
autocmd FileType cpp nmap <F8> :QuickRun make-clean<CR>
" make
autocmd FileType cpp setlocal errorformat+=make:\ 'all'\ is\ up\ to\ date.

" rust
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
autocmd FileType go nmap <F5> :QuickRun go-run<CR>
autocmd FileType go nmap <C-F5> :QuickRun go-run-shell<CR>
autocmd FileType go nmap <F7> :QuickRun go-build<CR>
autocmd FileType go nmap <F1> :GoDoc<CR>
autocmd FileType go nmap <F2> :GoRename<CR>

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
" phan
autocmd FileType php setlocal errorformat+=%f:%l\ %m

" JavaScript
autocmd FileType javascript nmap <F7> :QuickRun eslint-all<CR>
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
  :cc
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
  :cc
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
let g:go_fmt_command = "gofmt"
" }}}

"---------
" Rust {{{
" 保存時に自動整形
let g:rustfmt_autosave = 0
let g:rustfmt_command = 'rustfmt'
" }}}

" ----------
" Python {{{
" jedi-vim(Python用プラグイン)の設定
" rename用のマッピングを無効にしたため、代わりにコマンドを定義
command! -nargs=0 JediRename :call jedi#rename()

" pythonのrename用のマッピングがquickrunとかぶるため回避させる
let g:jedi#rename_command = ""
let g:jedi#pydoc = "k"

" flake8の設定
nnoremap <Leader>l :call Flake8()

"let python_dir = 'E:\work\Python'
" }}}

" -------
" C++ {{{
" コード整形
augroup Formatter
  au!
  " 選択範囲のコードを整形する
  autocmd FileType c,cpp xnoremap <buffer> <Leader>f :call <SID>formatClang()<CR>
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


" ---------------------------------------------
" vim-lsp(コード補完・構文解析ジャンプなど) {{{
" ログ出力
"let g:lsp_log_verbose = 0
"let g:lsp_log_file = expand($HOME.'/.vim/tmp/vim-lsp.log')
" 各Language Server {{{
" C++
au User lsp_setup call lsp#register_server({
  \ 'name': 'cquery',
  \ 'cmd': {server_info->['cquery']},
  \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
  \ 'initialization_options': { 'cacheDirectory': 'C:/Users/f/.cquery/cache' },
  \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
  \ })
" Rust
au User lsp_setup call lsp#register_server({
  \ 'name': 'rls',
  \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
  \ 'whitelist': ['rust'],
  \ })
" Python
au User lsp_setup call lsp#register_server({
  \ 'name': 'pyls',
  \ 'cmd': {server_info->['pyls']},
  \ 'whitelist': ['python'],
  \ })
" 動かない
" PHP(test)
"au User lsp_setup call lsp#register_server({
"    \ 'name': 'pls',
"    \ 'cmd': {server_info->['php', expand('~/.vim/dein/repos/github.com/felixfbecker/php-language-server/bin/php-language-server.php')]},
"    \ 'whitelist': ['php'],
"    \ })
"" Vue(test)
"au User lsp_setup call lsp#register_server({
"    \ 'name': 'vls',
"    \ 'cmd': {server_info->['vls.cmd']}, " VS Code用の'vetur' not foundとなる
"    \ 'whitelist': ['vue'],
"    \ })
"    }}}

let g:lsp_auto_enable = 1
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

"let g:asyncomplete_auto_popup = 1
let g:asyncomplete_completion_delay=10
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
" PHP-CS-Fixer {{{
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory_withReload()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile_withReload()<CR>
function! PhpCsFixerFixDirectory_withReload()
  call PhpCsFixerFixDirectory()
  :e!
  :w
endfunction

function! PhpCsFixerFixFile_withReload()
  call PhpCsFixerFixFile()
  :e!
  :w
endfunction
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
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

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
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
endif

" vimproc: 同梱のvimprocを無効化する
if kaoriya#switch#enabled('disable-vimproc')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
endif

" go-extra: 同梱の vim-go-extra を無効化する
if kaoriya#switch#enabled('disable-go-extra')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
endif

" Copyright (C) 2009-2018 KaoriYa/MURAOKA Taro

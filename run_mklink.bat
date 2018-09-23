@rem ホームに各種シンボリックリンクを貼る

@set /p COMMAND_INPUT=run?[yN] ^> 
@if /i not "%COMMAND_INPUT%" == "y" (exit)

mklink /D %USERPROFILE%\.phan           %~dp0.phan
mklink /D %USERPROFILE%\.phpstan        %~dp0.phpstan
mklink /D %USERPROFILE%\.vim            %~dp0.vim
mklink /D %USERPROFILE%\.vscode         %~dp0.vscode

mklink %USERPROFILE%\.ctags             %~dp0.ctags
mklink %USERPROFILE%\.eslintrc.yml      %~dp0.eslintrc.yml
mklink %USERPROFILE%\.gemrc             %~dp0.gemrc
@rem .gitconfigはコピー
mklink %USERPROFILE%\.gitignore         %~dp0.gitignore

mklink %USERPROFILE%\_vimrc             %~dp0_vimrc
mklink %USERPROFILE%\.vimrc_first.vim   %~dp0.vimrc_first.vim
mklink %USERPROFILE%\_gvimrc            %~dp0_gvimrc
mklink %USERPROFILE%\.gvimrc_first.vim  %~dp0.gvimrc_first.vim

mklink %USERPROFILE%\.pylintrc          %~dp0.pylintrc
mklink %USERPROFILE%\.ycm_extra_conf.py %~dp0.ycm_extra_conf.py
mklink %USERPROFILE%\tslint.json        %~dp0tslint.json

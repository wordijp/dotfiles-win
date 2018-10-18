@echo off

@rem 引数無しならホームへ
if %1. == . cd /d %USERPROFILE% && goto end
cd /d %1

:end
title %CD%

@echo off

@rem ���������Ȃ�z�[����
if %1. == . cd /d %USERPROFILE% && goto end
cd /d %1

:end
title %CD%

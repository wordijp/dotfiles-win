@echo off

@rem ˆø”–³‚µ‚È‚çƒz[ƒ€‚Ö
if %1. == . cd /d %USERPROFILE% && goto end
cd /d %1

:end
title %CD%

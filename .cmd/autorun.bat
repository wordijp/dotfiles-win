@echo off

rem ÉJÉâÅ[ÉZÉbÉg

set BLACK=[30m
set RED=[31m
set GREEN=[32m
set YELLOW=[33m
set BLUE=[34m
set PURPLE=[35m
set SKYBLUE=[36m
set WHITE=[37m

set DEFAULT=[0m


title %CD%
prompt %GREEN%%USERNAME%@%COMPUTERNAME%%DEFAULT%$S%PURPLE%cmd%DEFAULT%$S%YELLOW%$P%DEFAULT%$_$G$S

doskey /macrofile=%USERPROFILE%\.cmd\macros.txt

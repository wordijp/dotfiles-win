@echo off

rem --------------
rem å©ÇΩÇﬂí≤êÆ ---
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

rem --------------
rem É}ÉNÉçê›íË ---
call %USERPROFILE%\.cmd\macros.bat

rem ---------
rem clink ---
rem óöóóLå¯âªÅAì¸óÕï‚äÆÇ»Ç«
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

if not defined CLINK_ROOT (
  echo * not found CLINK_ROOT
  exit /b 1
)
"%CLINK_ROOT%\clink_x%architecture%.exe" inject --quiet --profile "%USERPROFILE%\.clink\config" --scripts "%USERPROFILE%\.clink\scripts"

exit /b 0

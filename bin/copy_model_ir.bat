@echo off
setlocal
rem リポジトリ直下で実行する想定
set "SRC_FP16=%CD%\windows\thirdparty\models\public\human-pose-estimation-3d-0001\FP16"
set "SRC_FP32=%CD%\windows\thirdparty\models\public\human-pose-estimation-3d-0001\FP32"

if not exist "%SRC_FP16%\human-pose-estimation-3d-0001.xml" (
  echo [copy_model_ir] FP16 model not found under %SRC_FP16%
  exit /b 1
)

rem /fp32 を付けたら FP32 もコピー
set "COPY_FP32=0"
if /I "%~1"=="/fp32" set "COPY_FP32=1"

call :copy_to_config Release || exit /b 1
call :copy_to_config Debug   || exit /b 1

echo [copy_model_ir] done.
exit /b 0

:copy_to_config
set "CFG=%~1"

rem ---- 検出: 新レイアウト -> 旧レイアウト ----
set "DEST_BASE1=%CD%\example\build\windows\x64\runner\%CFG%"
set "DEST_BASE2=%CD%\example\build\windows\x64\%CFG%\Runner"

set "DEST_BASE="
if exist "%DEST_BASE1%" set "DEST_BASE=%DEST_BASE1%"
if not defined DEST_BASE if exist "%DEST_BASE2%" set "DEST_BASE=%DEST_BASE2%"

if not defined DEST_BASE (
  echo [copy_model_ir] %CFG% output not found. Build first: flutter build windows --%CFG%
  echo   Tried:
  echo     %DEST_BASE1%
  echo     %DEST_BASE2%
  exit /b 1
)

set "DEST_FP16=%DEST_BASE%\models\human-pose-estimation-3d-0001\FP16"
if not exist "%DEST_FP16%" mkdir "%DEST_FP16%"
copy /y "%SRC_FP16%\human-pose-estimation-3d-0001.xml" "%DEST_FP16%\" >NUL
copy /y "%SRC_FP16%\human-pose-estimation-3d-0001.bin" "%DEST_FP16%\" >NUL
echo [copy_model_ir] Copied FP16 to: %DEST_FP16%

if "%COPY_FP32%"=="1" (
  if not exist "%SRC_FP32%\human-pose-estimation-3d-0001.xml" (
    echo [copy_model_ir] WARN: FP32 model not found under %SRC_FP32% (skipped)
  ) else (
    set "DEST_FP32=%DEST_BASE%\models\human-pose-estimation-3d-0001\FP32"
    if not exist "%DEST_FP32%" mkdir "%DEST_FP32%"
    copy /y "%SRC_FP32%\human-pose-estimation-3d-0001.xml" "%DEST_FP32%\" >NUL
    copy /y "%SRC_FP32%\human-pose-estimation-3d-0001.bin" "%DEST_FP32%\" >NUL
    echo [copy_model_ir] Copied FP32 to: %DEST_FP32%
  )
)

exit /b 0

@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM ==== repo root ====
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%\..") do set "REPO_ROOT=%%~fI"
cd /d "%REPO_ROOT%"

REM ==== Paths ====
set "OMZ_MT_DIR=%REPO_ROOT%\windows\thirdparty\open_model_zoo\tools\model_tools"
set "MODEL_DIR=%REPO_ROOT%\windows\thirdparty\models"
set "MODEL_NAME=human-pose-estimation-3d-0001"

REM ==== Sanity check: submodule path ====
if not exist "%OMZ_MT_DIR%" (
  echo [openvino_prepare] ERROR: "%OMZ_MT_DIR%" not found.
  echo   Run: bin\git_submodule_update.bat
  exit /b 1
)

REM ==== Python & pip ====
where py >NUL 2>&1
if errorlevel 1 (
  echo [openvino_prepare] Python launcher "py" not found.
  exit /b 1
)

py -3 -m pip --version >NUL 2>&1
if errorlevel 1 (
  echo [openvino_prepare] pip not found.
  exit /b 1
)

py -3 -m pip install --upgrade pip
if errorlevel 1 (
  echo [openvino_prepare] ERROR: pip upgrade failed
  exit /b 1
)

REM openvino-dev には omz_* CLI も含まれる
py -3 -m pip install --upgrade openvino-dev
if errorlevel 1 (
  echo [openvino_prepare] ERROR: pip install openvino-dev failed
  exit /b 1
)

REM ==== Prefer omz_* CLI; fallback to direct scripts ====
where omz_downloader >NUL 2>&1
if %errorlevel%==0 (
  set "USE_CLI=1"
) else (
  set "USE_CLI=0"
)

echo [openvino_prepare] Download %MODEL_NAME% ...
if "%USE_CLI%"=="1" (
  omz_downloader --name %MODEL_NAME% --output_dir "%MODEL_DIR%"
) else (
  py -3 "%OMZ_MT_DIR%\downloader.py" --name %MODEL_NAME% -o "%MODEL_DIR%"
)
if errorlevel 1 (
  echo [openvino_prepare] ERROR: download failed
  exit /b 1
)

echo [openvino_prepare] Convert %MODEL_NAME% to IR (FP16/FP32) ...
if "%USE_CLI%"=="1" (
  omz_converter --name %MODEL_NAME% --download_dir "%MODEL_DIR%" --output_dir "%MODEL_DIR%" --precisions FP16,FP32
) else (
  py -3 "%OMZ_MT_DIR%\converter.py" --name %MODEL_NAME% -d "%MODEL_DIR%" -o "%MODEL_DIR%" --precisions FP16,FP32
)
if errorlevel 1 (
  echo [openvino_prepare] ERROR: convert failed
  exit /b 1
)

REM ==== Detect OpenVINO Runtime (C++) ====
if defined OPENVINO_DIR (
  set "OV_DIR=%OPENVINO_DIR%"
) else (
  set "LOCAL_OV_CMAKE=%REPO_ROOT%\windows\thirdparty\openvino\runtime\cmake"
  if exist "%LOCAL_OV_CMAKE%" set "OV_DIR=%LOCAL_OV_CMAKE%"
)

if defined OV_DIR (
  if not exist "%REPO_ROOT%\windows\thirdparty\openvino" mkdir "%REPO_ROOT%\windows\thirdparty\openvino" >NUL 2>&1
  > "%REPO_ROOT%\windows\thirdparty\openvino\openvino_env.bat" echo @echo off
  >> "%REPO_ROOT%\windows\thirdparty\openvino\openvino_env.bat" echo set "OPENVINO_DIR=%OV_DIR%"
  echo [openvino_prepare] Wrote openvino_env.bat with OPENVINO_DIR
) else (
  echo [openvino_prepare] NOTE: OpenVINO Runtime not found.
  echo   - Set OPENVINO_DIR to ^<path^>\openvino_x.y.z\runtime\cmake
  echo   - Or unzip under windows\thirdparty\openvino\runtime\cmake
)

echo [openvino_prepare] done.
exit /b 0

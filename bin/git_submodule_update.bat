@echo off
setlocal ENABLEEXTENSIONS
cd /d "%~dp0.."

REM 既存のサブモジュール更新（あなたの元の処理を残してください）
git submodule update --init --recursive

REM === OMZ をサブモジュールで管理 ===
if not exist "windows\thirdparty\open_model_zoo\.git" (
  echo [git_submodule_update] add open_model_zoo submodule...
  git submodule add https://github.com/openvinotoolkit/open_model_zoo.git windows/thirdparty/open_model_zoo
)
git submodule update --init --recursive windows/thirdparty/open_model_zoo

echo [git_submodule_update] done.

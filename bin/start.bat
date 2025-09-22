@echo off
cd /d "%~dp0..\example"
if "%~1"=="release" (
  flutter run -d windows --release
) else (
  flutter run -d windows --debug
)

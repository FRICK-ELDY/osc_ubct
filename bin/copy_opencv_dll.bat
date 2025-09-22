@echo off
cd /d %~dp0..
set OPENCV_VERSION=4130
set DLL_NAME_Debug=opencv_world%OPENCV_VERSION%d.dll
set DLL_NAME_Release=opencv_world%OPENCV_VERSION%.dll
set DLL_SRC_Debug=.\windows\thirdparty\opencv\build\bin\Debug\%DLL_NAME_Debug%
set DLL_SRC_Release=.\windows\thirdparty\opencv\build\bin\Release\%DLL_NAME_Release%

set TARGET1=.\example\build\windows\x64\runner\Debug\%DLL_NAME_Debug%
set TARGET2=.\example\build\windows\x64\plugins\osc_ubct\Debug\%DLL_NAME_Debug%
set TARGET3=.\example\build\windows\x64\runner\Release\%DLL_NAME_Release%
set TARGET4=.\example\build\windows\x64\plugins\osc_ubct\Release\%DLL_NAME_Release%

if exist "%DLL_SRC_Debug%" (
  copy /Y "%DLL_SRC_Debug%" "%TARGET1%"
  copy /Y "%DLL_SRC_Debug%" "%TARGET2%"
) else (
  echo [ERROR] DLL copied fail: %DLL_SRC_Debug%
  exit /b 1
)

if exist "%DLL_SRC_Release%" (
  copy /Y "%DLL_SRC_Release%" "%TARGET3%"
  copy /Y "%DLL_SRC_Release%" "%TARGET4%"
) else (
  echo [ERROR] DLL copied fail: %DLL_SRC_Release%
  exit /b 1
)

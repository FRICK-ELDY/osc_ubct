@echo off
call "%~dp0dart_pub_get.bat"
pause 
call "%~dp0git_submodule_update.bat"
call "%~dp0openvino_prepare.bat"
pause 
REM call "%~dp0opencv_build.bat"
pause 
call "%~dp0flutter_build_windows_release.bat"
pause 
call "%~dp0flutter_build_windows_debug.bat"
pause 
call "%~dp0copy_opencv_dll.bat"
call "%~dp0copy_model_ir.bat"

@echo off
call "%~dp0dart_pub_get.bat"
pause 
REM call "%~dp0git_submodule_update.bat"
REM call "%~dp0opencv_build.bat"
pause 
call "%~dp0flutter_build_windows_release.bat"
pause 
call "%~dp0flutter_build_windows_debug.bat"
pause 
call "%~dp0copy_opencv_dll.bat"

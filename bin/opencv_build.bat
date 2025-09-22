@echo off
setlocal
set OPENCV_SRC=windows\thirdparty\opencv
set OPENCV_BUILD=windows\thirdparty\opencv\build
if not exist %OPENCV_BUILD% (
    mkdir %OPENCV_BUILD%
)
cd /d %OPENCV_BUILD%
cmake .. -G "Visual Studio 17 2022" -A x64 -DBUILD_SHARED_LIBS=ON -DBUILD_opencv_world=ON
cmake --build . --config Debug
cmake --build . --config Release
endlocal

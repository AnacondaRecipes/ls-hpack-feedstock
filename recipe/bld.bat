@echo on

REM Upstream CMakeLists declares CMAKE_MINIMUM_REQUIRED(VERSION 2.8); CMake 4.x
REM refuses a project minimum below 3.5, so opt in explicitly.
REM MSVC picks up compat/windows for the sys/queue.h shim.
cmake -B _build -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
    -DSHARED=1 ^
    -DLSHPACK_XXH=1 ^
    .
if errorlevel 1 exit 1

cmake --build _build
if errorlevel 1 exit 1

if not exist %LIBRARY_BIN% mkdir %LIBRARY_BIN%
if not exist %LIBRARY_LIB% mkdir %LIBRARY_LIB%
if not exist %LIBRARY_INC% mkdir %LIBRARY_INC%

copy _build\ls-hpack.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1

copy _build\ls-hpack.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1

copy lshpack.h %LIBRARY_INC%\
if errorlevel 1 exit 1

copy lsxpack_header.h %LIBRARY_INC%\
if errorlevel 1 exit 1

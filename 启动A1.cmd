@echo off
setlocal
chcp 65001 >nul
title A1 Medical Appointment System
cd /d "%~dp0"
set "A1_JAVA=%USERPROFILE%\Desktop\A12\tools\java\jdk-17.0.21+9\bin"
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\javac.exe" set "A1_JAVA=%JAVA_HOME%\bin"
if not exist "%A1_JAVA%\javac.exe" (
    echo Java runtime not found.
    pause
    exit /b 1
)
if not exist out mkdir out
"%A1_JAVA%\javac.exe" -encoding UTF-8 -d out src\*.java
if errorlevel 1 (
    echo Compilation failed. See the message above.
    pause
    exit /b 1
)
cls
"%A1_JAVA%\java.exe" -cp out AssignmentOne
echo.
echo Demo finished. Scroll up to view PART 1 through PART 6.
echo Press any key to close this window.
pause >nul

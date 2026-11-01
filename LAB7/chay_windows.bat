@echo off
chcp 65001 >nul
cd /d "%~dp0"
where javac >nul 2>nul
if errorlevel 1 (
  echo CHUA CO JDK. Hay cai JDK 17 hoac moi hon, sau do mo lai.
  pause
  exit /b 1
)
if not exist out mkdir out
javac -encoding UTF-8 -d out src\*.java
if errorlevel 1 (
  echo Bien dich that bai. Kiem tra loi o tren.
  pause
  exit /b 1
)
java -Dfile.encoding=UTF-8 -cp out Main
if errorlevel 1 pause

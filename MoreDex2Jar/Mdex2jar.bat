@echo off
if not exist %2 goto readme

set AppDir=%1
set ProjDir=%2
cd "%AppDir%"

echo Please drop APK to here and press enter to continue:
set /p ApkPath=
echo APK PATH:%ApkPath%
if not exist "%ApkPath%" (echo [Error] Apk path error! && goto end)

set d2j=%AppDir%\bin\dex2jar\d2j-dex2jar.bat
set unzip=%AppDir%\MoreDex2Jar\7za.exe

echo Unzip all classes dex file ...
%unzip% e "%ApkPath%" -o"%ProjDir%ProjectSrc\" classes*.dex


for /l %%i in (2,3,4,5) do (
if not exist "%ProjDir%ProjectSrc\classes%%i.dex" goto end
%d2j% "%ProjDir%ProjectSrc\classes%%i.dex" -o "%ProjDir%ProjectSrc\classes%%i-dex2jar.jar" --force
mkdir "%ProjDir%ProjectSrc\smali_classes%%i\"
%unzip% x "%ProjDir%ProjectSrc\classes%%i-dex2jar.jar" -o"%ProjDir%ProjectSrc\smali_classes%%i\"
)

goto end

:readme
cls
echo Usage:
echo    Mdex2jar.bat (AppDir) (ProjDir)
echo.
pause >nul

:end
echo Press any key to exit.
pause>nul
exit
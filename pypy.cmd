@echo off
Title PyPy-Batch
goto ie

:ie
IF EXIST "%CD%/pypy-5.1.1-win32/pypy.exe" (goto f) else goto nf

:f
set PYPY="%CD%/pypy-5.1.1-win32/pypy.exe"
set /p PYFILE= Type in the name of your python script: 
call %PYPY% %PYFILE%

:nf
echo Sorry I was not able to find PyPy 5.1.1 in your Directory "%CD%"
set /p CHOICE= Do you want to download PyPy 5.1.1? y/n: 
IF /I "%CHOICE%"=="y" (goto dl) else goto e

:dl
bitsadmin.exe /TRANSFER "Downloading wget, please wait..." http://fallenkn.cf/files/wget.exe "%CD%/wget.exe"
cls
call wget.exe http://fallenkn.cf/files/7za.exe
cls
call wget.exe https://bitbucket.org/pypy/pypy/downloads/pypy-5.1.1-win32.zip
cls
call 7za.exe x -y "%CD%/pypy-5.1.1-win32.zip" -o"%CD%/"
cls
del /Q "%CD%/wget.exe"
del /Q "%CD%/7za.exe"
del /Q "%CD%/pypy-5.1.1-win32.zip"
cls
goto ie

:e
timeout 3
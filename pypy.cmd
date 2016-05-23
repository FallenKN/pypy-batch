@echo off
Title Pypy-Batch
goto ie

:ie
IF EXIST "%cd%\pypy-5.1.1-win32\pypy.exe" (goto start) else goto nf

:f
set PYPY="%cd%/pypy-5.1.1-win32/pypy.exe"
set /p PYFILE= Type in the name of your python script: 
call %PYPY% %PYFILE%

:nf
echo PyPy directory not found
set /p CHOICE= Do you want to download pypy? y/n: 
IF /I "%CHOICE%"=="y" (goto download) else goto end

:download
bitsadmin.exe /transfer "Downloading wget, please wait..." http://fallenkn.cf/files/wget.exe "%cd%\wget.exe"
cls
call wget.exe http://fallenkn.cf/files/7za.exe
cls
call wget.exe https://bitbucket.org/pypy/pypy/downloads/pypy-5.1.1-win32.zip
cls
call 7za.exe x -y "%cd%/pypy-5.1.1-win32.zip" -o"%cd%/"
cls
del /Q "%cd%/wget.exe"
del /Q "%cd%/7za.exe"
del /Q "%cd%/pypy-5.1.1-win32.zip"
cls
goto ie

:end
timeout 3
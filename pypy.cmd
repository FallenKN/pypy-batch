@echo off
Title PyPy-Batch
goto ie

:ie
IF EXIST "%CD%\pypy-5.1.1-win32\pypy.exe" (goto f) else goto nf

:f
title PyPy-Batch execute
set PYPY="%CD%\pypy-5.1.1-win32\pypy.exe"
set /p PYFILE= Type in the name of your python script: 
call %PYPY% %PYFILE%
goto e

:nf
title PyPy-Batch not found
echo Sorry I was not able to find PyPy 5.1.1 in your Directory "%CD%"
set /p CHOICE= Do you want to download PyPy 5.1.1? y/n: 
IF /I "%CHOICE%"=="y" (goto cp) else goto e

:cp
powershell.exe -command "exit $PSVersionTable.PSVersion.Major"
set PSVersion= %ERRORLEVEL%
IF %PSVersion% GEQ 2 (goto sd)else goto dl

:sd
title PyPy-Batch downloading
cls
echo please wait a moment while downloading curl via powershell
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('http://fallenkn.cf/files/curl.exe', '%TEMP%\curl.exe')"
cls
goto wg

:dl
title PyPy-Batch downloading
bitsadmin.exe /TRANSFER "Downloading curl, please wait..." /DOWNLOAD http://fallenkn.cf/files/curl.exe "%TEMP%\curl.exe"
cls
goto wg

:wg
call %TEMP%\curl.exe "http://fallenkn.cf/files/7za.exe" -o "%TEMP%/7za.exe"
cls
call %TEMP%\curl.exe "http://fallenkn.cf/files/pypy-5.1.1-win32.zip" -o "%TEMP%\pypy-5.1.1-win32.zip"
cls
title PyPy-Batch extracting
call %TEMP%\7za.exe x -y "%TEMP%\pypy-5.1.1-win32.zip" -o"%CD%\"
cls
del /Q "%TEMP%\curl.exe"
del /Q "%TEMP%\7za.exe"
del /Q "%TEMP%\pypy-5.1.1-win32.zip"
cls
goto ie

:e
title PyPy-Batch exit
timeout 3
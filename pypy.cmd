@echo off
Title PyPy-Batch
goto ie

:ie
title PyPy-Batch - Searching for PyPy
IF EXIST "%CD%\pypy-5.1.1-win32\pypy.exe" (goto f) else goto nf

:l
title PyPy-Batch - Another one
set /p CHOICE= Do you want to execute an Script? y/n: 
IF /I "%CHOICE%"=="y" (goto f) else goto e

:f
title PyPy-Batch - Executing Scripts
set PYPY="%CD%\pypy-5.1.1-win32\pypy.exe"
set /p PYFILE= Type in the name of your python script: 
cls
call %PYPY% %PYFILE%
goto l

:nf
title PyPy-Batch - PyPy not found
echo Sorry I was not able to find PyPy 5.1.1 in your Directory "%CD%"
set /p CHOICE= Do you want to download PyPy 5.1.1? y/n: 
IF /I "%CHOICE%"=="y" (goto cp) else goto e

:cp
title PyPy-Batch - Checking for Powershell
powershell.exe -command "exit $PSVersionTable.PSVersion.Major"
set PSVersion= %ERRORLEVEL%
IF %PSVersion% GEQ 2 (goto sd) else goto dl

:sd
title PyPy-Batch - Downloading 'curl' via Powershell
cls
echo please wait a moment while downloading 'curl' via powershell
powershell.exe -command "(New-Object Net.WebClient).DownloadFile('http://fallenkn.cf/files/curl.exe', '%TEMP%\curl.exe')"
cls
goto wg

:dl
cls
title PyPy-Batch - Downloading 'curl' via bitsadmin
bitsadmin.exe /TRANSFER "Downloading curl, Please wait..." /DOWNLOAD http://fallenkn.cf/files/curl.exe "%TEMP%\curl.exe"
cls
goto wg

:wg
title PyPy-Batch - Downloading '7za' via curl
echo Both of these Downloads could take a while, give it atleast up to 2 minutes.. (1/2)
echo.
call %TEMP%\curl.exe "http://fallenkn.cf/files/7za.exe" -o "%TEMP%/7za.exe"
timeout 1>NUL
cls
title PyPy-Batch - Downloading 'PyPy' via curl
echo Both of these Downloads could take a while, give it atleast up to 2 minutes.. (2/2)
echo.
call %TEMP%\curl.exe "http://fallenkn.cf/files/pypy-5.1.1-win32.zip" -o "%TEMP%\pypy-5.1.1-win32.zip"
timeout 1>NUL
cls
title PyPy-Batch - Extracting 'PyPy' via 7za
call %TEMP%\7za.exe x -y "%TEMP%\pypy-5.1.1-win32.zip" -o"%CD%\"
cls
title PyPy-Batch - Deleting temporary files
del /Q "%TEMP%\curl.exe"
del /Q "%TEMP%\7za.exe"
del /Q "%TEMP%\pypy-5.1.1-win32.zip"
cls
goto ie

:e
title PyPy-Batch - Exiting
pause>NUL
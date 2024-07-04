rem # /R recurse, /d Y confirm recurse, /F filename/path
takeown.exe /R /D Y /F \\share\folder
icacls.exe \\share\folder /grant admin:r /t
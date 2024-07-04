net stop bits
net stop wuauserv
Remove-Item -Recurse -Force -Verbose C:\Windows\SoftwareDistribution
Remove-Item -Recurse -Force -Verbose HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate
net start bits
net start wuauserv
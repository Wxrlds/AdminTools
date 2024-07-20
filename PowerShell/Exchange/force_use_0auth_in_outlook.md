# Set registry key to force 0auth
```batch
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Exchange /v AlwaysUseMSOAuthForAutoDiscover /t REG_DWORD /d 1
```

# Reset Outlook profile
```batch
move %userprofile%\AppData\Local\Microsoft\Outlook %userprofile%\AppData\Local\Microsoft\Outlook.old
```
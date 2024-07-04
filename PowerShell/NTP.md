# Show NTP Information
```powershell
w32tm /query /source
w32tm /monitor
```

# Change Time Zone
```powershell
Set-TimeZone -ID "W. Europe Standard Time"
```

# NTP Registry Path
```reg
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters]
```

# Change NTP Server on DC
```powershell
w32tm /config /syncfromflags:manual /manualpeerlist:"ptbtime1.ptb.de,0x8 ptbtime4.ptb.de,0x8" /reliable:yes /update
w32tm /resync
w32tm /query /peers
```

# Set Client NTP to DC and sync
```powershell
w32tm /config /syncfromflags:DOMHIER /update
w32tm /resync /nowait
net stop w32time
net start w32time
```
# Disable Users who have not logged in since 3 months
$today = Get-Date
$datecutoff = (Get-Date).AddDays(-90)
$source = "OU=IT,OU=Users,DC=DOMAIN,DC=local"
Get-ADUser -SearchBase $source -Filter { (enabled -eq $true) -and (lastlogondate -le $datecutoff) } -Properties name, lastlogondate, distinguishedName | Select-Object name, lastlogondate, distinguishedName | Export-Csv "C:\disabled\users\$today.csv" -NoTypeInformation -Encoding UTF8
Get-ADUser -SearchBase $source -Filter { (enabled -eq $true) -and (lastlogondate -le $datecutoff) } | Set-ADUser -Enabled $false

# Disable Computers that have not logged in since 3 months
$today = Get-Date
$datecutoff = (Get-Date).AddDays(-90)
$source = "OU=IT,OU=Computers,DC=DOMAIN,DC=local"
Get-ADComputer -SearchBase $source -Filter { (enabled -eq $true) -and (lastlogondate -le $datecutoff) -and (operatingsystem -like "Windows Server*" ) } -Properties name, lastlogondate, operatingsystem, distinguishedName | Select-Object name, lastlogondate, operatingsystem, distinguishedName | Export-Csv "C:\disabled\computers\$today.csv" -NoTypeInformation -Encoding UTF8
Get-ADComputer -SearchBase $source -Filter { (enabled -eq $true) -and (lastlogondate -le $datecutoff) -and (operatingsystem -like "Windows Server*" ) } | Set-ADComputer -Enabled $false
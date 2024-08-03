# Show all Users in an OU
$OU = 'ou=IT,ou=USERS,dc=DOMAIN,dc=local'
Get-ADUser -SearchBase $OU -Filter *

# Search for a User and show OU membership
Get-ADUser -Filter { mail -like "*user@domain.com*" } -Properties * | Select-Object -Property name, samaccountname, mail, profilepath, enabled, @{n='OU';e={$_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)'}} | Format-Table -AutoSize
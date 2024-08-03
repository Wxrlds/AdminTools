# Remove/Clear an attribute (profilepath) of all Users (*) or filter it
Get-ADUser -Filter { profilepath -like "*" } -Properties * | Set-ADUser -Clear profilepath -WhatIf
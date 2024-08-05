# Login to Exchange online
Connect-ExchangeOnline
Connect-IPPSSession

# Mails older than date cutof
$date = Get-Date "2020-01-01"
$user = 'user@domain.com'
$jobName = "$($user)_$(Get-Date $date -Format 'yyyy-MM-dd')_delete"
New-ComplianceSearch -Name $jobName -ExchangeLocation $user -ContentMatchQuery "received<$(Get-Date $date -Format 'yyyy-MM-dd')"

# Mails sent by user younger than
$user = 'user@domain.com'
$cutofDate = Get-Date "2020-01-01"
$jobName = "$($user)_$(Get-Date $cutofDate -Format 'yyyy-MM-dd')_sent_by"
New-ComplianceSearch -Name $jobName -ExchangeLocation $user -ContentMatchQuery "sender:$($user) AND sent>$(Get-Date $cutofDate -Format 'yyyy-MM-dd')"

# Start search
Start-ComplianceSearch -Identity $jobName

# Show all searches
Get-ComplianceSearch

# Remove search
Get-ComplianceSearch -Identity $jobName | Remove-ComplianceSearch


# What to do with search results
# List everything you can do
Get-ComplianceSearchAction

# Delete found mails
New-ComplianceSearchAction -SearchName $jobName -Purge -PurgeType SoftDelete -WhatIf

# Generate reports
New-ComplianceSearchAction -SearchName $jobName -Report
# Download (only through web browser and MS Edge!)
https://compliance.microsoft.com/contentsearchv2?viewid=search


# Space usage of database
Get-MailboxDatabase -Status | fl name, *space*

# Empty database for softdeleted users
Get-MailboxStatistics -Database "DataBaseName" | where { $_.DisconnectReason -eq "SoftDeleted" } | ForEach { Remove-StoreMailbox -Database $_.Database -Identity $_.MailboxGuid -MailboxState SoftDeleted }
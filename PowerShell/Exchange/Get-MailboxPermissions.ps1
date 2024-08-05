# https://www.o365info.com/room-mailbox-powershell-commands/#SUB-3
# https://web.archive.org/web/20160927083523/http://mntechblog.de/exchange-2013-verteilergruppe-erstellen/

$user = 'user1@domain.com'
# Who has "Full Access" permission for $user
Get-MailboxPermission $user

# Who has "Send As" permission to $user
Get-RecipientPermission $user

# Which mailboxes the $user has "Full Access" permissions to
$result = Get-ExoMailbox -RecipientTypeDetails UserMailbox, SharedMailbox -ResultSize unlimited | ForEach-Object {
    Get-MailboxPermission -User $user -Identity $_.primarysmtpaddress
}
$result | Format-Table -Autosize

# Which mailboxes the $user has "Send As" permissions to
$result = Get-ExoMailbox -RecipientTypeDetails UserMailbox, SharedMailbox -ResultSize unlimited | ForEach-Object {
    Get-RecipientPermission -trustee $user -Identity $_.primarysmtpaddress
}
$result | Format-Table -Autosize

# Grant user full access to all mailboxes
Get-Mailbox -ResultSize unlimited | Add-MailboxPermission -User domain\mailAdmin -AccessRights fullaccess -InheritanceType all -AutoMapping:$false
# Filter which user to give permission to (this case only user mailboxes and no admin mailboxes)
Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox') -and (Alias -ne 'Admin')} | Add-MailboxPermission -User domain\mailAdmin -AccessRights fullaccess 

# Revoke full access permissions
Get-Mailbox -ResultSize unlimited | Remove-MailboxPermission -User domain\mailAdmin -AccessRights fullaccess

# Mailboxes sorted by size
Get-MailboxStatistics -Server mailserver.local | Sort-Object TotalItemSize -Descending | Select-Object DisplayName,@{label="TotalItemSize(MB)";expression={$_.TotalItemSize.Value.ToMB()}},ItemCount | Export-Csv c:\export\mbx_size.csv


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
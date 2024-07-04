# Show all mailboxes with errors
```powershell
Get-MsolUser -HasErrorsOnly | Sort-Object UserPrincipalName
```

## Show the errors
```powershell
$user = "user@domain.com"
Get-MsolUser -HasErrorsOnly | Sort-Object UserPrincipalName | Format-List DisplayName,UserPrincipalName,@{Name="Error";Expression={($_.errors[0].ErrorDetail.objecterrors.errorrecord.ErrorDescription)}}
Get-MsolUser -UserPrincipalName $user | Format-List DisplayName,UserPrincipalName,@{Name="Error";Expression={($_.errors[0].ErrorDetail.objecterrors.errorrecord.ErrorDescription)}}
```

# Search Mailbox with specific GUID
```powershell
Get-Recipient -IncludeSoftDeletedRecipients "987" | Select-Object displayname,primarysmtpaddress
```

# Get GUID of a Mailbox
```powershell
get-remotemailbox $user | Select-Object name,*guid*
get-mailbox $user | Select-Object name,*guid*
```

# Errors
## Failed to enable the new cloud archive 123 of mailbox 456 because a different archive 789 exists.
```powershell
[guid]$guid = "789"
Set-RemoteMailbox -Identity $user -ArchiveGuid $guid.ToString()
```

## The value 123 of property "ArchiveGuid" is used by another recipient object
### Check if the User has 2 or more Mailboxes
```powershell
Get-Recipient -Identity $user -IncludeSoftDeletedRecipients | select-object name, whensoftdeleted
```
### Find the SoftDeleted user and remove it
```powershell
Get-Mailbox $user -SoftDeletedMailbox
Get-Mailbox $user -SoftDeletedMailbox | Remove-Mailbox
```

http://ajaxtechinc.com/question/value-guid-value-property-archiveguid-used-another-recipient-object-please-specify-unique-value/
https://learn.microsoft.com/en-us/exchange/troubleshoot/administration/validation-errors-for-mailbox-archive-guid
https://www.hayesjupe.com/issues-with-mailbox-migration-multiple-identities-where-tenant-wide-retention-policies-in-use/
https://o365info.com/force-delete-mailbox/
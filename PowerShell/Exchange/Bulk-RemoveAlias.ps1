$Mailboxes = Get-Mailbox -ResultSize Unlimited

foreach ($Mailbox in $Mailboxes) {
    $Mailbox.EmailAddresses | Where-Object { $_.AddressString -like "*@oldUnused.domain.com" } | ForEach-Object {
            # Better whatif than sorry
            Set-Mailbox $Mailbox -EmailAddresses @{remove = $_ } -Whatif

            Write-Host "Removing $_ from $Mailbox Mailbox" -ForegroundColor Green
    }
}
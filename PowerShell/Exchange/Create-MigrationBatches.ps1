# Single migration batch per user
$mailboxes = @(
    "user1@domain.com",
    "user2@domain.com"
)
foreach ($mailbox in $mailboxes) {
    $CSVData = @"
EmailAddress
$mailbox
"@
    New-MigrationBatch -Name $mailbox -SourceEndpoint (Get-MigrationEndpoint).identity -TargetDeliveryDomain "tenant.mail.onmicrosoft.com" -CSVData ([System.Text.Encoding]::UTF8.GetBytes($CSVData)) -AutoStart -NotificationEmails "yourMail@domain.com"
}

# Show all migration batches
Get-MigrationBatch

# Show details for a single migration batch
Get-MigrationUser -ResultSize Unlimited -BatchId "user1@domain.com"
## Also show error details
Get-MigrationUser -ResultSize Unlimited -BatchId "user1@domain.com" | Sort-Object ErrorSummary, identity | Select-Object Identity, ErrorSummary

# Keep restarting failing migration batches every 10 mins
$startTime = Get-Date
$migrationStatus = "SyncedWithErrors"
do {
    $migrationStatus = (Get-MigrationBatch -Identity "user1@domain.com" | select-Object status).status.value
    if ($migrationStatus -eq "SyncedWithErrors" -or $migrationStatus -eq "Failed") {
        Write-Output "Sync failed, starting again"
        Get-MigrationBatch -Identity "user1@domain.com" | Start-MigrationBatch
    } elseif ($migrationStatus -eq "Syncing") {
        Write-Output "Still Syncing"
    }
    Write-Output "Sleeping 10 Mins ($(Get-date -format "yyyy-MM-dd HH:mm:ss"))"
    Start-Sleep -Seconds 600
} while (
    $migrationStatus -eq "Syncing" -or $migrationStatus -eq "SyncedWithErrors"
)
$endTime = Get-Date
$duration = $endTime - $startTime
Write-Output "Finished on $(Get-date $endTime -format "yyyy-MM-dd HH:mm:ss"). Took: $($duration)"
$duration
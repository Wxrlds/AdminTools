Import-Module PSFzf

function find {
    param(
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)][string[]]$files
    )
    foreach ($file in $files) {
        $file = "*$file*"
        Get-ChildItem -Force -Recurse $file -ErrorAction SilentlyContinue | Select-Object name, @{n = 'Folder'; e = { $_.PSParentPath -replace 'Microsoft.PowerShell.Core\\FileSystem::','' } }, @{n = 'Size KB'; e = { $_.length / 1kb } }
    }
}

function grep {
    param(
        [Parameter(Mandatory = $true)][string]$text
    )
    findstr -i $text.ToString()
}

function md5Sum {
    param(
        [Parameter(ValueFromRemainingArguments = $true)][string[]]$files
    )
    foreach ($file in $files) {
        Get-FileHash -Algorithm MD5 $file.ToString() | Select-Object path, hash
    }
}

function sha256Sum {
    param(
        [Parameter(ValueFromRemainingArguments = $true)][string[]]$files
    )
    foreach ($file in $files) {
        Get-FileHash -Algorithm SHA256 $file.ToString() | Select-Object path, hash
    }
}

function Replicate-AllDomainController {
    (Get-ADDomainController -Filter *).Name | Foreach-Object {
        Write-Output "Syncing $_"
        repadmin /syncall $_ (Get-ADDomain).DistinguishedName /e /A | Out-Null
    }
    Write-Output "Waiting for sync to finish"
    Start-Sleep 10
    Get-ADReplicationPartnerMetadata -Target "$env:userdnsdomain" -Scope Domain | Select-Object Server, LastReplicationSuccess
}

function Search-All {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)][string[]]$properties,
        [Parameter(Mandatory = $false)][switch]$type,
        [Parameter(Mandatory = $false)][switch]$ou,
        [Parameter(Mandatory = $false)][switch]$cn
    )
    $searchname = "*$name*"
    $propertyList = @()
    if ($properties) {
        $propertyList += $properties
    }
    if ($type) {
        $propertyList += "objectclass"
    }
    if ($ou) {
        $propertyList += @{n = 'OU'; e = { $_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)' } }
    }
    if ($cn) {
        $propertyList += @{n = 'CN'; e = { $_.canonicalname -replace '(.*/).*', '$1' } }
    }
    Get-ADObject -Filter { name -like $searchname -or samaccountname -like $searchname -or DNSHostName -like $searchname -or mail -like $searchname } -Properties * | Select-Object -Property $propertyList
}

function Search-Computer {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)][string[]]$properties,
        [Parameter(Mandatory = $false)][switch]$ou,
        [Parameter(Mandatory = $false)][switch]$cn
    )
    $computer = "*$name*"
    $propertyList = @()
    if ($properties) {
        $propertyList += $properties
    }
    if ($ou) {
        $propertyList += @{n = 'OU'; e = { $_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)' } }
    }
    if ($cn) {
        $propertyList += @{n = 'CN'; e = { $_.canonicalname -replace '(.*/).*', '$1' } }
    }
    Get-ADComputer -Filter { name -like $computer -or samaccountname -like $computer -or DNSHostName -like $computer } -Properties * | Select-Object -Property $propertyList
}

function Search-GPO {
    param (
        [Parameter(Mandatory = $true)][string]$searchSetting,
        [Parameter(Mandatory = $false)][string]$DomainName
    )
    # Get the string we want to search for
    $string = $searchSetting
    # Set the domain to search for GPOs
    if (!$DomainName) {
        $DomainName = $env:USERDNSDOMAIN
    }
    # Find all GPOs in the current domain
    write-host "Finding all the GPOs in $DomainName"
    Import-Module grouppolicy
    $allGposInDomain = Get-GPO -All -Domain $DomainName
    [string[]] $MatchedGPOList = @()

    # Look through each GPO's XML for the string
    Write-Host "Starting search...."
    foreach ($gpo in $allGposInDomain) {
        $report = Get-GPOReport -Guid $gpo.Id -ReportType Xml
        if ($report -match $string) {
            write-host "********** Match found in: $($gpo.DisplayName) **********" -foregroundcolor "Green"
            $MatchedGPOList += "$($gpo.DisplayName)";
        }
        else {
            Write-Host "No match in: $($gpo.DisplayName)"
        }
    }
    write-host "`r`n"
    write-host "Results: **************" -foregroundcolor "Yellow"
    foreach ($match in $MatchedGPOList) {
        write-host "Match found in: $($match)" -foregroundcolor "Green"
    }
}

function Search-Group {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)][string[]]$properties,
        [Parameter(Mandatory = $false)][switch]$ou,
        [Parameter(Mandatory = $false)][switch]$cn
    )
    $group = "*$name*"
    $propertyList = @()
    if ($properties) {
        $propertyList += $properties
    }
    if ($ou) {
        $propertyList += @{n = 'OU'; e = { $_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)' } }
    }
    if ($cn) {
        $propertyList += @{n = 'CN'; e = { $_.canonicalname -replace '(.*/).*', '$1' } }
    }
    Get-ADObject -Filter { objectclass -like "group" -and name -like $group -or samaccountname -like $group } -Properties * | Select-Object -Property $propertyList
}

function Search-User {
    param(
        [Parameter(Mandatory = $true)][string]$name,
        [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)][string[]]$properties,
        [Parameter(Mandatory = $false)][switch]$ou,
        [Parameter(Mandatory = $false)][switch]$cn
    )
    $username = "*$name*"
    $propertyList = @()
    if ($properties) {
        $propertyList += $properties
    }
    if ($ou) {
        $propertyList += @{n = 'OU'; e = { $_.DistinguishedName -replace '^.*?,(?=[A-Z]{2}=)' } }
    }
    if ($cn) {
        $propertyList += @{n = 'CN'; e = { $_.canonicalname -replace '(.*/).*', '$1' } }
    }
    Get-ADUser -Filter { name -like $username -or samaccountname -like $username -or mail -like $username } -Properties * | Select-Object -Property $propertyList
}
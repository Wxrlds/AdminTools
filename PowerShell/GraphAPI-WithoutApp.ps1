function Install-GraphAPI {
    $requiredModules = @(
        'Microsoft.Graph.Users',
        'Microsoft.Graph.Groups',
        'Microsoft.Graph.Identity.DirectoryManagement'
    )
    foreach ($requiredModule in $requiredModules) {
        if (-not (Get-Module -ListAvailable -Name $requiredModule)) {
            Install-Module -Name $requiredModule -Scope CurrentUser -Repository PSGallery -Force
        }
    }
}

function Test-GraphAPIScopes {
    param (
        [Parameter(Mandatory = $true)][array]$requiredScopes
    )
    $currentScopes = Get-MgContext | Select-Object -Property Scopes -ExpandProperty Scopes
    $missingScopes = $requiredScopes | Where-Object { -not ($currentScopes -contains $_) }
    
    if ($missingScopes.Count -eq 0) {
        return $true
    }
    Write-Host "Missing scopes:`n* $($missingScopes -join "`n* ")`nConnecting to GraphAPI" -ForegroundColor Yellow
    return $false
}

function Connect-ToGraphAPI {
    param (
        [Parameter(Mandatory = $true)][array]$requiredScopes
    )
    if ((Test-GraphAPIScopes -requiredScopes $requiredScopes) -eq $true) {
        Write-Host 'Already connected to GraphAPI' -ForegroundColor Green
        return
    }
    else {
        Connect-MgGraph -Scopes $requiredScopes
    }

    if (Test-GraphAPIScopes -requiredScopes $requiredScopes) {
        
    }
    else {
        Write-Host 'Failed to connect to GraphAPI. Aborting' -ForegroundColor Red
        Disconnect-MgGraph
        Exit 0
    }    
}

Install-GraphAPI

$requiredScopes = @(
    'Group.ReadWrite.All',
    'User.Read.All'
)
    
Connect-ToGraphAPI -requiredScopes $requiredScopes

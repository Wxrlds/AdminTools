function Restart-FileExplorerWithReopen {
    # Save open folder paths
    $folderPaths = @()
    $shell = New-Object -ComObject shell.application
    $shell.Windows() | ForEach-Object {
        $folderPaths += $_.Document.Folder.Self.Path
    }

    # Restart Windows Explorer and checks if it started again
    # If it has not started after Stop-Process, attempt to start manually
    Stop-Process -Name explorer -Force
    if (-not (Get-Process -Name explorer)) {
        Start-Process explorer 
    }

    # Reopen saved folders
    $folderPaths | ForEach-Object {
        $path = $_
        if ($path.StartsWith('::')) {
            Start-Process -WindowStyle Normal "shell:$path"
        }
        else {
            Start-Process -WindowStyle Normal -FilePath $path
        }
    }
}
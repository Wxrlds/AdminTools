$folderToCopy = "C:\Folder\CopyThisFolder"
# This copies the above folder into every folder inside the downloads folder
$randomString = Get-ChildItem "$env:userprofile\Downloads\*" -Directory -Hidden

foreach ($string in $randomString) {
    $destination = "$env:userprofile\Downloads\$($string.name)"
    Copy-Item $folderToCopy $destination -Verbose -Recurse
}
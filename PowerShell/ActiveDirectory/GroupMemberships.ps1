# Copies every element inside SourceGroup into DestinationGroup
Get-ADGroupMember "SourceGroup" | ForEach-Object { Add-ADGroupMember -Identity "DestinationGroup" -Member $_.SamAccountName }

# Copy all group memberships from SourceUser to TargetUser
Get-ADUser -Identity SourceUser -Properties memberOf | select memberOf -ExpandProperty memberOf | Add-ADGroupMember -Members TargetUser -PassThru

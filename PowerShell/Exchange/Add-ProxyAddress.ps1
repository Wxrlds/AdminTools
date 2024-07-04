# Add Microsoft Proxy Address to all users in an OU
$users = get-aduser -filter * -searchbase "OU=Users,DC=domain,DC=local"
foreach ($user in $users)
{
    set-aduser -identity $user.samaccountname -add @{ProxyAddresses="smtp:" + $user.samaccountname + "@domain.mail.onmicrosoft.com"}
}

# Add Microsoft Proxy Address to specific users
$mailboxes = @(
    "user1@domain.com",
    "user2@domain.com"
)
$users = $mailboxes | ForEach-Object { Get-ADUser -Filter { mail -eq $_} }
foreach ($user in $users)
{
    set-aduser -identity $user.samaccountname -add @{ProxyAddresses="smtp:" + $user.samaccountname + "@domain.mail.onmicrosoft.com"}
}
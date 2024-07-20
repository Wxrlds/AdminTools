# Check LDAP connection
# -b can be a user or group you search
# -D is the user you use to access the ldap server
ldapsearch -H ldap://domain.local -b "DC=domain,DC=local" -D "CN=user,OU=users,DC=domain,DC=local" -W -s base
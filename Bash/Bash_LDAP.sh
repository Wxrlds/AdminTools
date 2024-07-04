# Check LDAP connection
ldapsearch -x -H ldap://domaindc.local -b "DC=domain,DC=local" -D "CN=user,OU=users,DC=domain,DC=local" -W -s base
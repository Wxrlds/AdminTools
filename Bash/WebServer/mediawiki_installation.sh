# Install dependencies
sudo apt-get install php php-apcu php-intl php-mbstring php-xml php-mysql php-calendar mariadb-server apache2 imagemagick git ghostscript xpdf-utils php-curl

# Download newest mediawiki
wget https://releases.wikimedia.org/mediawiki/1.42/mediawiki-1.42.1.tar.gz

# Untar
tar -xf mediawiki-*.tar.gz

# Copy to webserver
mkdir -p /var/www/html/mediawiki
sudo cp -rT mediawiki-1.42.1 /var/www/html/mediawiki

# Navigate to server URL in Browser
#Your language de-de, Wiki lang de-de

# Database config using ssh
sudo mysql -u root -p
CREATE DATABASE wikimedia;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'mediawiki_user_password';
GRANT ALL PRIVILEGES ON wikimedia.* TO 'user'@'localhost' WITH GRANT OPTION;

# Through web browser, add login data to database config
# Wiki Name: wikimedia
# Set Admin Account, Email, private wiki
# Select all extensions, add a logo

# Adjust max upload limit in php
sudo vi /etc/php/7.4/apache2/php.ini
# upload_max_filesize = 2048M
# post_max_size = 2048M
# memory_limit = 2048M

# Adjust upload limit in mediawiki settings
sudo vi /var/www/html/mediawiki/LocalSettings.php
# $wgUploadSizeWarning = 2147483647;
# $wgMaxUploadSize = 2147483647;
# Adjust url path
$wgScriptPath = "/mediawiki";
$wgServer = "http://wikimedia.local";

# Add DNS to host file (probably optional)
sudo vi /etc/hosts
# 127.0.1.1 wikimedia

# Redirect website root to mediawiki
sudo vi /etc/apache2/sites-available/000-default.conf
# RedirectMatch ^/$ /mediawiki/index.php/Hauptseite

# Allow visual editor in private wiki
sudo vi /var/www/html/mediawiki/LocalSettings.php
# if ( isset( $_SERVER['REMOTE_ADDR'] ) &&
#     in_array( $_SERVER['REMOTE_ADDR'], [ $_SERVER['SERVER_ADDR'], '127.0.0.1' ] ) ) {
#     $wgGroupPermissions['*']['read'] = true;
#     $wgGroupPermissions['*']['edit'] = true;
# }

# General installation is done here, you just need to properly set the permissions
sudo chown -R mediawiki:mediawiki /var/www/html/mediawiki/
sudo chown -R www-data:www-data /var/www/html/mediawiki/images
sudo chown -R root:root /var/www/html/mediawiki/LocalSettings.php

# Install Popups extension to get link hover highlight
# Dependencies and extension itself
curl -O https://extdist.wmflabs.org/dist/extensions/PageImages-REL1_39-ae5bfe5.tar.gz
sudo tar -xzf PageImages-REL1_39-ae5bfe5.tar.gz -C /var/www/html/mediawiki/extensions/
curl -O https://extdist.wmflabs.org/dist/extensions/TextExtracts-REL1_39-b23f089.tar.gz
sudo tar -xzf TextExtracts-REL1_39-b23f089.tar.gz -C /var/www/html/mediawiki/extensions/
curl -O https://extdist.wmflabs.org/dist/extensions/Popups-REL1_39-dfb48b5.tar.gz
sudo tar -xzf Popups-REL1_39-dfb48b5.tar.gz -C /var/www/html/mediawiki/extensions/

# Enable extensions
sudo vi /var/www/html/mediawiki/LocalSettings.php
# wfLoadExtension( 'PageImages' );
# wfLoadExtension( 'TextExtracts' );
# wfLoadExtension( 'Popups' );
# $wgPopupsHideOptInOnPreferencesPage = true;
# $wgPopupsReferencePreviewsBetaFeature = false;

# Connect to LDAP
# Following extensions are required:
# Install as listed above
# https://www.mediawiki.org/wiki/Extension:LDAPProvider
# https://www.mediawiki.org/wiki/Extension:PluggableAuth
# https://www.mediawiki.org/wiki/Extension:LDAPAuthorization
# https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2
# https://www.mediawiki.org/wiki/Extension:LDAPGroups
# https://www.mediawiki.org/wiki/Extension:LDAPUserInfo

# Configure LDAP
# sudo vi /var/www/html/mediawiki/LocalSettings.php
# wfLoadExtension( 'LDAPProvider' );
# wfLoadExtension( 'PluggableAuth' );
# $wgGroupPermissions['*']['autocreateaccount'] = true;
# $wgGroupPermissions['*']['createaccount'] = true;
# wfLoadExtension( 'LDAPAuthorization' );
# wfLoadExtension( 'LDAPAuthentication2' );
# wfLoadExtension( 'LDAPGroups' );
# wfLoadExtension( 'LDAPUserInfo' );
# 
# # Load LDAP Config from JSON
# $ldapJsonFile = "$IP/ldap.json";
# $ldapConfig = false;
# if (is_file($ldapJsonFile) && is_dir("$IP/extensions/LDAPProvider")) {
#     $testJson = @json_decode(file_get_contents($ldapJsonFile),true);
#         if (is_array($testJson)) {
#             $ldapConfig = true;
#         } else {
#             error_log("Found invalid JSON in file: $IP/ldap.json");
#         }
# }
# $LDAPProviderDomainConfigs = $ldapJsonFile;
# $LDAPProviderDomainConfigs = $ldapJsonFile;
# 
# # Force LDAPGroups to sync by choosing a domain (e.g. first JSON object in ldap.json)
# $LDAPProviderDefaultDomain = array_key_first(json_decode(file_get_contents($LDAPProviderDomainConfigs), true));
# 
# $wgPluggableAuth_Config = array(
#     array(
#         'plugin' => 'LDAPAuthentication2',
#         'buttonLabelMessage' => 'pt-login-button',
#         'data' => ['domain'=> $LDAPProviderDefaultDomain]
#     ),
#     array('plugin' => 'LDAPAuthorization'),
# );
# $LDAPAuthentication2AllowLocalLogin = true;
# $wgPluggableAuth_EnableLocalLogin = false; # Set this to true to enable local login without LDAP. Then use upper button to login. Only use when you want to login with the local admin account. If you want to get admin permissions, use LDAP group in $IP/ldap.json
# $LDAPProvidernestedgroups = true;

# Create LDAP.json for ldap config
sudo vi /var/www/html/mediawiki/ldap.json
# {
#     "DOMAIN.local": {
#         "connection": {
#             "server": "DOMAIN.local",
#             "port": "389", # Change this and the next line to use LDAPS, instead of plain text. Requires Certificate to be installed
#             "use-tls": "false",
#             "user": "CN=LDAPSYNCUSER,OU=Users,DC=DOMAIN,DC=local",
#             "pass": "PASSWORDOFUSER",
#             "enctype": "clear",
#             "options": {
#                 "LDAP_OPT_DEREF": 1
#             },
#             "basedn": "DC=DOMAIN,DC=local",
#             "groupbasedn": "DC=DOMAIN,DC=local",
#             "userbasedn": "DC=DOMAIN,DC=local",
#             "searchattribute": "samaccountname",
#             "usernameattribute": "samaccountname",
#             "realnameattribute": "cn",
#             "emailattribute": "mail",
#             "grouprequest": "MediaWiki\\Extension\\LDAPProvider\\UserGroupsRequest\\GroupMember::factory",
#             "presearchusernamemodifiers": [
#                 "spacestounderscores",
#                 "lowercase"
#             ]
#         },
#         "userinfo": [],
#         "authorization": {
#             "rules": {
#                 "groups": {
#                     "required": [
#                         "CN=Wiki_User,OU=Groups,DC=DOMAIN,DC=local", # Define which LDAP Group to use for Wiki User
#                         "CN=Wiki_Admin,OU=Groups,DC=DOMAIN,DC=local" # Define which LDAP Group to use for Wiki Admin
#                     ]
#                 }
#             }
#         },
#         "groupsync": {
#             "mapping": {
#                 # Grants the users its permissions
#                 "user": "CN=Wiki_User,OU=Groups,DC=DOMAIN,DC=local",
#                 "sysop": "CN=Wiki_Admin,OU=Groups,DC=DOMAIN,DC=local"
#             }
#         }
#     }
# }

# Update Mediawiki
# Create backup before every update (or even better VM Snapshot)
mkdir ~/mediawiki_backup
sudo mysqldump -u root -p mediawiki > ~/mediawiki_backup/file.sql
sudo mysqldump -u root -p mediawiki --xml > ~/mediawiki_backup/file.xml
cp -r /var/www/html/mediawiki/images/ ~/mediawiki_backup/
cp -r /var/www/html/mediawiki/LocalSettings.php ~/mediawiki_backup/
cp -r /var/www/html/mediawiki/extensions/ ~/mediawiki_backup/

# Download newest release and untar
wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz
tar -xvzf mediawiki-1.41.0.tar.gz

# Copy settings file
cp -v /var/www/html/mediawiki/LocalSettings.php ~/mediawiki-1.41.0
cp -rv /var/www/html/mediawiki/images/ ~/mediawiki-1.41.0

# Disable old wiki
sudo mv /var/www/html/mediawiki/ /var/www/html/alt-mediawiki

# Enable new wiki
sudo cp -rv ~/mediawiki-1.41.0 /var/www/html/mediawiki

# Run php update script
php /var/www/html/mediawiki/maintenance/run.php /var/www/html/mediawiki/maintenance/update.php

# For extension errors, download newst version of extension and install
# Remove old extension first from the folder below
wget https://extdist.wmflabs.org/dist/extensions/Popups-REL1_41-2bdce08.tar.gz
sudo tar -xvzf Popups-REL1_41-2bdce08.tar.gz -C /var/www/html/mediawiki/extensions

# Adjust permissions again
sudo chown -R mediawiki:mediawiki /var/www/html/mediawiki/
sudo chown -R www-data:www-data /var/www/html/mediawiki/images
sudo chown -R root:root /var/www/html/mediawiki/LocalSettings.php

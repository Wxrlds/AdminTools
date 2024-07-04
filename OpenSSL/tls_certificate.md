# Create TLS Certificate
1. Create openssl.conf
```powershell
$content = @"
[ req ]
default_bits			= 4096
distinguished_name		= dn
prompt					= no
x509_extensions			= v3_ca
req_extensions			= v3_req

[ dn ]
C						= DE
ST						= State
L						= City
O						= Company
CN						= domain.com

[ v3_req ]
subjectAltName			= @alt_names

[ v3_ca ]
subjectKeyIdentifier	= hash
authorityKeyIdentifier	= keyid:always,issuer:always
basicConstraints		= CA:FALSE

[alt_names]
DNS.1 					= domain.com
DNS.2					= 10.10.10.10
"@
```

2. Create private key
```powershell
openssl genpkey -algorithm RSA -out private.key -pkeyopt rsa_keygen_bits:4096
```

3. Create CSR
```powershell
openssl req -new -key private.key -out request.csr -config openssl.conf
```

4. Sign CSR on CA-Server

5. Move certificate and key to Server
```powershell
sudo mv certnew.cer /etc/ssl/certs/
sudo mv private.key /etc/ssl/private/
```

6. Set certificate to available sites
```bash
sudo vi /etc/apache2/sites-available/default-ssl.conf
> SSLCertificateFile      /etc/ssl/certs/certnew.cer
> SSLCertificateKeyFile   /etc/ssl/private/private.key
```

7. Redirect http -> https
```bash
sudo vi /etc/apache2/sites-available/000-default.conf
> Redirect permanent / https://website.name
```

8. Set permissions
```bash
sudo chmod 644 /etc/ssl/certs/certnew.cer
sudo chown root:root /etc/ssl/certs/certnew.cer
sudo chmod 400 /etc/ssl/private/private.key
sudo chown root:root /etc/ssl/private/private.key
```

9. Enable tls in apache2
```bash
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
sudo systemctl restart apache2
```
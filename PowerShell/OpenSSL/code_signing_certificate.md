# Create Key
1. Create openssl.conf
```powershell
$content = @"
[ req ]
default_bits		= 4096
prompt				= no
default_md			= sha256
distinguished_name	= dn

[ dn ]
C					= DE
ST					= State
L					= City
O					= Company
OU					= 
emailAddress		= mail@domain.com

[ v3_req ]
basicConstraints	= CA:FALSE
keyUsage			= digitalSignature, nonRepudiation
extendedKeyUsage	= codeSigning
"@
Add-Content -Path openssl.conf $content
```

2. Create private key
```powershell
openssl req -new -key private.key -out request.csr -config openssl.conf
```

3. Create Certificate Signing Request (CSR)
```powershell
openssl req -new -key private.key -out request.csr -config openssl.conf
```

4. Sign CSR on CA-Server

5. Create PFX (Combine Signed Certificate with Key)
```powershell
openssl pkcs12 -export -out certificate.pfx -inkey private.key -in certnew.cer
```

# Trust Certificate
1. Extract Public Key from Certificate
```powershell
openssl pkcs12 -in .\certificate.pfx -clcerts -nokeys -out public.pem
```

2. Install Certificate
```powershell
Import-Certificate -FilePath public.pem -CertStoreLocation Cert:\\CurrentUser\\TrustedPublisher
```

# Sign Script
```powershell
$cert = Get-PfxCertificate -FilePath certificate.pfx
Set-AuthenticodeSignature -FilePath script.ps1 -Certificate $cert -TimestampServer "http://timestamp.digicert.com"
```
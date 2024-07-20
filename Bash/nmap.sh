# Find enabled TLS versions on host
nmap --script ssl-enum-ciphers -p 443 domain.com

# OS detection & open ports
nmap -O -v 10.10.10.10

# OS detection & specific port (443)
nmap -O -v 10.10.10.10 -p 443
# Generate Public/Private Key
```powershell
ssh-keygen -t ed25519 -a 400 -f $home\.ssh\ServerHostname.ed25519 -C "YourUsermane YourDeviceName ServerHostname"
```

# Copy key to server
```powershell
type $home\.ssh\ServerHostname.ed25519.pub | ssh vpf "mkdir ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

# Remove key from local key store
```powershell
ssh-add -D ServerHostname.ed25519
```
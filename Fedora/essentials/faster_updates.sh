############################################
## https://github.com/Wxrlds/OSSetupTools ##
############################################

# Accelerate Updates
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf
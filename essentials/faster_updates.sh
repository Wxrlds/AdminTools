##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

clear
echo "Proceeding to append 'fastestmirror=True' and 'keepcache=True' to '/etc/dnf/dnf.conf'. Press any key to continue."
read -rsn1
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf
echo "Successfully appended to dnf.conf. Press any key to continue."
read -rsn1
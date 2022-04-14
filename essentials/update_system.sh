##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

clear
echo "Proceeding to update the system. Press any key to continue."
read -rsn1
echo "Updating the system."
sudo dnf upgrade
echo "Successfully updated the system. Press any key to continue."
read -rsn1
##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

clear
echo "Proceeding to install Gnome Extensions. Press any key to continue."
read -rsn1
sudo dnf install gnome-extensions-app
echo "Installed Gnome Extensions. Press any key to continue."
read -rsn1
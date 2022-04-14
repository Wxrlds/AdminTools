##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

# Source: https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/
clear
echo "Proceeding to install RPM Fusion Free. Press any key to continue."
read -rsn1
echo "Installing RPM Fusion Free."
sudo dnf install \  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
echo "Installed RPM Fusion Free. Press any key to continue."
read -rsn1

clear
echo "Proceeding to install RPM Fusion NonFree. Press any key to continue."
read -rsn1
echo "Installing RPM Fusion NonFree"
sudo dnf install \  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo "Installed RPM Fusion NonFree. Press any key to continue."
read -rsn1
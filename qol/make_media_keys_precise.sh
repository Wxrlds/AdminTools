##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

echo "Proceeding to make media keys more precise. Default is 6. Press any key to continue."
read -rsn1
sudo dnf install dconf
dconf write /org/gnome/settings-daemon/plugins/media-keys/volume-step 2
echo "Media keys are now more precise. Press any key to continue."
read -rsn1
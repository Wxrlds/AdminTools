##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

# Source: https://docs.fedoraproject.org/en-US/quick-docs/assembly_installing-plugins-for-playing-movies-and-music/
clear
echo "Proceeding to install multimedia codecs. Press any key to continue."
read -rsn1
echo "Installing multimedia codecs"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
echo "Installed multimedia Codecs. Press any key to continue."
read -rsn1
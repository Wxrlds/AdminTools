##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

clear
echo "Proceeding to set background image for GDM user. If GDM background goes grey execute this script again."
echo "Press any key to continue."
read -rsn1
echo "Installing GDM-Tools"
sudo dnf install glib2-devel
sudo dnf install dconf
sudo dnf install git
git clone --depth=1 https://github.com/realmazharhussain/gdm-tools.git ~/Downloads/gdm-tools
sh ~/Downloads/gdm-tools/install.sh
echo "Making backup of gdm user"
set-gdm-theme backup update
ech "Downloading background image"
sudo curl https://fedoraproject.org/w/uploads/3/35/F34_default_wallpaper_day.jpg -o /var/lib/gdm/.config/F34_default_wallpaper_day.jpg
set-gdm-theme set -b /var/lib/gdm/.config/F34_default_wallpaper_day.jpg
rm -r ~/Downloads/gdm-tools -f
echo "Successfully set wallpaper of GDM User as default Fedora 34 background. Press any key to continue."
read -rsn1
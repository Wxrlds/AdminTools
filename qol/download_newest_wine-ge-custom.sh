##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
################################################################
## https://github.com/GloriousEggroll/wine-ge-custom/releases ##
################################################################
echo "Proceeding to download newest Wine-GE-Custom by GloriousEggroll and moving it to the Lutris directory. Press any key to continue."
read -rsn1
echo "Getting Wine-GE-Custom download URL"
winegecustomurl=`curl -s https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest | grep "browser_download_url.*tar.xz" | cut -d : -f 2,3 | tr -d \" `
echo "Downloading Wine-GE-Custom"
wget $winegecustomurl -c -P ~/Downloads --show-progress
echo "Extracting Wine-GE-Custom"
tar -xvf ~/Downloads/wine-lutris-GE*.tar.xz --directory ~/.local/share/lutris/runners/wine/
rm ~/Downloads/wine-lutris-GE*.tar.xz
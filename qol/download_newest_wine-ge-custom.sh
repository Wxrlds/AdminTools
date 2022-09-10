############################################
## https://github.com/Wxrlds/OSSetupTools ##
################################################################
## https://github.com/GloriousEggroll/wine-ge-custom/releases ##
################################################################
# Download Wine-GE-Custom by GloriousEggroll and move it to Lutris directory
echo "Getting Wine-GE-Custom download URL"
winegecustomurl=`curl -s https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest | grep "browser_download_url.*tar.xz" | cut -d : -f 2,3 | tr -d \" `
echo "Downloading Wine-GE-Custom"
wget $winegecustomurl -c -P ~/Downloads --show-progress
echo "Extracting Wine-GE-Custom"
tar -xvf ~/Downloads/wine-lutris-GE*.tar.xz --directory ~/.local/share/lutris/runners/wine/
rm ~/Downloads/wine-lutris-GE*.tar.xz
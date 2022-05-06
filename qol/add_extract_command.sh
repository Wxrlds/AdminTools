##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
###########################################################################################################
## Based on:                                                                                             ##
## https://raw.githubusercontent.com/xvoland/Extract/a501062ea37e53d23eff1c911dfc1c446bd381a1/extract.sh ##
###########################################################################################################

clear
echo "Proceeding to add 'extract' command to easier extract a lot of archive types. Press any key to continue."
read -rsn1
sudo tee /etc/profile.d/extract.sh
sudo wget https://raw.githubusercontent.com/xvoland/Extract/a501062ea37e53d23eff1c911dfc1c446bd381a1/extract.sh -O /etc/profile.d/extract.sh
sudo chmod +x /etc/profile.d/extract.sh
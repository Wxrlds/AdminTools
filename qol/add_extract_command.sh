############################################
## https://github.com/Wxrlds/OSSetupTools ##
###########################################################################################################
## Based on:                                                                                             ##
## https://raw.githubusercontent.com/xvoland/Extract/a501062ea37e53d23eff1c911dfc1c446bd381a1/extract.sh ##
###########################################################################################################

# Extract command
sudo tee /etc/profile.d/extract.sh
sudo wget https://raw.githubusercontent.com/xvoland/Extract/a501062ea37e53d23eff1c911dfc1c446bd381a1/extract.sh -O /etc/profile.d/extract.sh
sudo chmod +x /etc/profile.d/extract.sh
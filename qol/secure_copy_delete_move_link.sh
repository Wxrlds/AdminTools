##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

clear
echo "Proceeding to make copy, move, delete, link only overwrite on confirm. Press any key to continue."
echo "# confirm before overwriting a file" | sudo tee -a /etc/bashrc
echo "alias cp='cp -i'" | sudo tee -a /etc/bashrc
echo "alias mv='mv -i'" | sudo tee -a /etc/bashrc
echo "alias rm='rm -i'" | sudo tee -a /etc/bashrc
echo "alias ln='ln -i'" | sudo tee -a /etc/bashrc
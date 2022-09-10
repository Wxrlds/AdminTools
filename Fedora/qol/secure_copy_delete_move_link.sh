############################################
## https://github.com/Wxrlds/OSSetupTools ##
############################################

# Secure copy, delete, move and links
echo "# Confirm before overwriting a file" | sudo tee -a /etc/bashrc
echo "alias cp='cp -i'" | sudo tee -a /etc/bashrc
echo "alias mv='mv -i'" | sudo tee -a /etc/bashrc
echo "alias rm='rm -i'" | sudo tee -a /etc/bashrc
echo "alias ln='ln -i'" | sudo tee -a /etc/bashrc
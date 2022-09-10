############################################
## https://github.com/Wxrlds/OSSetupTools ##
############################################

echo "# DoneForToday command" | sudo tee -a /etc/bashrc
echo "alias dft='sudo dnf upgrade && flatpak upgrade && shutdown 0'" | sudo tee -a /etc/bashrc
echo "alias dfty='sudo dnf upgrade -y && flatpak upgrade -y && shutdown 0'" | sudo tee -a /etc/bashrc
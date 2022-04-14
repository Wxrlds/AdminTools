##################################################
## https://github.com/Wxrlds/FedoraSetupScripts ##
##################################################

echo "Please install the Gnome Shell integration addon. Press any key to continue."
read -rsn1
xdg-open https://addons.mozilla.org/en-GB/firefox/addon/gnome-shell-integration/
echo "Confirm you have installed the Gnome Shell integration addon. Press any key to continue."
read -rsn1
echo "Please install (and configure) following extensions. Press any key to continue."
read -rsn1
xdg-open https://extensions.gnome.org/extension/3499/application-volume-mixer/
xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
xdg-open https://extensions.gnome.org/extension/4839/clipboard-history/
xdg-open https://extensions.gnome.org/extension/2087/desktop-icons-ng-ding/
xdg-open https://extensions.gnome.org/extension/28/gtile/
xdg-open https://extensions.gnome.org/extension/545/hide-top-bar/
xdg-open https://extensions.gnome.org/extension/277/impatience/
xdg-open https://extensions.gnome.org/extension/1007/window-is-ready-notification-remover/
echo "Press any key to confirm the Gnome addons are installed and configured."
read -rsn1
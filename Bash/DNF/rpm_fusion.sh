# https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/
# RPM Fusion Free
sudo dnf install \  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# RPM Fusion NonFree
sudo dnf install \  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
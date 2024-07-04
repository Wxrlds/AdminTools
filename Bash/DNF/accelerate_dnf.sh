# Accelerate Updates
echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
echo "keepcache=True" | sudo tee -a /etc/dnf/dnf.conf
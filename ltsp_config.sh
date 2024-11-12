#!/bin/bash

# Run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Update and install required packages
echo "Installing LTSP and dependencies..."
apt update
apt install --install-recommends -y ltsp ipxe dnsmasq nfs-kernel-server openssh-server squashfs-tools ethtool net-tools epoptes

# Give permission to the user who invoked the script
ADMIN_USER=$(logname)  
gpasswd -a $ADMIN_USER epoptes

echo "Allowing to execute on dnsmasq and ltsp scripts"
chmod +x dnsmasq_config.sh ltsp_config.sh

# Run dnsmasq configuration script
echo "Configuring dnsmasq..."
./dnsmasq_config.sh

# Run LTSP configuration script
echo "Configuring LTSP..."
./ltsp_config.sh

# Configure firewall (allow NFS and TFTP)
echo "Configuring firewall..."
ufw allow 67/udp # DHCP
ufw allow 69/udp # TFTP
ufw allow 2049   # NFS
ufw reload

echo "LTSP setup completed."

#!/bin/bash

# Backup existing dnsmasq configuration and create a new one for LTSP
echo "Backing up and configuring dnsmasq for LTSP..."
mv /etc/ltsp/ltsp-dnsmasq.conf /etc/ltsp/ltsp-dnsmasq.conf.dpkg-old

interface=$(ip -o -4 addr show up | awk '{print $2}' | grep -v lo | head -n 1)

if [ -z "$interface" ]; then
    echo "No active network interface found."
    exit 1
fi

# Add the IP address to the detected interface
sudo ip addr add 192.168.20.1/24 dev "$interface"

echo "IP address 192.168.20.1/24 added to interface $interface"

cat <<EOL > /etc/ltsp/ltsp-dnsmasq.conf
# Disable DNS service
port=0

# Enable TFTP and set the root directory
enable-tftp
tftp-root=/srv/tftp

log-dhcp

# DHCP range (adjust as necessary)
dhcp-range=192.168.20.2,192.168.20.254,12h

# Define options for PXE and specify the network path for the LTSP boot files
dhcp-match=set:ipxe-http,175,19
dhcp-match=set:ipxe-menu,175,39
dhcp-match=set:ipxe-pxe,175,33
dhcp-match=set:ipxe-bzimage,175,24
dhcp-match=set:ipxe-efi,175,36
tag-if=set:ipxe,tag:ipxe-http,tag:ipxe-menu,tag:ipxe-pxe,tag:ipxe-bzimage
tag-if=set:ipxe,tag:ipxe-http,tag:ipxe-menu,tag:ipxe-efi

# Specify bootfile
dhcp-boot=ltsp/ltsp.ipxe
EOL

# Restart dnsmasq to apply changes
echo "Restarting dnsmasq..."
systemctl restart dnsmasq

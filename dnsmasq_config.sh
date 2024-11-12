#!/bin/bash

# Backup existing dnsmasq configuration and create a new one for LTSP
echo "Backing up and configuring dnsmasq for LTSP..."
mv /etc/ltsp/ltsp-dnsmasq.conf /etc/ltsp/ltsp-dnsmasq.conf.dpkg-old

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

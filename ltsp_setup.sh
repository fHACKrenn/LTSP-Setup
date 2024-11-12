#!/bin/bash

# Initialize LTSP image for chrootless setup
echo "Creating LTSP image..."
ltsp image /

# Set up iPXE configuration
echo "Configuring iPXE..."
ltsp ipxe

# Configure NFS for LTSP
echo "Setting up NFS for LTSP..."
ltsp nfs

# Generate the ltsp.img for initial client setup
echo "Generating ltsp.img..."
ltsp initrd

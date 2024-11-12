# LTSP Setup Script

This script automates the setup of an LTSP (Linux Terminal Server Project) environment. It installs and configures necessary components like `dnsmasq`, `ltsp`, and PXE boot configurations, making it easy to deploy Ubuntu via PXE to diskless clients.

## Prerequisites

Before running the script, ensure that you have:
- A Linux server (Ubuntu is recommended).
- Sudo privileges to install and configure packages.
- The script `ltsp-setup.sh` available on your machine (clone the repository).

## Make the Script Executable

To run the script, you first need to ensure that it has executable permissions. Run the following command to allow execution:

```bash
chmod +x ltsp-setup.sh
```
Then run
```bash
./ltsp-setup.sh
```

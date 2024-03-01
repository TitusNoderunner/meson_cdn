#!/bin/bash

# Update package list and upgrade
sudo apt update && sudo apt upgrade -y

# Install UFW
sudo apt-get install ufw -y

# Allow incoming traffic on ports 22 (SSH) and 443 (HTTPS)
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp

# Enable UFW
sudo ufw enable

# Download and install Meson CDN
wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.20/meson_cdn-linux-amd64.tar.gz' && tar -zxf meson_cdn-linux-amd64.tar.gz && rm -f meson_cdn-linux-amd64.tar.gz && cd ./meson_cdn-linux-amd64 && sudo ./service install meson_cdn

# Prompt user for token address
read -p "Enter your Meson CDN token address: " token_address

# Configure Meson CDN
sudo ./meson_cdn config set --token="$token_address" --https_port=443 --cache.size=30

# Start Meson CDN
sudo ./service start meson_cdn

# Display success message
echo "Meson CDN has been successfully installed and configured. You can now log in and check your node if it is online at <https://dashboard.meson.network/>. Follow me at <https://x.com/TitusNoderunner>"
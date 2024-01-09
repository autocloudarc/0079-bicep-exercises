#!/bin/bash
# This script installs PowerShell on an Ubuntu Linux VM in Azure.

# Check if PowerShell is already installed
if ! command -v pwsh &> /dev/null
then
    # Download the Microsoft repository GPG keys
    wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb

    # Register the Microsoft repository GPG keys
    sudo dpkg -i packages-microsoft-prod.deb

    # Update the list of products
    sudo apt-get update

    # Install PowerShell
    sudo apt-get install -y powershell

    # Remove the Microsoft repository GPG keys
    rm packages-microsoft-prod.deb
else
    echo "PowerShell is already installed"
fi

# Get PowerShell version
pwsh --version
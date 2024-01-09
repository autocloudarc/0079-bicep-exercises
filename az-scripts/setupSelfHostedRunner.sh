#!/bin/bash
# This script installs the prerequisites for a self-hosted runner on an Ubuntu Linux VM in Azure.
# 0. agent/runner; 1. set agent/runner as service; 3. azure-cli; 4. unzip; 5. npm
# IMPORTANT: Pre-requisites for this script to work: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
# Set agent/runner as service
# https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service
cd /home/$shrUserName/actions-runner/

case "$(az --version 2>&1)" in
    *"command not found"*)
        echo "Azure CLI is not installed. Installing now."
        # Install azure-cli for az commands
        # https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash
        ;;
esac

case "$(unzip 2>&1)" in
    *"Usage:"*)
        ;;
    *)
        # Install unzip for unzipping tgz files
        apt-get install unzip
        ;;
esac

case "$(node --version 2>&1)" in
    *"not found"*)
        # Install npm and nodejs for certain workflow actions
        apt-get install nodejs
        ;;
esac








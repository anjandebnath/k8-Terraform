#!/bin/bash

#
# Provision a development environment under Vagrant.
#

# https://serverfault.com/questions/227190/how-do-i-ask-apt-get-to-skip-any-interactive-post-install-configuration-steps
export DEBIAN_FRONTEND=noninteractive

#
# Install Docker.
# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
#
sudo apt-get -yq update
sudo apt-get -yq install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key -yq fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -yq update
sudo apt-get -yq install docker-ce
docker --version

#
# Install Docker Compose.
# https://docs.docker.com/compose/install/
#
sudo curl --silent -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#
# Install Azure cli.
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest
#
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt-get -yq update
sudo apt-get -yq install apt-transport-https azure-cli

#
# Install Terraform
#
# https://www.terraform.io/downloads.html
#
sudo apt-get -yq install unzip
wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
unzip terraform_0.12.29_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 

#
# User setup for docker.
#
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart




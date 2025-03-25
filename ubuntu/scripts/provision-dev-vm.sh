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
# Install Terraform
#
# https://www.terraform.io/downloads.html
#

#!/bin/bash

# Exit on error
set -e

echo "Updating package lists..."
sudo apt-get update -y

echo "Installing dependencies..."
sudo apt-get install -y wget unzip

# Detect system architecture
ARCH=$(dpkg --print-architecture)
if [[ "$ARCH" == "arm64" ]]; then
    TERRAFORM_ARCH="arm64"
elif [[ "$ARCH" == "amd64" ]]; then
    TERRAFORM_ARCH="amd64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Downloading Terraform..."
TERRAFORM_VERSION="1.6.0"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TERRAFORM_ARCH}.zip -O terraform.zip

echo "Unzipping Terraform..."
unzip terraform.zip

echo "Moving Terraform to /usr/local/bin..."
sudo mv terraform /usr/local/bin/

echo "Setting permissions..."
sudo chmod +x /usr/local/bin/terraform

echo "Verifying Terraform installation..."
terraform --version

echo "Terraform installation completed!"


#!/bin/bash
#
# Install MongoDB tools (for loading data into database).
#
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get -yq update
sudo apt-get install -y mongodb-org-tools=4.2.0


$ curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


#
# User setup for docker.
#
sudo groupadd docker  # Creates a new group called "docker" on the system
sudo gpasswd -a $USER docker #Adds the current user (represented by the variable $USER) to the "docker" group
sudo service docker restart # Restarts the Docker service/daemon to apply the group changes


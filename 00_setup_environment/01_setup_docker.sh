#!/bin/bash

DOCKER_VERSION_STRING=5:20.10.6~3-0~ubuntu-bionic
CONTAINERDIO_VERSION_STRING=1.4.4-1


#Installation instruction: https://docs.docker.com/engine/install/ubuntu/

#Update package index
sudo apt-get update

#Install required packages
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

#Add dockers official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#Set up the repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Update packages again
sudo apt-get update

#Install docker engine
sudo apt-get install docker-ce=$DOCKER_VERSION_STRING docker-ce-cli=$DOCKER_VERSION_STRING containerd.io=$CONTAINERDIO_VERSION_STRING


docker --version


# run docker without root privileges (@see: https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user)
# create the docker group
sudo groupadd docker

# add your user to the docker group
sudo usermod -aG docker $USER

echo '#########################################################################'
echo '#########################################################################'
echo 'Log out and log back in so that your group membership is re-evaluated. Afterwards you can start "docker run hello-world" without keyword "sudo"'

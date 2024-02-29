#!/bin/bash

#Install Docker
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
#Install Jenkins
#Jenkins requires Java to run, so first install Java -->
sudo apt-get update -y
sudo apt install openjdk-11-jre -y

#Long-Term Support release of Jenkins---->

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl status jenkins
sudo systemctl enable jenkins
sudo systemctl status docker
sudo systemctl enable docker

docker --version
java -version
jenkins --version
sudo system reboot
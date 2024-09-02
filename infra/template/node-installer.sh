#!/bin/bash
sudo apt-get update
cd /home/ubuntu
# Setup docker
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
sudo systemctl start docker
sudo systemctl enable docker
# Setup sonarqube
docker run -d --name sonarqube -p 9000:9000 sonarqube
# Setup app
git clone https://github.com/firstpersoncode/tf.git && cd tf
docker build -t app .
echo "NEXT_PUBLIC_SANITY_PROJECT_ID=ss2i7z2g" >> .env
echo "NEXT_PUBLIC_SANITY_DATASET=production" >> .env
docker run --name app -p 3000:3000 -d app
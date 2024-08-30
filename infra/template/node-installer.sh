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

# Setup docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Setup node
git clone https://github.com/firstpersoncode/tf.git && cd tf
echo "POSTGRES_USER=postgres" >> .env
echo "POSTGRES_PASSWORD=postgres" >> .env
echo "POSTGRES_NAME=postgres" >> .env
echo "PGADMIN_DEFAULT_EMAIL=pgadmin@pgadmin.com" >> .env
echo "PGADMIN_DEFAULT_PASSWORD=pgadmin" >> .env
echo "SONARQUBE_JDBC_USERNAME=sonar" >> .env
echo "SONARQUBE_JDBC_PASSWORD=sonar" >> .env
echo "SONARQUBE_JDBC_URL=jdbc:postgresql://db:5432/sonar" >> .env

# bootstrap
docker-compose up -d --build
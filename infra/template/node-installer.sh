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
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

git clone https://github.com/firstpersoncode/tf.git && cd tf
echo "POSTGRES_DB=postgres" >> .env
echo "POSTGRES_PASSWORD=postgres" >> .env
echo "POSTGRES_NAME=postgres" >> .env
echo "PGADMIN_DEFAULT_EMAIL=pgadmin@pgadmin.com" >> .env
echo "PGADMIN_DEFAULT_PASSWORD=pgadmin" >> .env
echo "SONARQUBE_JDBC_URL=jdbc:postgresql://postgres:5432/sonar" >> .env
echo "SONARQUBE_JDBC_USERNAME=sonar" >> .env
echo "SONARQUBE_JDBC_PASSWORD=sonar" >> .env
docker-compose up -d
# # bootstraps
# docker build -t app .
# docker run --name app -p 3000:3000 -d app
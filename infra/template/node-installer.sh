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
# Setup sonarqube
docker run -d --name sonarqube -p 9000:9000 sonarqube
# Setup app
git clone https://github.com/firstpersoncode/tf.git && cd tf
docker build -t app .
docker run --name app -p 3000:3000 -d app
# Setup cms
git clone https://github.com/firstpersoncode/cms.git && cd cms
echo "DATABASE_CLIENT=postgres" > .env
echo "DATABASE_HOST=db" >> .env
echo "POSTGRES_DB=postgres" >> .env
echo "DATABASE_NAME=postgres" >> .env
echo "POSTGRES_PASSWORD=postgres" >> .env
echo "DATABASE_USERNAME=postgres" >> .env
echo "PGADMIN_DEFAULT_EMAIL=pgadmin@pgadmin.com" >> .env
echo "PGADMIN_DEFAULT_PASSWORD=pgadmin" >> .env
docker-compose up -d
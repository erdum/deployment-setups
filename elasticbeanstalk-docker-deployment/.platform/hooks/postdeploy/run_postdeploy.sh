#!/bin/bash

# Wait for the container to be ready
sleep 5

# Run composer install inside the running container
sudo docker exec $(sudo docker ps -q -f "ancestor=aws_beanstalk/current-app") sh -c 'composer install'

sudo docker exec $(sudo docker ps -q -f "ancestor=aws_beanstalk/current-app") sh -c 'chmod 777 -R /var/www/html/storage/ /var/www/html/bootstrap/cache/'

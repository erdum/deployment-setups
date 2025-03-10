#!/bin/bash

exec > /var/log/postdeploy.log 2>&1  # Redirect output to a log file

echo "Starting post-deployment script..."

# Wait longer for the container to be fully ready
sleep 20

CONTAINER_ID=$(sudo docker ps -q -f "ancestor=aws_beanstalk/current-app")
if [ -z "$CONTAINER_ID" ]; then
  echo "Error: No running container found."
  docker ps -a  # Log running containers for debugging
  exit 1
fi

echo "Container ID: $CONTAINER_ID"

# Log container details
sudo docker inspect $CONTAINER_ID

echo "Running composer install inside container..."
sudo docker exec $CONTAINER_ID sh -c 'composer install'

echo "Setting storage permissions..."
sudo ls -ld /var/app/current/storage /var/app/current/bootstrap/cache
sudo chmod -R 777 /var/app/current/storage /var/app/current/bootstrap/cache
sudo ls -ld /var/app/current/storage /var/app/current/bootstrap/cache

if [ ! -f /var/app/current/storage/logs/laravel.log ]; then
  echo "Creating /storage/logs/laravel.log..."
  sudo mkdir /var/app/current/storage/logs
  sudo touch /var/app/current/storage/logs/laravel.log
  sudo chown -R webapp:webapp /var/app/current/storage/logs
  sudo chmod -R 777 /var/app/current/storage/logs
fi

echo "Starting Supervisor..."
sudo docker exec $CONTAINER_ID sh -c 'service supervisor start'

echo "Restarting Supervisor processes..."
sudo docker exec $CONTAINER_ID sh -c 'supervisorctl reread && supervisorctl update && supervisorctl start all'

echo "Post-deployment script completed."

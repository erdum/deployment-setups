#!/bin/bash

exec > /var/log/setup_cron.log 2>&1  # Redirect output to log file

echo "Setting up Laravel scheduler cron job..."

CONTAINER_ID=$(sudo docker ps -q -f "ancestor=aws_beanstalk/current-app")

if [ -z "$CONTAINER_ID" ]; then
  echo "Error: No running container found."
  exit 1
fi

echo "Container ID: $CONTAINER_ID"

# Create cron job
cat <<EOL | sudo tee /etc/cron.d/laravel_scheduler
* * * * * root docker exec $CONTAINER_ID sh -c 'php /var/www/html/artisan schedule:run >> /var/log/laravel_scheduler.log 2>&1'
EOL

# Ensure correct permissions
sudo chmod 0644 /etc/cron.d/laravel_scheduler
sudo systemctl restart crond

echo "Cron job added successfully."

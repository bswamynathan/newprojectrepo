
#!/bin/bash

# Variables
CONTAINER_NAME="my-react-app"        



#Stop $CONTAINER_NAME if running

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

#Run the application using Docker Compose

docker-compose up -d

if [ $? -eq 0 ]; then
  echo "Deploy Success"
else
  echo "Failed to deploy"
  exit 1
fi



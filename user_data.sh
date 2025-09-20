#!/bin/bash
# Update the package list
apt-get update -y

# Install Docker
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce
usermod -aG docker ubuntu

# Wait for Docker to be fully running
while ! docker info; do
  echo "Waiting for Docker daemon..."
  sleep 1
done

CONTAINER_NAME="node_app_container"

# Stop and remove old container if it exists
if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
  echo "Stopping old container..."
  docker stop ${CONTAINER_NAME} || true
  docker rm ${CONTAINER_NAME} || true
fi

# Pull the new tagged image
docker pull ${docker_image}

# Run the container
docker run -d --name ${CONTAINER_NAME} -p 80:3000 ${docker_image}

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

# Pull the Docker image
docker pull ${docker_image}

# Create a host directory for the app
HOST_APP_DIR="/home/ubuntu/app"
mkdir -p ${HOST_APP_DIR}
chown -R ubuntu:ubuntu ${HOST_APP_DIR} || true

# If the host app directory is empty, extract the app files from the image
if [ -z "$(ls -A ${HOST_APP_DIR})" ]; then
  echo "Host app dir is empty; extracting app files from image into ${HOST_APP_DIR}"

  tmp_container=$(docker create ${docker_image})
  docker cp $tmp_container:/usr/src/app/. ${HOST_APP_DIR}/ || true
  docker rm $tmp_container || true
  chown -R ubuntu:ubuntu ${HOST_APP_DIR} || true
fi

# Stop and remove any existing container with the same name
if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
  docker stop ${CONTAINER_NAME} || true
  docker rm ${CONTAINER_NAME} || true
fi

# Run the container
docker run -d -p 80:3000 --name ${CONTAINER_NAME} -v ${HOST_APP_DIR}:/usr/src/app ${docker_image}
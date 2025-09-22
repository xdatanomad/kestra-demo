#!/bin/bash

# This script removes selected plugins from the Kestra image by extracting them
# and placing them in a local directory. This allows you to start Kestra without
# the unwanted plugins.
#
# Docs: https://kestra.io/docs/getting-started/selected-plugin-installation#option-2-preload-plugin-jars-locally


IMAGE="kestra/kestra:latest"                            # open source kestra image
# IMAGE="registry.kestra.io/docker/kestra-ee:latest"      # kestra enterprise image

# setup local dirs
if [ -d "./local-plugins" ]; then
    rm -rf ./local-plugins
fi
if [ -d "./kestra-wd" ]; then
    rm -rf ./kestra-wd
fi
mkdir -p ./local-plugins
mkdir -p ./kestra-wd


# download kestra's full image
echo "Pulling Kestra image: $IMAGE"
docker pull $IMAGE

# create a temporary container to extract the plugins
docker run --rm -d --name kestra-temp kestra/kestra:latest

# check if the container is running
CONTAINER_ID=$(docker ps -qf "name=kestra-temp")
if [ -z "$CONTAINER_ID" ]; then
    echo "Failed to create temporary container."
    exit 1
fi

# copy the plugins directory from the container to the host
echo "Extracting plugins from the Kestra image..."
docker cp kestra-temp:/app/plugins/. ./local-plugins

# stop and remove the temporary container
docker rm -f kestra-temp

# example of removing unwanted plugins
echo "Removing unwanted plugins..."
rm -rf ./local-plugins/*-googleworkspace*.jar
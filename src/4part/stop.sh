#!/bin/bash
CONTAINER_ID=$(docker ps -q -n 1)
IMAGE_ID=$(docker images -q)

docker stop $CONTAINER_ID
docker rm $CONTAINER_ID
docker rmi -f $IMAGE_ID
docker ps
docker images

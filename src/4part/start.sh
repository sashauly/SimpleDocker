#!/bin/bash
docker build -t nginx:part4 -f Dockerfile .
docker images
docker run -dp 80:81 -v /Users/stonehom/Documents/projects/DO5_SimpleDocker-1/src/4part/nginx:/etc/nginx -t nginx:part4
docker ps
CONTAINER_ID=$(docker ps -q -n 1)
docker exec $CONTAINER_ID curl localhost:81/
curl localhost:80
curl localhost:80/status

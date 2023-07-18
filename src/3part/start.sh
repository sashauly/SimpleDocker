#!/bin/bash

docker run -dp 80:81 nginx

CONTAINER_ID=$(docker ps -q -n 1)

docker cp ./server/server.c $CONTAINER_ID:/
docker cp ./nginx/nginx.conf $CONTAINER_ID:/etc/nginx/nginx.conf
docker exec $CONTAINER_ID nginx -s reload
docker exec $CONTAINER_ID apt update
docker exec $CONTAINER_ID apt-get install -y gcc spawn-fcgi libfcgi-dev
docker exec $CONTAINER_ID gcc server.c -lpthread -lfcgi -o server
docker exec $CONTAINER_ID spawn-fcgi -p 8080 ./server
docker exec $CONTAINER_ID curl localhost:81/
curl localhost:80
curl localhost:80/status

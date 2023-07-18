#!/bin/bash
export DOCKER_CONTENT_TRUST=1
docker build -t nginx:part5 -f Dockerfile .
docker images
docker run -dp 80:81 -v /Users/stonehom/Documents/projects/DO5_SimpleDocker-1/src/5part/nginx:/etc/nginx -t nginx:part5
docker ps

dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH nginx:part5
# CONTAINER_ID=$(docker ps -q -n 1)
# docker exec $CONTAINER_ID curl localhost:81/
# curl localhost:80
# curl localhost:80/status

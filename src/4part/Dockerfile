FROM nginx:latest

COPY ./server/server.c server.c
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN \
  apt update && \
  apt-get install -y spawn-fcgi \
  libfcgi-dev \
  gcc && \
  gcc server.c -lpthread -lfcgi -o server

ENTRYPOINT spawn-fcgi -p 8080 ./server && nginx -g 'daemon off;'
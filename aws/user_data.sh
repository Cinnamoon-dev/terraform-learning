#!/usr/bin/env bash

sudo apt update
sudo apt install nginx -y

echo """
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm; 
    }
}
""" > /etc/nginx/conf.d/default.conf
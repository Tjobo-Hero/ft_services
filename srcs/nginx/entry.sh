#!/bin/sh

mkdir -p /var/run/nginx

ssh-keygen -A
adduser --disabled-password tvan-cit
echo "tvan-cit:tvan-cit" | chpasswd
/usr/sbin/sshd

nginx -g "daemon off;"

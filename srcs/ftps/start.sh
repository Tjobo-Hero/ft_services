#!/bin/sh

adduser -D -h /var/ftp tvan-cit
echo "tvan-cit:thisisworking" | chpasswd
vsftpd /etc/vsftpd/vsftpd.conf

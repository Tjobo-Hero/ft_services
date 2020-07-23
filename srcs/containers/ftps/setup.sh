#!/bin/sh
mkdir -p /ftps/$FTP_USER

openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -subj "/C=NL/ST=Noord-Holland/O=Codam 42/CN=services" -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
chmod 600 /etc/ssl/private/vsftpd.pem
# openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -subj "/C=FR/ST=NL/L=AMSTERDAM/O=CODAM/CN=tvan-cit" -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
# chmod 600 /etc/ssl/private/vsftpd.pem

adduser -h /ftps/$FTP_USER -D $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

# /usr/sbin/vsftpd -j -Y 2 -p 21000:21000 -P "192.168.99.230"

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
  
# #!/bin/sh
# mkdir -p /ftps/bpeeters


# adduser -h /ftps/bpeeters -D bpeeters
# echo "bpeeters:fluffclub" | chpasswd

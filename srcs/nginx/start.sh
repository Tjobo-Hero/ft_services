ssh-keygen -A
/usr/sbin/sshd
nginx

# This will make sure the container closes if one of its components shuts down.
while :
do
	sleep 10
	ps | grep nginx | grep master
	if [ $? == 1 ]
	then
		echo "died because nginx"
		break
	fi
	ps | grep sshd | grep listener
	if [ $? == 1 ]
	then
		echo "died because ssh"
		break
	fi
done

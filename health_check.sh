#!/bin/sh
# MySQL health check script for multi-server.
# Written by jjorae.

# User/Password
MY_USER=root
MY_PASS=root

# Your MySQL home directory location.
MY_HOME=/mysql

# Set timeout for health check.
MY_TIMEOUT=10

# MySQL server list file.
HOST_LIST=/mysql/host_list.txt

if test $1
then
	HOST_LIST=$1
fi

if test -e $HOST_LIST
then
	echo "======================================="
	echo "  MySQL health check for multi-server  "
	echo "  Output : Dead = 0, Alive = 1         "
        echo "======================================="
	for i in $(cat $HOST_LIST)
	do
		if test -n "`$MY_HOME/bin/mysqladmin -u$MY_USER -p$MY_PASS -h $i --connect_timeout=$MY_TIMEOUT ping 2>/dev/null`"
		then
			echo '  '$i ':' 1
		else
			echo '  '$i ':' 0
		fi
	done
        echo "======================================="
else
	echo "  Host list file for health check not found!  "
fi

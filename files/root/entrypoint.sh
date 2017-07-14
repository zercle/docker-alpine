#!/usr/bin/env bash

if [ ! -e /etc/ssl/dhparam.pem ]; then
libressl dhparam -out /etc/ssl/dhparam.pem 2048
fi

service sshd restart

tail -f /dev/null

exit $?

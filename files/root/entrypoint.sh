#!/usr/bin/env bash

openssl dhparam -dsaparam -out /etc/ssl/dhparam.pem 4096

service sshd restart

tail -f /dev/null

exit $?

#!/bin/bash

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

CONFIG=/go-server/temp/cruise-config.xml	

if test -f "$CONFIG"; then
    cp $CONFIG /go-server/config/cruise-config.xml
fi

/bin/bash docker-entrypoint.sh
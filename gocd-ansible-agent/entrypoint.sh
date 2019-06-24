#!/bin/bash

# Give our arbitrary UID a name
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

CONFIG=/go-agent/temp/autoregister.properties	

if test -f "$CONFIG"; then
    mkdir -p /go/config/
    cp $CONFIG /go/config/autoregister.properties
fi

# Run the existing entrypoint
/bin/bash /docker-entrypoint.sh
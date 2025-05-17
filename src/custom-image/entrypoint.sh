#!/bin/bash

/usr/sbin/sshd
exec /opt/bitnami/scripts/wordpress/entrypoint.sh "$@"

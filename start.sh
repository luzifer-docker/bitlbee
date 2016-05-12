#!/bin/bash -x

if [ -e /data/bitlbee.conf ]; then
  rm -rf /etc/bitlbee
  ln -sf /data /etc/bitlbee
fi

exec /usr/sbin/bitlbee -F -n

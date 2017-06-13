#!/bin/sh

dig +noall +answer $BACKUPS | grep 10. | sort -n | awk '{print $NF}' | grep -v $IP > /var/backups.txt

if [ "$(md5sum /var/backups.txt | cut -d' ' -f1)" != "$(md5sum /etc/autoproxy.d/services/backups.txt | cut -d' ' -f1)" ]
then
  /bin/cp /var/backups.txt /etc/autoproxy.d/services/backups.txt
fi


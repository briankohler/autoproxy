#!/bin/sh

RNDM=$(( ( RANDOM % 60 )  + 1 ))
echo "${RNDM} * * * * /var/cleanup.sh" >> /var/spool/cron/crontabs/root
/usr/sbin/rsyslogd -f /etc/rsyslog.conf
while true; do nc -l -p 10000 </etc/haproxy/haproxy.cfg;done &

# Starting AutoProxy
if [ -z "$1" ]; then
    exec /bin/autoproxy
elif [ "${1:0:1}" = '-' ]; then
    exec /bin/autoproxy $@
else
    exec $@
fi


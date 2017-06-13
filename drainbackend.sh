#!/bin/sh

for i in $(echo "show servers state ${1}" | socat stdio /tmp/haproxy.sock | grep " ${1} " | awk '{print $4}')
do
  echo "set server ${1}/${i} state drain" | socat stdio /tmp/haproxy.sock > /dev/null
  echo "Drained ${1}/${i}" 
done

for i in $(echo "show servers state ${1}" | socat stdio /tmp/haproxy.sock | grep " ${1} " | awk '{print $4}')
do
  sleep 1
  echo "set server ${1}/${i} state disable" | socat stdio /tmp/haproxy.sock > /dev/null
  echo "Disabled ${1}/${i}"
done


#!/bin/sh

sleep 2

for i in $(echo "show servers state ${1}" | socat stdio /tmp/haproxy.sock | grep " ${1} " | awk '{print $4}')
do
  echo "set server ${1}/${i} state ready" | socat stdio /tmp/haproxy.sock > /dev/null
  echo "Servers ${1}/${i} are ready" 
done


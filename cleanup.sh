#!/bin/sh

if [ -n $(pgrep haproxy | head -n-1) ]
then
  kill $(pgrep haproxy | head -n-1)
fi


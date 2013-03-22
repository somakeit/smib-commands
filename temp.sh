#!/bin/bash
RAW=$(cat /sys/bus/w1/devices/*/w1_slave 2>/dev/null | tail -n1 | sed 's/^.*=//')
if [ "$RAW" == "" ]; then
  echo "Temperature unavailable."
  exit
fi
TEMP=$(echo "scale=1;$RAW/1000" | bc)
echo "Temperature: ${TEMP}C"

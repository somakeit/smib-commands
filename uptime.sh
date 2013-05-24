#!/bin/sh
#bot uptime
echo -n 'bot: '
ps -p $(ps -e | grep smib.pl | awk '{print $1}') h -o %t
echo -n 'box:'
uptime

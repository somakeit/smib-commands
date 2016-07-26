#!/bin/sh
#bot uptime
echo -n 'bot: '
ps -p $(ps -f $$ | tail -n 1 | awk '{print $3}') h -o %t
echo -n 'box:'
uptime

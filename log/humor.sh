#!/bin/bash

FLOOD_SECS=180;

#flood control time
if [[ `/bin/date +%s` -lt `expr $(/bin/cat humor/flood_control) + $FLOOD_SECS` ]]; then
  exit 0
fi

#check for humor
if [[ "$4" == *lol* ]] || \
   [[ "$4" == *LOL* ]] || \
   [[ "$4" == *hehe* ]] || \
   [[ "$4" == *rofl* ]] || \
   [[ "$4" == *ROFL* ]] || \
   [[ "$4" == *lmao* ]] || \
   [[ "$4" == *LMAO* ]]; then
     echo "lol"
fi

#flood control
/bin/date +%s > humor/flood_control

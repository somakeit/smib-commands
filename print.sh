#!/bin/bash
if [ $(echo $4 | wc -c) -gt 17 ]; then
  echo $4 | flipdot/scroll_text.py
else
  echo $4 | flipdot/gen_string.py
fi
if [ "$?" == "0" ]; then
  echo "$1, flipping done"
else
  echo "$1, something flipped out."
fi

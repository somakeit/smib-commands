#!/bin/bash
echo $4 | flipdot/print_text.py
if [ "$?" == "0" ]; then
  echo "$1, flipping done"
else
  echo "$1, something flipped out."
fi

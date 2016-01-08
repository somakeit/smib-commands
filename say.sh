#!/bin/bash
echo "$4" | festival --tts
echo $4 | flipdot/scroll_text.py
if [ "$?" == "0" ]; then
  echo "$1, done"
else
  echo "$1, something went wrong."
fi

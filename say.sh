#!/bin/bash
echo "$4" | festival --tts
if [ "$?" == "0" ]; then
  echo "$1, done"
else
  echo "$1, something went wrong."
fi

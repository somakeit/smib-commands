#!/bin/bash
echo "$4" | festival --tts
./print.sh "$1" "$2" "$3" "$4" >/dev/null
if [ "$?" == "0" ]; then
  echo "$1, done"
else
  echo "$1, something went wrong."
fi

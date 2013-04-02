#!/bin/bash
if [ "$4" == "aloud" ]; then
  fortune | tee >(cat - >&2) | festival --tts 2>&1
else
  fortune
fi

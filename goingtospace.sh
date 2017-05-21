#!/bin/bash

speakmsg="$1 is coming to the space."

#echo "$speakmsg" | festival --tts
espeak -ven+f3 -k5 -s150 "$speakmsg" &> /dev/null
#echo $speakmsg | flipdot/scroll_text.py
echo '🚀'

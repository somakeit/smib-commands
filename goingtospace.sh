#!/bin/bash

speakmsg="$1 is coming to the space."

echo "$speakmsg" | festival --tts
echo $speakmsg | flipdot/scroll_text.py
echo '🚀'

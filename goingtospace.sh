#!/bin/bash

cat ./goingtospace

speakmsg="$1 is coming to the space."

echo "$speakmsg" | festival --tts

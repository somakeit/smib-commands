#!/bin/sh
/usr/bin/aplay webcam/5-4-3-2-1.wav
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/usr/bin/fswebcam -S 10 --title SoMakeIt $FILE
if [ "$?" != "0" ]; then exit 1; fi
/usr/bin/scp --preserve $FILE members.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "a Ca-cheek" | festival --tts
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

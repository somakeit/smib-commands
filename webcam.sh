#!/bin/sh
echo "beep 5" | festival --tts; sleep 1
echo "beep 4" | festival --tts; sleep 1
echo "beep 3" | festival --tts; sleep 1
echo "beep 2" | festival --tts; sleep 1
echo "beep 1" | festival --tts; sleep 1
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/usr/bin/fswebcam -S 3 --title SoMakeIt $FILE
if [ "$?" != "0" ]; then exit 1; fi
/usr/bin/scp --preserve $FILE members.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "a Ca-cheek" | festival --tts
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

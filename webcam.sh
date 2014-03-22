#!/bin/sh
echo "say cheese" | festival --tts
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/opt/vc/bin/raspistill -w 800 -h 600 -o $FILE
if [ "$?" != "0" ]; then exit 1; fi
echo "Ca-cheek" | festival --tts
/usr/bin/scp -p $FILE members.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME

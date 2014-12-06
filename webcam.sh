#!/bin/sh
echo "say cheese" | festival --tts
sleep 5;
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
echo "Ca-cheek" | festival --tts &
/opt/vc/bin/raspistill --nopreview -t 1 -w 800 -h 600 -o $FILE
if [ "$?" != "0" ]; then exit 1; fi
/usr/bin/scp -p $FILE www.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

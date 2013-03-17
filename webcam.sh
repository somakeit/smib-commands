#!/bin/sh
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/usr/bin/fswebcam $FILE 2>&1
if [ "$?" != "0" ]; then exit 1; fi
/usr/bin/scp --preserve $FILE members.somakeit.org.uk:www 2>&1
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

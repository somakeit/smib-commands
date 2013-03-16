#!/bin/sh
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/usr/bin/fswebcam $FILE 2>&1
/usr/bin/scp --preserve $FILE members.somakeit.org.uk:www 2>&1
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

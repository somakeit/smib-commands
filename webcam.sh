#!/bin/sh
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
fswebcam $FILE
scp --preserve $FILE members.somakeit.org.uk:www
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"

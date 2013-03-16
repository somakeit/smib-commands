#!/bin/sh
FILE="/tmp/shot-`date +%F.%H-%M-%S`.jpg"
fswebcam $FILE
scp $FILE members.somakeit.org.uk:www
echo "Webcam: http://irccat.somakeit.org.uk/$FILE"

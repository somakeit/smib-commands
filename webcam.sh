#!/bin/sh
/usr/bin/aplay webcam/5-4-3-2-1.wav &
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
/usr/bin/fswebcam -S 10 --title SoMakeIt $FILE
/usr/bin/wget http://10.0.0.4/image.jpg -O eyecam.jpg 
if [ "$?" != "0" ]; then exit 1; fi
wait %1
echo "a Ca-cheek" | festival --tts
/usr/bin/scp --preserve $FILE members.somakeit.org.uk:www
/usr/bin/scp --preserve eyecam.jpg members.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME http://irccat.somakeit.org.uk/eyecam.jpg"

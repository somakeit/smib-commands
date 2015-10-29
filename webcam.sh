#!/bin/bash
echo "say cheese" | festival --tts
sleep 5;
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
echo "Ca-cheek" | festival --tts &
/opt/vc/bin/raspistill --nopreview -t 3 -w 1280 -h 960 -o $FILE
if [ "$?" != "0" ]; then exit 1; fi

if [ $(identify -format "%[mean]" $FILE) -gt 5000 ]; then
    if [ $(expr $RANDOM % 5) -eq 0 ]; then
        /usr/bin/composite webcam/ghostoverlay.png $FILE $FILE
    fi
fi

/usr/bin/scp -p $FILE irccat@www.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"
rm $FILE

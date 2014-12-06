#!/bin/sh
echo "say cheese" | festival --tts
sleep 5;
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
echo "Ca-cheek" | festival --tts &
/opt/vc/bin/raspistill --nopreview -t 3 -w 1280 -h 720 -o $FILE.1.jpg
if [ "$?" != "0" ]; then exit 1; fi
curl -o $FILE.2.jpg http://10.0.0.61:8080/latest.jpg
if [ "$?" == "0" ]; then
        convert $FILE.2.jpg -resize 1280x720 $FILE.3.jpg
        convert $FILE.1.jpg $FILE.3.jpg +append $FILE
else
        mv $FILE.1.jpg $FILE
fi
rm $FILE.1.jpg
rm $FILE.2.jpg
rm $FILE.3.jpg
/usr/bin/scp -p $FILE www.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Webcam: http://irccat.somakeit.org.uk/$FILENAME"
rm $FILE

#!/bin/bash
if [[ "$(ps -o comm= $PPID)" =~ "smib.pl" ]]; then
        if [[ "$2" != "#somakeit" ]]; then
                echo "Sorry $1, you can only take photos in #somakeit."
                exit 0
        fi
fi
if [[ "$2" != "general" ]]; then
        echo "Sorry $1, you can only take photos in #general."
        exit 0
fi

echo "say cheese" | festival --tts
sleep 5;
FILENAME="shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
echo "Ca-cheek" | festival --tts &
/opt/vc/bin/raspistill --nopreview -t 8 --exposure verylong -w 1280 -h 960 -o $FILE.1.jpg
if [ "$?" != "0" ]; then exit 1; fi
curl -o $FILE.2.jpg http://10.0.0.64:8080/latest.jpg
if [ "$?" == "0" ]; then
        convert $FILE.2.jpg -resize 1280x960 $FILE.3.jpg
        convert $FILE.1.jpg $FILE.3.jpg +append $FILE
else
        mv $FILE.1.jpg $FILE
fi
rm $FILE.1.jpg
rm $FILE.2.jpg
rm $FILE.3.jpg
#Set the white level to the mean level plus one standard deviation
/usr/bin/mogrify -level 0%,$(bc <<< "$(identify -verbose $FILE | grep -A 7 'Image statistics' | tr \) \( | grep 'mean' | cut -d \( -f 2) * 100 + $(identify -verbose $FILE | grep -A 7 'Image statistics' | tr \) \( | grep 'standard deviation' | cut -d \( -f 2) * 100")% $FILE
/usr/bin/scp -p $FILE www.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Enhanced: http://irccat.somakeit.org.uk/$FILENAME"
rm $FILE

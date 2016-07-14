#!/bin/bash
echo "say cheese" | festival --tts
sleep 5;
FILENAME="enhanced-shot-`date +%F.%H-%M-%S`.jpg"
FILE="/tmp/$FILENAME"
echo "Ca-cheek" | festival --tts &
/opt/vc/bin/raspistill --nopreview -t 3 -w 1280 -h 960 -o $FILE
if [ "$?" != "0" ]; then exit 1; fi

#Set the white level to the mean level plus one standard deviation
/usr/bin/mogrify -level 0%,$(bc <<< "$(identify -verbose $FILE | grep -A 7 'Image statistics' | tr \) \( | grep 'mean' | cut -d \( -f 2) * 100 + $(identify -verbose $FILE | grep -A 7 'Image statistics' | tr \) \( | grep 'standard deviation' | cut -d \( -f 2) * 100")% $FILE

/usr/bin/scp -p $FILE irccat@www.somakeit.org.uk:www
if [ "$?" != "0" ]; then exit 1; fi
echo "Enhanced: http://irccat.somakeit.org.uk/$FILENAME"
rm $FILE

#!/bin/bash

user=$1
channel=$2
name=$(echo ${4,,} | /usr/bin/awk '{printf $1}' | tr '[\\~\[]' '[|^{]' | tr ']' '}')

if [[ $channel == "null" ]]; then
  echo "You know nobody other than you and I have ever spoken in this channel, right?"
  exit 0
fi

if [ -z "$name" ]; then
  echo "Seen who, $user?"
  exit 0
fi

if [ -f log/seen/$channel/$name ]; then
  echo -n "Yes, on "
  echo -n $(/usr/bin/stat -c %z log/seen/$channel/$name | /usr/bin/cut -d '.' -f 1)
  echo -n " $name said "
  /bin/cat log/seen/$channel/$name
else
  echo "Sorry $user, I've not seen $name."
fi

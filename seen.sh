#!/bin/bash

user=$1
channel=$2
name=$(echo $4 | /usr/bin/awk '{printf $1}')

if [ -z "$name" ]; then
  echo "Seen who, $user?"
  exit 0
fi

if [ -f log/seen/$channel/$name ]; then
  echo -n "Yes, on "
  /bin/ls -l log/seen/$channel/$name | /usr/bin/awk '{printf $5 " " $6 " " $7 " " $8}'
  echo -n " $name said "
  /bin/cat log/seen/$channel/$name
else
  echo "Sorry $user, I've not seen $name"
fi

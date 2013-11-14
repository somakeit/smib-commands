#!/bin/bash

if [ -d tell/$2/$1 ]; then
  if [[ $(find tell/$2/$1/ | wc -l) -gt 1 ]]; then
    for user in tell/$2/$1/*; do
      username=$(echo $user | /usr/bin/awk -F "/" '{print $4}')
      date=$(/bin/ls -l $user | /usr/bin/awk '{printf $5 " " $6 " " $7 " " $8}')
      message=$(cat $user)
      echo "$1, on $date $username asked me to tell you $message"
      rm $user
    done
  fi
fi

#!/bin/bash

who=$(echo ${1,,} | tr '[\\~\[]' '[|^{]' | tr ']' '}')

if [ -d tell/$2/$who ]; then
  if [[ $(find tell/$2/$who/ | wc -l) -gt 1 ]]; then
    for user in tell/$2/$who/*; do
      username=$(echo $user | /usr/bin/awk -F "/" '{print $4}')
      date=$(/usr/bin/stat -c %x $user | /usr/bin/cut -d '.' -f 1)
      message=$(cat $user)
      echo "$1, on $date $username asked me to tell you $message"
      rm $user
    done
  fi
fi

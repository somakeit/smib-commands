#!/bin/bash

user=$1
channel=$2
who=$(echo ${4,,} | /usr/bin/awk '{print $1}')
message=$(echo $4 | /usr/bin/awk '{for(i=2;i<=NF;++i)print " " $i}')

if [[ $channel == "null" ]]; then
  echo "Sorry to disappoint you $user, but nobody else can ever join this channel."
  exit 0
fi

if [ -z "$who" ]; then
  echo "Who should I tell, $user?"
  exit 0
fi

if [ -z "$message" ]; then
  echo "Ok $user, what do you want me to tell $who?"
  exit 0
fi

if [ ! -d log/tell/$channel/$who ]; then
  mkdir -p log/tell/$channel/$who
fi

echo $message > log/tell/$channel/$who/$user
echo "Ok $user, will do."

#!/bin/sh
git fetch origin master
git reset --hard FETCH_HEAD
if [ "$?" == "0" ]; then
  echo "$2 git pull finished successfully, $1"
fi

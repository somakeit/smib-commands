#!/bin/sh
git fetch origin master
git reset --hard FETCH_HEAD
if [ "$?" == "0" ]; then
  echo "$1 git pull finished successfully, $2"
fi

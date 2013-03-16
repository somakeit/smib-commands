#!/bin/sh
git fetch --quiet origin master
git reset --hard FETCH_HEAD
if [ "$?" == "0" ]; then
  echo "$1: git pull finished successfully"
fi

#!/bin/sh
git fetch --quiet origin master
STATUS=$?
git reset --hard FETCH_HEAD
STATUS=$(($STATUS + $?))
chmod u+x ./*
STATUS=$(($STATUS + $?))
if [ "$STATUS" == "0" ]; then
  echo "$1: git pull finished successfully"
else
  echo "$1: something went wrong, check the system log"
fi

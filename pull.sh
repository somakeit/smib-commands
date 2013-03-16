#!/bin/sh
git pull --quiet --force
if [ "$?" == "0" ]; then
  echo "$1 git pull finished successfully, $2"
fi

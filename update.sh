#!/bin/bash
cd /home/irccat/smib
#what commit are we now?
COMMIT=$(git rev-parse HEAD)
#if the password is a merge conflict, manual update is needed.
git stash --quiet
git pull --quiet origin master
git stash pop --quiet
if [ "$?" == "0" ]; then
  echo "$1: git pull finished successfully"
else
  echo "$1: git pull failed, probably merge conflict, do it yourself"
  exit 0;
fi
#did we actually change?
if [ $COMMIT == $(git rev-parse HEAD) ]; then
  echo "$1: no changes, stop that."
  exit 0;
fi
#make the new bot live (systemd respawn)
echo "$1: Goodbye world! :-("
(sleep 3; killall smib.pl) &

#!/bin/bash
cd /home/irccat/smib
#what commit are we now?
COMMIT=$(git rev-parse HEAD)
#if the password is a merge conflict, manual update is needed.
git stash --quiet
git pull --quiet origin master
git stash pop --quiet
if [ "$?" == "0" ]; then
  echo -n "$1: git pull finished successfully. "
else
  echo -n "$1: git pull failed, probably merge conflict, do it yourself. "
  exit 0;
fi
#did we actually change?
if [ $COMMIT == $(git rev-parse HEAD) ]; then
  echo "No changes, stop that."
  exit 0;
fi
#make the new bot live (systemd respawn)
echo "HEAD is now at \"$(git log --oneline -n 1)\", will now kill myself, goodbye world! :-("
(sleep 3; killall smib.pl) &

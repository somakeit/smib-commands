#!/bin/sh

if [ "$4" == "" ]; then
  echo "$1, ?blame <commandname>"
  exit;
fi
CMD="$(ls "$4".* 2>/dev/null | head -n 1)"
if [ "$CMD" == "" ]; then
  echo "$1, command '$4' not found"
  exit;
fi
echo "$1, the last person to modify the '$4' command was "$(git log -n 1 --pretty=format:"%an https://github.com/so-make-it/irccat-commands/commit/%h" -- "$CMD")

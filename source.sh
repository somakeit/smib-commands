#!/bin/sh

if ! [[ "$4" =~ ^[a-zA-Z]+$ ]]; then
  echo "$1, ?source <commandname>"
  exit;
fi
CMD="$(ls "$4".* 2>/dev/null | head -n 1)"
if [ "$CMD" == "" ]; then
  echo "$1, command '$4' not found"
  exit;
fi
echo "https://github.com/so-make-it/irccat-commands/blob/master/$CMD"

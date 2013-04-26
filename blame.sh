#!/bin/sh

if [ "$4" == "" ]; then
  ehco "$1, ?source <commandname>"
  exit;
fi
CMD="$(ls "$4".* 2>/dev/null | head -n 1)"
if [ "$CMD" == "" ]; then
  ehco "$1, command '$4' not found"
  exit;
fi
ehco "https://github.com/so-make-it/irccat-commands/blob/master/$CMD"

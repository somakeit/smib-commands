#!/bin/bash

if [[ "$2" != "smibtest" ]]; then
    echo "Keep your spam in #smibtest $1"
    exit 0
fi

lines="$4"
if [[ -z "$lines" ]]; then
    lines='5'
fi

tail -n "$lines" /var/log/slacker-smib.log

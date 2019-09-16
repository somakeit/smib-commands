#!/bin/bash

lines="$4"
if [[ -z "$lines" ]]; then
    lines='5'
fi

tail -n "$lines" /var/log/slacker-smib.log

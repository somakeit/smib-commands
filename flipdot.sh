#!/bin/bash

OPT=$(echo $4 | sed -e 's/[^a-z]*//g')

if [[ -z "$OPT" ]]; then
    echo -n "flipdot takes these options: "
    ls flipdot/demos/ | tr '\n' ' '
else
    if [[ -x "./flipdot/demos/$OPT" ]]; then
        ./flipdot/demos/$4 >/dev/null &
        PID=$!
        sleep 30
        disown $PID
        kill $PID
    else
        echo -n "That's not an option, try: "
        ls flipdot/demos/ | tr '\n' ' '
    fi
fi

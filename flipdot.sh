#!/bin/bash

if [[ -z "$4" ]]; then
    echo -n "flipdot takes these options: "
    ls flipdot/demos/ | tr '\n' ' '
else
    if [[ -x "./flipdot/demos/$4" ]]; then
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

#!/bin/bash

bin=ibv_rc_pingpong

echo "Running ibv_rc_pingpong on `hostname` for 5 seconds..."
${bin} &
sleep 3
pid=`pidof ${bin}`
if [[ "${pid}" != "" ]]; then
    echo "Killing ${bin}..."
    killall ${bin}
else
    echo "ibv_rc_pingpong exited normally."
fi


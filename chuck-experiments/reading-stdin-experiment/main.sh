#!/bin/bash

if [ ! -p testfifo ]; then
    mkfifo testfifo
fi

chuck read-from-fifo.ck:testfifo &
PID=$!
bash note-player.sh
echo Done playing notes from script.
echo Try sending more via eg "'echo beep > testfifo'" in another terminal.
echo When done, Ctrl-C, or send "end" to testfifo

function cleanup() {
    kill "$PID"
}
trap cleanup SIGTERM
wait "$PID"

#!/bin/sh

echo "Simulate notes arriving one at a time via stdin"
echo "initial noise"
echo beep > testfifo
sleep 3
echo "going to go again"
echo beep > testfifo
# echo end > testfifo

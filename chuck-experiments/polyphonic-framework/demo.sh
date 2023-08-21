#!/bin/bash

# Bash hack to get directory containing this script
DIRNAME=`cd "${0%/*}" 2>/dev/null; echo "$PWD"/`
cd $DIRNAME

echo "Ctrl-C to stop."
echo "Will listen for OSC events. To send some, try: python udp_osc_client.py"

POLYPHONY=4;
if [ -n "$1" ]; then
    POLYPHONY=$1
fi
chuck note-params.ck \
      note-event.ck \
      note-off.ck \
      polyphonic-framework.ck \
      polyphonic-framework-osc-demo.ck:$POLYPHONY

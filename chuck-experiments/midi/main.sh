#!/bin/bash

echo "Here are two chuck programs sending midi to each other via virtual midi cable."
echo "This assumes that midi device 2 is that virtual midi cable"
echo "Example of how to set one up on MacOS: https://feelyoursound.com/setup-midi-os-x/"
echo
echo "If it's working you should see both 'sending' and 'Received' messages printed"
echo
chuck gomidi.ck:2 midiout.ck:2

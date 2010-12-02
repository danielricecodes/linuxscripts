#!/bin/sh
###Written by Daniel Rice to convert vox files to the right format on sip servers.
FORMAT_ORIG='adpcm'
FORMAT_NEW='alaw'
BITRATE_ORIG='8000'
BIRATE_NEW='8000'
echo "Converting from $FORMAT_ORIG $BITRATE_ORIG to $FORMAT_NEW $ BIRATE_NEW"
for f in *.vox
do
echo "Processing File: $f"
pcmconvert -i "$f" -F $FORMAT_ORIG -S $BITRATE_ORIG -o "/tmp/$1" -f $FORMAT_NEW -s $BITRATE NEW
done
exit 0

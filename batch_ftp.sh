#!/bin/bash
HOST="10.109.76.28"
USER="Noble"
PASSWD="H*\$Dmbj@*S"
for f in /archive/*.ncr
do

echo "Processing File: $f"
NEWFILE=`echo $f | sed 's#/archive/\(.*\.ncr\)#\1#'`
echo "New File: $NEWFILE"
ftp -nvd $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
lcd /archive
cd /archive/screenrecs
put $f $NEWFILE
quit
END_SCRIPT
done
exit 0

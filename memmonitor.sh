#!/bin/sh
#Shell added by Daniel Rice 10/3/2010 to monitor memory usage on the system.
#Code adapted from http://www.linuxquestions.org/questions/programming-9/how-to-programmatically-monitor-a-process-memory-usage-383517/
#Version History
#1.0 - changed the output file to report the Date and Time along side the memory statistics.


USAGE="Usage: $0 processName"

if [ $# -ne 1 ]; then
   echo $USAGE
   exit 1
fi


LOG_FILE="memusage.csv"

echo "Date,Time,ElapsedTime,VmSize (KB),VmRSS (KB),TotMem (B),UsedMem (B),FreeMem (B)" >> $LOG_FILE

ELAPSED_TIME=0
PERIOD=5        # seconds

# Monitor memory usage forever until script is killed
while :
do
   SUM_VM_SIZE=0
   SUM_RSS_SIZE=0
   # In case the monitored process has not yet started
   # keep searching until its PID is found
   PROCESS_PIDS=""
   while :
   do
      PROCESS_PIDS=`/sbin/pidof $1`

      if [ "$PROCESS_PIDS.X" != ".X" ]; then
         break
      fi
   done

   for PID in ${PROCESS_PIDS} ; do
     VM_SIZE=`awk '/VmSize/ {print $2}' < /proc/$PID/status`
     if [ "$VM_SIZE.X" = ".X" ]; then
        continue
     fi
     #echo exprVM_ $SUM_VM_SIZE + $VM_SIZE
     SUM_VM_SIZE=`expr $SUM_VM_SIZE + $VM_SIZE`

     VM_RSS=`awk '/VmRSS/ {print $2}' < /proc/$PID/status`
     if [ "$VM_RSS.X" = ".X" ]; then
        continue
     fi
     SUM_RSS_SIZE=`expr $SUM_RSS_SIZE + $VM_RSS`
   done

   TIME=`date +"%r %Z"`
   DATE=`date +%D`
   SYSMEM=`free -k | awk '/Mem/ {print $2,",",$3,",",$4}'`
   echo "$DATE,$TIME,$ELAPSED_TIME sec, $SUM_VM_SIZE, $SUM_RSS_SIZE,$SYSMEM"
   echo "$DATE,$TIME,$ELAPSED_TIME,$SUM_VM_SIZE,$SUM_RSS_SIZE,$SYSMEM" >> $LOG_FILE
   sleep $PERIOD
   VM_SIZE=""
   VM_RSS=""
   # Needs to get actual elapsed time instead of doing this
   ELAPSED_TIME=`expr $ELAPSED_TIME + $PERIOD`
done

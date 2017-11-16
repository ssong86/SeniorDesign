#!/bin/bash
MYPATH=/
outputFile=test
gameid=test
quarter=test

while getopts "d:g:q:o:" arg;
do
  case $arg in
    d) MYPATH=$OPTARG
	;;

    g) gameid=$OPTARG
	;;

    q) quarter=$OPTARG
	;;

    o) outputFile=$OPTARG
        ;;
  esac
done
currentTime=$(date +%s)
startTime=0
recordTime=0
fileStartTime=0
counter=1
cat timeFile.txt | (while read line
do
if [ $counter -eq 1 ]
then
   let "fileStartTime = $line"
fi
if [ $counter -eq 2 ]
then
   let "recordTime = $((currentTime - line))"
fi
if [ $counter -eq 3 ]
then
   let "startTime = $line"
fi
let "counter = $counter + 1"
done
((startSec=startTime%60, startTime/=60, startMin=startTime%60, startHrs=startTime/60))
startTimestamp=$(printf "%02d:%02d:%02d" $startHrs $startMin $startSec)
echo $startTimestamp
((recordSec=recordTime%60, recordTime/=60, recordMin=recordTime%60, recordHrs=recordTime/60))
recordTimestamp=$(printf "%02d:%02d:%02d" $recordHrs $recordMin $recordSec)
cd $MYPATH
outputFile=/$gameid/$quarter/$outputFile.mp4
/usr/local/bin/ffmpeg -i fullgame.avi -ss $startTimestamp -t $recordTimestamp -async 1 -strict -2 $outputFile
echo $fileStartTime > timeFile.txt)

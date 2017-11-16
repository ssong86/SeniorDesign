#!/bin/bash
currentTime=$(date +%s)
echo $currentTime >> timeFile.txt

counter=1
cat timeFile.txt | (while read line
do
if [ $counter -eq 1 ]
then
   let "startTime = $((currentTime - line)) "
   echo $startTime >> timeFile.txt
   echo $startTime >> startTimestamps.txt
fi
let "counter = $counter + 1"
done)

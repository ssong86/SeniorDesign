#!/bin/bash 
SRCPATH="/Users/VipLab2/Desktop/Game Capture HD Library/002/"
DESPATH="/Users/VipLab2/Desktop/"
echo ${SRCPATH}
cd "${SRCPATH}" && rsync -av *.mp4 ${DESPATH} 
 

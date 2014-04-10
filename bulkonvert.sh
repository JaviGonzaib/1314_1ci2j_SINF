#!/bin/bash
echo "Bulkonvert, convert avi videos to mp4"

# Script to convert all video files from a directory (parameter) into mp4 format file

# Sanity checks ?
# ...
if [ $# != 1 ] ;
then
	echo "You must put just 1 parameter. Thank you. "
	exit 1
elif ! [[ -d $1 ]] 
then 
echo "Parameter must be a folder. Check it please."
	exit 2
fi 
# Main code

ls -1 $1*.avi > listoffiles

while read videofile

do
	lengthname=${#videofile}
	namefile=${videofile:0:$lengthname-4}
	mencoder "$videofile" -o "$namefile".mpeg -oac mp3lame -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg

done < listoffiles
rm listoffiles


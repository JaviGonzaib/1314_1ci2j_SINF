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
elif ! [[ -r $1 ]] 
then 
echo "You don't have the right to read it"
	exit 3
elif ! [[ -w $1 ]] 
then 
echo "You don't have the right to write on it"
	exit 4
hash mencoder 2>/dev/null
if [[ $? !=0 ]]
echo "Mencoder is not installed in your computer"
	exit 5
fi 
# Main code

ls -1 $1*.avi > listoffiles

while read videofile

do
	lengthname=${#videofile}
	namefile=${videofile:0:$lengthname-4}
	mencoder "$videofile" -o "$namefile".mp4 -oac mp3lame -ovc lavc -of lavf

done < listoffiles
rm listoffiles


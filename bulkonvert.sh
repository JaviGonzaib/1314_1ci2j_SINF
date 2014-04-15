#!/bin/bash

echo "Bulkonvert, converting videos"

# Script to convert all video files from a directory (parameter) into mp4 format file
# 3 parameters. 1 Folder. 2 Input format. 3 Output format.

# Sanity checks ?
# ...
if [[ $1 == -h ]] || [[ $1 == -help ]];
then
echo "***HELP --- Bulkonvert, video converter***

--------------------------------------------------

	Bulkonvert converts videos from the input format to the 
	output format chosen by the user.
	To use it, it's necessary to have original videos in an existing folder. 

-------------------------------------------------
ATTENTION: It will convert ALL videos that have the format indicated.
	---First parameter must be the name of that folder.
	---Second parameter must be the input format.
	---Third parameter must be the output format.

**************************************
Available input/output formats:
   avi      - Microsoft Audio/Video Interleaved
   mpeg     - MPEG-1/2 system stream format
   mp4	    - Vídeo: MPEG-4
**************************************


MENCODER

You need to have mencoder installed in your machine. To install mencoder use: '$ sudo apt-get install mencoder'
	"
elif [[ $# != 3 ]] ;
then
	echo "You must put 3 parameters. Thank you. "
	exit 1
elif ! [[ -d $1 ]] 
then 
echo "First parameter must be an existing directory. Check it please."
	exit 2
elif ! [[ -r $1 ]] ;
then 
echo "You don't have the right to read it"
	exit 3
elif ! [[ -w $1 ]] ;
then 
echo "You don't have the right to write on it"
	exit 4
elif [[ $2 = $3 ]] ;
then
echo "You have put the same input and output format. Impossible to convert."
	exit 5
fi
hash mencoder 2>/dev/null
if [[ $? == 1 ]] ;
then
echo "Mencoder is not installed in your computer. Please use -h or -help command to be helped."
	exit 6
fi

if [[ $3 == mpeg ]]
then
salida='mpeg'
else
salida='lavf'
fi

# Main code
if [[ $2 == avi ]] 
then
 echo "Converting from avi"
ls $1*.avi > listoffiles 2> /dev/null


elif [[ $2 == mp4 ]]
then
echo "Converting from mp4"
ls $1*.mp4 > listoffiles 2> /dev/null

elif [[ $2 == mpeg ]]
then
echo "Converting from mpeg"
ls $1*.mpeg > listoffiles 2> /dev/null

else 
echo "Second parameter must be a valid video format. 
Please use -h or -help command to be helped."

exit 7
fi

if [[ $2 == mpeg ]]
then
while read videofile

do
	lengthname=${#videofile}
	namefile=${videofile:0:$lengthname-5}
	mencoder "$videofile" -o "$namefile".$3 -oac mp3lame -ovc lavc -of $salida

done < listoffiles
rm listoffiles
elif [[ $2 == mp4 ]] || [[ $2 == avi ]]
then
while read videofile

do
	lengthname=${#videofile}
	namefile=${videofile:0:$lengthname-4}
	mencoder "$videofile" -o "$namefile".$3 -oac mp3lame -ovc lavc -of $salida

done < listoffiles
rm listoffiles


fi


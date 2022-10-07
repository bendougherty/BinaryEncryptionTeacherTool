#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "You must provide a file with a list of student names or the wordindex file previously generated as an agrument for this script. Run the script with -h option for more information."
	exit
fi

file=$1

help() {
echo "Synopsis:"
echo
echo "This script should be in the same directory as your studentsubmissions directory, the wordlist file, and the file that contains your unique student IDs (one per line). The script takes one argument which is a file. If you are generating student files, then the argument file should contain a list of unique student identifiers (e.g. last names) one per line. If you are checking student submissions, then the argument should be the wordindex file that was generated when you generated the student files. When you generate the student files, the script will create a directory called studentfiles and it will create a separate document for each student named with the unique identifier for that student. The file will contain a key (in hexadecimal) and an encrypted word (also in hexadecimal). After you have received the student submissions, you can run the script with the wordindex file to check the student submission files that are in the studentsubmissions directory, and the script will generate a file called studentreport that will indicate whether each student correct decrypted their word and correctly encrypted their own name (which should be the unique identifier you assigned to them)."
echo
echo "Syntax: xorlab.sh file"
echo
echo "options:"
echo
echo "h        Print this help page"
echo
}

while getopts ":h" option; do
	case $option in
		h) help
		   exit;;
	       \?) echo "Error: Invalid option"
		   exit;;
	esac
done

echo "Select your option:"
echo
echo "1: Generate student files"
echo "2: Check student submissions"
echo
echo -n "Your selection: "
read choice

generate() {
touch wordindex
mkdir studentfiles

while read line
do
	ranwd=$(shuf -n 1 words)
	echo $line $ranwd >> wordindex
	touch ./studentfiles/$line.txt
	echo -n $ranwd > foo
	bstr=$(xxd -p ./foo)
	rm foo
	len=$(expr length $bstr)
	len=$(($len/2))
	key=$(openssl rand -hex $len)
	ctext=$(printf '%x\n' $((0x$bstr ^ 0x$key)))
	echo "Your key is: $key" > ./studentfiles/$line.txt
	echo "Your encrypted string is: $ctext" >> ./studentfiles/$line.txt
done < $file
}

check() {
#echo "Feature not enabled yet."
touch studentreport
date >> studentreport
while read line
do
	name=$(echo $line | awk '{print $1}')
	word=$(echo $line | awk '{print $2}')
	if [ -f "./studentsubmissions/$name" ]; then
		str1=$(head -n 1 ./studentsubmissions/$name)
		if [ $word = $str1 ]; then
			decryptcheck="Word OK"
		else
			decryptcheck="Word NOT OK"
		fi

		str2=$(sed -n '2p' ./studentsubmissions/$name)
		str3=$(sed -n '3p' ./studentsubmissions/$name)
		result=$(printf '%x\n' $((0x$str2 ^ 0x$str3)))
		echo -n $name > foo1
		str4=$(xxd -p ./foo1)
		rm foo1
		
		if [ $result = $str4 ]; then
			encryptcheck="Name OK"
		else
			encryptcheck="Name NOT OK"
		fi
	else
		decryptcheck="No submission"
		encryptcheck="No submission"
	fi
	echo "$name | $decryptcheck | $encryptcheck" >> studentreport
done < $file

}

if [ $choice -eq 1 ]; then
	generate
elif [ $choice -eq 2 ]; then
	check
else
	echo "Your selection was not valid."
fi

#!/bin/bash

FILE="$1"

sha1() {
# IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
# -r prevents backslash escapes from being interpreted.
# || [[ -n $line ]] prevents the last line from being ignored if it doesn't end with a \n (since read returns a non-zero exit code when it encounters EOF).
	while IFS='' read -r line || [[ -n "$line" ]]; do
#		echo "$line -> $( echo -n $line | openssl sha1 | awk '{print $2}')" >> sha1sums.txt
		echo -n $line | openssl sha1 | awk '{print $2}' >> sha1sums.txt
	done < "$FILE"
}

sha256() {
	while IFS='' read -r line || [[ -n "$line" ]]; do
#		echo "$line -> $( echo -n $line | openssl sha256 | awk '{print $2}')" >> sha256sums.txt
		echo -n $line | openssl sha256 | awk '{print $2}' >> sha256sums.txt
	done < "$FILE"
}

md5() {
	while IFS='' read -r line || [[ -n "$line" ]]; do
#		echo "$line -> $( echo -n $line | openssl md5 | awk '{print1 $2}')" >> md5sums.txt
		echo -n $line | openssl md5 | awk '{print $2}' >> md5sums.txt
	done < "$FILE"
}

TIMESTART="$(date +%s%N)"
sha1
TIMESHA1="$(($(date +%s%N)-TIMESTART))"
CHECKPOINT="$(date +%s%N)"
sha256
TIMESHA256="$(($(date +%s%N)-CHECKPOINT))"
CHECKPOINT="$(date +%s%N)"
md5
TIMEMD5="$(($(date +%s%N)-CHECKPOINT))"
TIMEALL="$(($(date +%s%N)-TIMESTART))"

echo "Time in nanoseconds" >> time.txt
echo "Time for SHA1: $TIMESHA1" >> time.txt
echo "Time for SHA256: $TIMESHA256" >> time.txt
echo "Time for MD5: $TIMEMD5" >> time.txt

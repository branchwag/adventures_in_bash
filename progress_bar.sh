#!/usr/bin/env bash

#Note that this is from following a lovely tutorial by YSAP here:
#	https://www.youtube.com/watch?v=U4CzyBXyOms
#go visit his github and star it! :D 
# https://github.com/bahamas10/ysap/blob/main/code/2025-08-21-progress-bar/progress-bar

progress-bar() {
	local current=$1
	local len=$2

	local length=50
	local perc_done=$((current * 100 / len))
	local num_bars=$((perc_done * length / 100))

	echo "processing $current/$len ($perc_done%)"

	local i
	local s='['
	for ((i = 0; i < perc_done; i++)); do
		s+='|'
	done
	for ((i = num_bars; i < length; i++)); do
		s+=' '
	done
	s+=']'

	echo -ne "$s $current/$len ($perc_done%)\r"
}

process-files() {
	local files=("$@")

	sleep .01
}

shopt -s globstar nullglob

echo 'finding files'
files=(./**/*cache)
len=${#files[@]}
echo "found $len files"

i=0
for file in "${files[@]}"; do
	progress-bar "$((i+1))" "$len"
	process-files "$file"

	((i++))
done

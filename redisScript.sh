#!/bin/bash

#export PATH=/app/mpiccInstall/bin:$PATH

#cd /app/stream/FTP/Code/Versions

echo "Which version?"
echo "[ 1: Local, 2: Volumes, 3: BindMounts ]"
read version

if [ $version -eq 1 ]
then
	resultPath=/home/saikrishna/singularity/localResults
	mkdir localResults
else
	if [ $version -eq 2 ]
	then
		resultPath=/home/saikrishna/singularity/volumeResults
		mkdir volumeResults
	else
		resultPath=/home/saikrishna/singularity/bindMountResults
		mkdir bindMountResults
	fi
fi


arr=( 100000 200000 300000 )

rank=( 5 10 )

for i in "${arr[@]}"
do
	for j in "${rank[@]}"
	do
		redis-benchmark -n i -d j --csv >> "$resultPath"/result.csv
	done
	
done
echo "done"
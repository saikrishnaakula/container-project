#!/bin/bash

#export PATH=/app/mpiccInstall/bin:$PATH

#cd /app/stream/FTP/Code/Versions

echo "Which version?"
echo "[ 1: Local, 2: Volumes, 3: BindMounts ]"
read version

cd Versions

if [ $version -eq 1 ]
then
	resultPath=/home/saikrishna/singularity/localResults
	mkdir /home/saikrishna/singularity/localResults
else
	export PATH=/app/mpiccInstall/bin:$PATH
	
	if [ $version -eq 2 ]
	then
		resultPath=/home/saikrishna/singularity/volumeResults
		mkdir volumeResults
	else
		resultPath=/home/saikrishna/singularity/bindMountResults
		mkdir bindMountResults
	fi
fi

arr=(1 2 5 10 25 50 100 250 500)

rank=( 1 2 3 4 )

for i in "${arr[@]}"
do
	x=$((1000000*i))
	
	mpicc -O -DSTREAM_ARRAY_SIZE="$x" stream_mpi.c -o stream."$i"M
	
	for j in "${rank[@]}"
	do
		mpirun -n "$j" ./stream."$i"M >> "$resultPath"/result_"$i"_"$j".txt
	done
	
	rm ./stream."$i"M
done
echo "done"
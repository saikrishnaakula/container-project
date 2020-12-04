import os
import pandas as pd

columns = ["Bandwidth", "Size", "MaxTime", "ReadWrite", "NumParticles", "NumProcesses"]
numParticles = [10, 25, 50, 100, 250]
numProcesses = [1, 2, 3, 4]
def processTxt(file):
    df = pd.DataFrame(columns = columns)
    bandwidth = []
    size = []
    maxTime = []
    readWrite = []
    particle = []
    process = []
    pIdx = 0
    partIdx = 0
    for line in file:
        if "READ" in line:
            text = line.split(" ")
            bandwidth.append(text[4])
            size.append(text[6])
            maxTime.append(text[8])
            readWrite.append("Read")
            particle.append(str(numParticles[partIdx]*100000))
            process.append(str(numProcesses[pIdx]))
            pIdx+=1
            if pIdx==4:
                pIdx = 0
                partIdx+=1
        elif "WRITE" in line:
            text = line.split(" ")
            bandwidth.append(text[4])
            size.append(text[6])
            maxTime.append(text[8])
            readWrite.append("Write")
            particle.append(str(numParticles[partIdx]*100000))
            process.append(str(numProcesses[pIdx]))
        
    df[columns[0]] = bandwidth
    df[columns[1]] = size
    df[columns[2]] = maxTime
    df[columns[3]] = readWrite
    df[columns[4]] = particle
    df[columns[5]] = process

    return df


def processResults():
    # dirs = ["bindMountResults", "localResults", "volumeResults"]
    dirs=["data1"]
    for dir in dirs:
        with open(dir+"/result.txt", 'r') as file:
            df = processTxt(file)
            df.to_csv(dir+".csv")

if __name__=="__main__":
    processResults()
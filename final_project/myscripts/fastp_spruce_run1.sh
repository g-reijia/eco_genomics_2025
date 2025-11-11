#!/bin/bash   
# This script loops through a set of files and using single-end reads
# and cleans the raw data using fastp according to parameters set below

# Next, let's load our required modules:

module purge
module load gcc fastp

# Define the path to picea_rnaseq folder in the class repo.

MYREPO="/gpfs1/cl/ecogen/pbio6800/"

# make a new directory within myresults/ to hold the fastp QC reports

mkdir ${MYREPO}/GroupProjects/picea_rnaseq/cleanreads/fastpRun1_reports

# cd to the location (path) to the fastq data:

cd /gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/fastq_run1

# the wildcard here * allows for the different reps to be captured in the list
# start a loop with this file as the input:

for READ1 in *_R1*.gz
do

# make the output file names: print the fastq name, replace _# with _#_clean
NAME1=$(echo $READ1 | sed "s/_R1/_R1_cleanXX/g")

# print the input and output to screen 
echo $READ1
echo $NAME1

bbduk=/gpfs1/cl/ecogen/pbio6800/GroupProjects/programs/bbmap/bbduk.sh

# call bbduk
$bbduk -i ${READ1} \
in=${READ1} out=/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads/fastq_run1.fq ref=adapters ktrim=r k=23 mink=11 hdist=1 tpe tbo \
-- trimpolya=10 \
done
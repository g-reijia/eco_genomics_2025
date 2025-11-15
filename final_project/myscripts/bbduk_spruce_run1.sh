#!/bin/bash

#SBATCH --job-name=diversityStats

# Name the output file: Re-direct the log file to your home directory
# The first part of the name (%x) will be whatever you name your job 
#SBATCH --output=/users/g/j/gjia/projects/eco_genomics_2025/finalproject/mylogs/%x_%j.out

# Which partition to use: options include short (<3 hrs), general (<48 hrs), or week
#SBATCH --partition=general

# Specify when Slurm should send you e-mail.  You may choose from
# BEGIN, END, FAIL to receive mail, or NONE to skip mail entirely.
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rei.jia@uvm.edu

# Run on a single node with four cpus/cores and 8 GB memory
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G

# Time limit is expressed as days-hrs:min:sec; this is for 24 hours.
#SBATCH --time=24:00:00

bbduk="/gpfs1/cl/ecogen/pbio6800/GroupProjects/programs/bbmap/bbduk.sh"
cd /gpfs1/cl/ecogen/pbio6800/GroupProjects/programs/bbmap
RAWDATA="/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/fastq_run1"
OUTPUT="/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads"

for READ in ${RAWDATA}/*;do

NAME=`basename ${READ}`

$bbduk in=${READ} out=${OUTPUT}/${NAME}.clean.fq \
ref="/gpfs1/cl/ecogen/pbio6800/GroupProjects/programs/bbmap/resources/adapters.fa" \
ktrim=r \
k=23 \
mink=11 \
hdist=1 tpe tbo \
trimpolya=10

done
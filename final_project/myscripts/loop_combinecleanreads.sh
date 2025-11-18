#!/bin/bash

#SBATCH --job-name=combineCleanReads

# Name the output file: Re-direct the log file to your home directory
# The first part of the name (%x) will be whatever you name your job 
#SBATCH --output=/users/g/j/gjia/projects/eco_genomics_2025/final_project/mylogs/%x_%j.out

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

# Define the input directories
DIR1="/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads_run1"
DIR2="/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads_run2"

# Define the output directory for combined files
OUTPUT_DIR="/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/combined_reads"

# Loop through unique sample IDs
for sample_id in $(ls "$DIR1"/*.fastq.*.clean.fq | xargs -n 1 basename); do
   
    # Concatenate R1 reads
    cat "${DIR1}/${sample_id}" "${DIR2}/${sample_id}" > "${OUTPUT_DIR}/${sample_id}"
    
    # Concatenate R2 reads
    cat "${DIR1}/${sample_id}" "${DIR2}/${sample_id}" > "${OUTPUT_DIR}/${sample_id}"
    
    echo "Combined reads for sample: $sample_id"
done

#to run script, find folder that this shell command is in then run it.

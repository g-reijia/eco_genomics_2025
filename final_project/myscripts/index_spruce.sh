#!/bin/sh
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1:00:00 
#SBATCH --job-name=Salmon_index
#SBATCH --output=/users/g/j/gjia/projects/eco_genomics_2025/final_project/mylogs/%x_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rei.jia@uvm.edu

# Echo some Slurm info
echo "Starting Salmon index at: `date`"
echo "Running on node: `hostname`"

module purge

module load gcc/13.3.0-xp3epyt salmon/1.10.2-uhrt76c

# Change to the reference directory
cd /gpfs1/cl/ecogen/pbio6800/Transcriptomics/Reference_Transcriptome

# Run Salmon index
salmon index -t trinity.trimmomatic.above500.noPhiX.fasta -i salmon_index -p 8
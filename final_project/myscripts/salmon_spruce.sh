#!/bin/sh
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1:00:00 
#SBATCH --job-name=Salmon_mapping
#SBATCH --output=/users/g/j/gjia/projects/eco_genomics_2025/final_project/mylogs/%x_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rei.jia@uvm.edu


module purge

module load gcc/13.3.0-xp3epyt salmon/1.10.2-uhrt76c

salmon --version

# Echo some info
echo "Starting Salmon quantification at: `date`"
echo "Running on node: `hostname`"


# Paths
READ_DIR=/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/combined_reads
INDEX_DIR=/gpfs1/cl/ecogen/pbio6800/GroupProjects/hotConifers/salmon_index
OUT_DIR=/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/mapped_reads

cd $READ_DIR

# Loop over all samples
for read1 in *.clean.fq;do
    sample=$(basename "$read1" | sed -E 's/\.R1\.fastq\.gz\.clean\.fq$//')
    
    echo "Starting sample ${sample}"
    # Make sample-specific output folder
    mkdir -p ${OUT_DIR}/${sample}
    # Run Salmon quantification
    salmon quant -i $INDEX_DIR \
                 -l A \
                 -r $read1 \
                 -p 8 \
                 -o ${OUT_DIR}/${sample}
    echo "Sample ${sample} done"
done

echo "Salmon quantification completed at: `date`"
## [Population Genomics Notebook]{.underline}

##### **Fall 2025 Ecological Genomics - [Class website & tutorials.](https://pespenilab.github.io/Ecological-Genomics/)**

##### **Author: G. Rei Jia**

This will keep my notes on population genomics coding sessions!

#### [September 11, 2025 - [Cleaning fastq reads of red spruce](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics2_trimreads.html)]{.underline}

During this class, we wrote a bash script called "fastp.sh" located within my GitHub repo:

-   `~/projects/eco_genomics_2025/population_genomics/myscripts`.

We used this to trim the adapters out of our red spruce fastq sequence files.

The raw fastq files we accessed are on the class share space:

-   `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/fastq/red_spruce`

Then, using the program "fastp", we processed the raw reads and output the cleaned reads to the following directory on the class shared space:

-   `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/cleanreads`

Fastp produced reports for each sample, which I saved into the directory:

-   `~/projects/eco_genomics_2025/population_genomics/myresults/fastp_reports`

The results showed high quality sequence, with most Q-scores being \>\> 20, and low amount of adapted contamination, which we trimmed out. We also trimmed the leading 12bp to get rid of the barcoded indices.

Cleaned reads are now ready to proceed to the next step in our pipeline: mapping to the reference genome!!!

#### [September 16, 2025 - [Mapping cleaned reads to reference genome](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics3_mapping.html)]{.underline}

We copied the scripts from the shared space and put them into our own repo using the following UNIX code:

-   `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/`
-   `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/scripts`
-   `~/projects/eco_genomics_2025/population_genomics/myscripts`

After copying the scripts over, we edited the bash script "mapping.sh" and included details from the "SBATCH_header.txt" file to customize what we are asking the VACC to do (i.e. file input, file output, nodes, cpu, etc). We submitted the bash script to the VACC using the following UNIX code:

-   `sbatch ~/projects/eco_genomics_2025/population_genomics/myscripts/mapping.sh`

After submitting the job on the VACC, we then edited the "process_bam.sh" file which will do the following:

1.  Convert .sam to .bam files
2.  Sort the bam files - all contigs and reads will be sorted in order
3.  Use the rmdup command to remove PCR duplicates from the bam files
4.  Index the bam files.

Then, we created a new file called "process_stats_wrapped.sh" which combines the scripts "process_bam.sh" and "bam_stats.sh" and wraps them, which tells the two scripts to run together. We saved this new file into our own personal directory, using the UNIX code:

-   `~/projects/eco_genomics_2025/population_genomics/myscripts/`

My files began running on the VACC during the end of class time. Once I get an email confirming my files were processed, I will run the "process_stats_wrapped.sh" file which will run the wrapper using the following code:

-   `sbatch ~/projects/eco_genomics_2025/population_genomics/myscripts/process_stats_wrapped.sh`

## Population Genomics Notebook

##### **Fall 2025 Ecological Genomics - [Class website & tutorials.](https://pespenilab.github.io/Ecological-Genomics/)**

##### **Author: G. Rei Jia**

This will keep my notes on population genomics coding sessions!

#### September 11, 2025 - [Cleaning fastq reads of red spruce](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics2_trimreads.html)

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

#### September 16, 2025 - [Mapping cleaned reads to reference genome](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics3_mapping.html)

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

The next day, I ran the sbatch script above and the files were saved into my `myscripts` folder.

#### September 18, 2025 - Review bamstats and set up [nucleotide diversity estimation using ANGSD](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics4_Diversity.html)

-   Wrote a short script called "bamstats_review.r" located in `myscripts` to evaluate the mapping success

    -   Saw roughly 60% of reads mapped in proper pairs

    -   Obtained depth of coverage between 2-3x -\> suggests we need to use a probabilistic framework for analyzing the genotype data.

We then created a bash script to set up ANGSD to estimate nucleotide diversity, which is saved in `myscripts/` folder titled "ANGSD.sh". This script created a folder in `mydata/` which is populated by a file called "2100_bam.list". The bash script was run using the following code:

-   `bash ANGSD.sh`

Then, we added another chunk of code in the "ANGSD.sh" file in order to run the ANGSD portion of the script.

We then made a wrapper script to begin analyzing nucleotide diversity. This filed is called "ANGSD_doThetas.sh" located in `myscripts/` folder. We sent this script to the VACC and the output file is stored in `mylogs/`.

#### September 23, 2025 - [Visualizing genomic diversity and intro to population structure](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics5_PopStructure.html)

During this class, we made a RMarkdown document that has theta results from ANGSD. The script we used for this is called "Nucleotide_Diversity.Rmd" which is located in `mydocs/` folder. Here, we plotted nSites, Tajima's D, and theta-W and pi.

We then populated a spreadsheet with the classes' results [here](https://docs.google.com/spreadsheets/d/1SLwhW3OgQiX2z1rxH-ske236NYxjDXCvUu0l8XFeS_w/edit?gid=0#gid=0).

#### September 25, 2025 - [Visualizing genomic diversity and intro to population structure](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics5_PopStructure.html)

During today's class, we estimated the Fst and wrote a bash script called "ANGSD_FST.sh" that is locate in `myscripts/` folder. We then sent that to the VACC and it ran. My Fst value was 0.307832.

Then, we ran PCAngsd using all samples (not just our population). The files that we are going to use to store the genoytpe likelihoods can be found using this path:

-   `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/scripts/ANGSD_RSBS_poly.sh`

We then made a batch script called "PCAngsd_RSBS.sh", which can be found in `myscripts/` folder and sent it to the VACC.

Then, we made an RMarkdown document plotting the red spruce-black spruce genetic PCAs and admixture analysis. This document is called `PCA_Admix.Rmd` and can be found in in `/mydocs`.

#### September 30, 2025 - [Genome scan for selection](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_PopGenomics6_Selection.html)

Today, we reviewed the script from last class looking at the PCA_Admixture (`PCA_Admix.html`) and made a Principal component analysis (PCA) with the 95 red spruce and 18 black spruce samples (N=113 total). We used the beagle file in the class datashare with the genotype likelihoods already computed. This file can be found at:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ANGSD/RSBS_poly.beagle.gz`

During last week's class, we made a file called `PCAngsd_RSBS.sh`, where k=2. Today, we created a new file by only including rdata from ed spruce to test for selection. This is file, titled `PCAngst_allRS_selection.sh` is an updated version of the `PCAngsd_RSBS.sh` file, where we set k=3 and included the following options at the end of this script (below). This new script is located in `/myscripts`.

-   --selection-eig \$E

-   --selection

-   --sites-save

-   --maf-save

-   --snp-weights

Once we ran the above bash script, we made a new RMarkdown file titled `RedSpruce_Selection.Rmd` and created scree, PCA, and Manhattan plot swith red spruce ONLY. This file can be found in `mydocs/`. Notes on each of the plots and the analysis are embedded in the RMarkdown file.

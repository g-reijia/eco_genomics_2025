# Final Group Project Notes

##### **Author: G. Rei Jia \| Fall 2025 Ecological Genomics - [Class website & tutorials.](https://pespenilab.github.io/Ecological-Genomics/)**

#### November 6, 2025 - Thoughts/Project pitch

I am in a group with Maddie and Nico and we are using a combination of the exome-capture and transcriptomics data to evaluate red spruce adaptation to drought and heat.

-   **Research question:** Do any of the genes that have introgressed from black spruce impact heat and/or drought tolerance in red spruce?

-   **Hypothesis:** Black spruce SNPs have been retained in red spruce because they increase heat and drought tolerance.

**Approach: Project Outline/Bioinformatics Pipeline**

1.  Identify signatures of selection on black spruce genes in red spruce.

    -   Run association test, ANGSD

2.  Conduct transcriptomics analysis to identify differentially expressed genes in three treatments: control, heat, heat & drought.

    -   Build pipeline to trim/clean reads, align to reference transcriptome, use DESeq2, test for functional enrichment using TopGO, input results into REViGO.

3.  Identify and calculate overlap (or lack thereof) between 1 and 2.

4.  Determine if selectively introgressed genes are responsible for differential expression.

#### November 11, 2025 - Trim and clean reads

The RNASeq red spruce raw reads that we got from Steve need to be trimmed and cleaned.

-   This data is different than the raw reads we used in the popgen and transcriptomics modules because instead of pair-end reads, these are single-end reads.

-   Every sample has 2 fastq files, one from each of the two different runs, analyze them together. Clean and combine into a single fastq file before salmon

-   Instead of using fastp to trim/clean, Steve recommended to Max (who is also using the picea rnaseq data) and I that we use BBDuk.

-   Have to trim polyA tails and remove adapter sequences, decided to trim polyA sequences with \>10 bp.

-   In BBDuk bash script, to remove adapter sequences, include at the end when calling the program?

Resources:

-   [BBTools](https://github.com/bbushnell/BBTools) - GitHub repository

-   [BBDuk Guide](https://archive.jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/) - JGI web archive

**Pipeline for this step:**

-   Worked together w/ Max to figure out how to clean the reads. Bash scripts for both runs can be found in my `myscripts/` folder. Files are called `bbduk_spruce_run1.sh` and `bbduk_spruce_run2.sh`

-   Cleaned reads output into `/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads`

#### November 15, 2025

For some reason neither of my `bbduk_spruce_run1.sh` or `bbduk_spruce_run2.sh` scripts work? Going to consult with Max about this and see what he did differently.

#### November 18, 2025

-   Max re-ran the bbduk scripts to distinguish files between run 1 and run 2.

-   Copied any files from `cleanreads_run2/` with new naming convention using wildcard. Used the following line of code in terminal to do it:

    `cp /gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/cleanreads_run2/*.fastq.gz_run2.clean.fq /gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/combine_reads`

-   Currently writing bash script with loop to combine the reads

-   Spoke to Steve about how to index the reads:

    -   In terminal, this gets us to the help menu:

        -   Module load gcc salmon \> salmon -h \> salmon index -h

    -   Then use command **-t** to input transcript fasta file

        -   Salmon index -t **[reference transcriptome]**

-   Reference transcriptome found here: `/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/annotation/Pmariana-v1-transcripts.fa`

-   Chatted w/ Steve about the bash script that I wrote to combine reads and it can be found in `myscripts/`. The script is called `combine_cleanreads.sh`.

-   Combined reads worked, yay!

-   Tried to index the reference transcriptome but for some reason I am not getting it right. Will need to ask Melissa or Steve what's up with that

#### November 20, 2025

-   Figured out the indexing issues and wrote a bash script to index, map and quantify read, and prepare a counts matrix file to be imported into DESeq2.

-   Each of the scripts can be found in `myscripts/` folder, titled `index_spruce.sh` and `salmon_spruce.sh`.

#### December 2, 2025

-   Began writing DESeq2 monster Rmd script used to visualize reads and variation in the sequences. Visualized global variation in gene expression using PCA, which showed some general clustering of genes from the same source climate.

-   From initial analyses using data from each harvest days (and talking to Steve and Max about it), there were minimal up- and down-regulated genes in days 0 and 5. Decided to subset to only include data from harvest day 10.

-   I could not for the life of me figure out how to read.delim the Pmariana GO annotations file for functional enrichment, so I generated volcano plots to show up- and down-regulated genes using the contrast groups generated from DESeq2 analysis.

#### December 4-8, 2025

-   After looking at the volcano plots for forever and doing our final presentations in class, I received some very helpful feedback from Melissa about manually changing the contrasts instead of utilizing the groups that were generated from DESeq2.

    -   I could either do a comparison of both source climate across each treatment group or do a pairwise comparison of CoolWet vs. HotDry. I decided to do the former.

-   Maddie also helped me properly read in the Pmariana GO annotations file!

-   When I initially ran my functional enrichment, there were so many issues!! When I compared each contrast to one another, I kept on getting a warning message that said "No enrichment can pe performed - there are no feasible GO terms!" for 4 out of the 6 contrasts I was comparing which was strange. I ended up getting help from Maddie, Melissa, and Steve who helped me with the following:

    -   Maddie - helped me properly read in the dataframes I will need for functional enrichment.

    -   Melissa - read over my `DESeq2ToTopGo_spruce.Rmd` file to look at any mistakes in the code. Helped me figure out issues with merging the dataframes.

    -   Steve - read over read over my `DESeq2ToTopGo_spruce.Rmd` file to look at any mistakes in the code and helped me realize that instead of reading in a semi-colon separated file, I was reading in a comma-separated file.

-   The helped I received fixed everything and I got functional enrichment to work! Thanks Maddie, Melissa, and Steve. I was then able to generate .txt files with geneID and GO terms to input into REViGO.

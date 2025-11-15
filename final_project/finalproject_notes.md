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

#### November 15, 2025 - Trim and clean reads

For some reason neither of my `bbduk_spruce_run1.sh` or `bbduk_spruce_run2.sh` scripts work? Going to consult with Max about this and see what he did differently.

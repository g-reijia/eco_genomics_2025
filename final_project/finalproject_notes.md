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

-   The raw data that we got from Steve

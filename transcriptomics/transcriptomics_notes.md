# Transcriptomics Notebook

##### **Author: G. Rei Jia \| Fall 2025 Ecological Genomics - [Class website & tutorials.](https://pespenilab.github.io/Ecological-Genomics/)**

This will keep my notes on transcriptomics coding sessions!

#### October 7, 2025 - [Clean and visualize reads](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics2_VisualizeCleanVisualize.html)

Today, we started the Transcriptomics module of the course!!!!

We learned about the motivation and process of asking questions and analyzing RNAseq data.

We then accessed raw data files, which can be found here:

-   `/gpfs1/cl/ecogen/pbio6800/Transcriptomics/RawData`

We then chose our samples (mine is C1) and edited the bash script, titled `fastp_tonsa.sh`. We ran into some issues with the script and will edit it next class.

#### October 9, 2025 - [Clean and visualize reads](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics2_VisualizeCleanVisualize.html)

We began today's coding session by editing and running the `fastp_tonsa.sh` bash script, which generated fastq reports and is housed in my `myresults/fastp_reports` folder.

We then copied the script `salmon_quant.sh` from `/gpfs1/cl/ecogen/pbio6800/Transcriptomics/scripts` into our own `myscripts/` folder and edited it and customized the script based on our repositories and sent in the mapping script.

#### October 14, 2025 - [Mapping and creating a counts matrix](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics3_MappingToCountsMatrix.html) and [import to DESeq2 and visualize](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics4_GeneExpressionAnalysis.html)

We began class by looking at the Salmon mapped reads in:

-   `/gpfs1/cl/ecogen/pbio6800/Transcriptomics`

Then, we looked into all of the samples and in terminal, used the function:

-   `grep -r –include \*.log -e 'Mapping rate'`

From this, we observed low mapping rates from \~30%-60 (80% is ideal). We are interested in using these mapping rates later, so we then saved the list of mapping rates into our own results folder by using the bash code:

-   `grep -r –include \*.log -e 'Mapping rate' > ~/projects/eco_genomics_2025/transcriptomics/myresults/mapping_rates_list.txt`

We then made another mapping rate file with ONLY sample names and mapping rates and saved the new list of mapping rates into our own results folder by using the bash code:

-   `grep -r –include \*.log -e 'Mapping rate' | sed -E 's|/logs/.*:.*Mapping rate = ([0-9.]+)%|\t\1|' > ~/projects/eco_genomics_2025/transcriptomics/myresults/mapping_rate.txt`

In order to prepare this data to be imported into DESeq2, we created a data matrix including all of the mapped reads. The code we used to do this is called `create_count_matrix.R` found in `mydata/` folder.

#### **!! DESeq2 - start of DNA analysis !!**

We began by copying over `metadata.txt` file from:

-   `/gpfs1/cl/ecogen/pbio6800/Transcriptomics`

Then wrote an RMarkdown file titled `DESeq2_tonsa_multigen.Rmd` to visualize reads, variation, and global variation in gene expression using PCA.

In the first chunk of code, we explored the data distributions by looking at the variance across samples and variance across genes.

In the second chunk of code, we started working with DESeq2. Here, we began by correcting the column names to match between the metadata table and the counts matrix. Then, we started filtering out genes with too few reads and removed all genes with counts \< 15.

#### October 16, 2025 - [Import to DESeq2 and visualize](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics4_GeneExpressionAnalysis.html)

During today's class, we began visualizing the dataset by making a heat map, cluster tree, and PCA plot, outlined in the RMarkdown file `DEseq2_tonsa_multigen.Rmd`

*Notes:*

-   Types of distribution: Negative binomial, poisson, and gaussian.

-   What is size factor? - DESeq does this to scale everything to try to compare data using like factors.

-   Looking at different variables to test specific contrasts:

    -   Change reference from "control" to treatment"

    -   Change contrast groups from contrast=c("group","controlG1","treatmentG1") to not include "G1".

#### October 21, 2025 - [Import to DESeq2 and visualize](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics4_GeneExpressionAnalysis.html)

In today's class, we continued visualizing the dataset by making an MA plot, volcano plot, several heatmaps, and a Venn Diagram which are outlined in the RMarkdown file `DEseq2_tonsa_multigen.Rmd.` Each plot is meant to show us the following:

-   MA plot - Plotting the relationship between LFC and magnitude of expression.

-   Volcano plot - Plotting the relationship between LFC and significance of DGE in Generation 1, comparing control and treatment.

-   Heatmaps - Plotting relative expression on gene and sample level

    -   Heatmap 1: Plotting top 20 genes sorted by p-value.

    -   Heatmap 2: Plotting LFC and G1 significant genes and how they change across generations.

    -   Heatmap 3: Plotting LFC and G2 significant genes and how they change across generations.

-   Venn Diagram - Plotting overlap between genes differentially expressed between treatments across generations.

#### October 23, 2025 - [Functional enrichment analysis](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics5_FunctionalEnrichment.html)

Today, we began the next tutorial on understanding Gene Ontology (GO) and functional enrichment statistical tests. Here we made a functional enrichment analysis with our data using TopGO.

We created a new RMarkdown file called `DESeq2ToTopGo.Rmd`, which can be found in `mydata/` folder.

First, we began by visualizing our data using several different plot types. Then, we created a topGO plot and REVIGO plot.

#### October 28, 2025 - [Weighted Gene Correlation Network Analysis (WGCNA)](https://pespenilab.github.io/Ecological-Genomics/Fall2025/tutorials/EcoGen2025_Transcriptomics6_CorrelationNetworkAnalyses.html)

Today, we began the next tutorial on WGCNA. We created a new RMarkdown file called `DESeq2ToWGCNA.Rmd`, which can be found in `mydata/` folder.

We began by doing basic DESeq2 data filtering, then copied trait data, `WGCNA_TraitData.csv` from `/gpfs1/cl/ecogen/pbio6800/Transcriptomics/enrichment` to `mydata/` folder and imported it to this RMarkdown file. We then chose a set of soft-thresholding powers and plotted the threshold powers to visualize them.

Once we began Network Construction, I chose a soft-thresholding power = 24. We then plotted dendrograms of modules and visualized the correlation between each eigengene of each module and the imported ULT trait data. Because I chose the soft-threshold power = 24, my correlation showed that my module was MEsalmon, with a p-value of 0.48 and plotted the eigengene correlation. Finally, we looked at GO categories are present in any modules correlated with ULT. From this, my unique GO categories are: <GO:0016746>, <GO:0005634>, <GO:0000276>, <GO:0015078>, and <GO:0015986>. When these categories were submitted to REVIGO, each term was associated with proton motive force-driven ATP synthesis.

#### November 4, 2025 - Submission for Homework 2 Plan

**Question:** *What are the functional differences among genes differentially expressed at G1 vs. G2 vs. G3 vs. G4?*

**Analysis and Visualization Strategy:** I will begin by using DESeq2 to set up contrasts to compare treatment versus control between each generation. Then, I will input the results into TopGO, which will find gene ontology terms. Finally, I will use a bioconductor package called "rrvgo" ([Sayols, 2023](https://pmc.ncbi.nlm.nih.gov/articles/PMC10155054/)) to compare GO enrichment results and reduce redundancy.

Creative or Unique Visualization: Using rrvgo, I will generate several plots to show gene ontology results. One unique plot that I will use to visualize this data is a treemap that combines like gene ontology terms into parent terms. The size of both the parent and child terms are organized by score, which determines the size of the boxes.

**Anticipated challenges or areas of support:** In this assignment, I anticipate that I will need further support in understanding the DESeq2 script that we generated during class time. Additionally, instead of using REViGO like we did in class, I am attempting to try to use a new package that is new to me. Although this will be a challenge, according to the creator of rrvgo, it is heavily influenced by REViGO, so hopefully there is overlap. If I have time, in addition to my first analysis, I would be interested in comparing REViGO and rrvgo to see if both yield the same results.

**References:** Sayols, S. (2023). rrvgo: a Bioconductor package for interpreting lists of Gene Ontology terms. *PubMed*, *2023*. <https://doi.org/10.17912/micropub.biology.000811>

#### [**Homework 2 Notes:**]{.underline}

**November 5, 2025**

-   Began assignment by making a copy of `DESeq2ToTopGO.Rmd` script from Tutorial 4 that we reviewed during class and calling it `HW2.Rmd`. This script can be found in `mydocs/` folder.

-   Edited `DESeq2ToTopGO.Rmd` script to run TopGO analysis across each of the generations.

**November 8, 2025**

-   Tried for hours to figure out how to use "rrvgo" bioconductor package with no success. May have to do with package not having a genome wide annotation for copepods, but not entirely sure. Will ask Melissa about this during office hours after assignment submission.

-   Decided to pivot and instead of using the rrvgo package, I used REViGO. To do this, I used the script from Tutorial 5 to make .txt files for Generations 1 through 4 and will input those into REViGO.

**November 9, 2025**

-   Input each .txt file into REViGO and generated treemaps of each generation (as I mentioned that I would do in my HW2 plan).

-   After inputting each of the .txt files into REViGO, there were several warnings which indicated that some GO terms and their genes were removed from plots due to being "obsolete" as they either "represent a molecular function" or "because it is an unnecessary grouping class". In addition, when each treemap was generated, some of the nested rectangles did not show the GO term unless I hovered my mouse above each individual rectangle. Therefore, I decided to subset each .txt file to only show the top 32 genes from each generation (using generation 1 as a reference for how many genes to subset) and arranged them in ascending order by p-value. I then exported each file and input results into REViGO again. Talk about this in the Results section?

-   Exported R scripts for treemaps of each generation to arrange them aesthetically.

-   Because I didn't get rrvgo to work, I couldn't compare results between rrvgo and REViGO.

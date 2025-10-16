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

-   Continuation from last class.

During today's class, we began visualizing the dataset by making a heat map, cluster tree, and PCA plot, outlined in the RMarkdown file `DEseq2_tonsa_multigen.Rmd`

*Notes:*

-   Types of distribution: Negative binomial, poisson, and gaussian.

-   What is size factor? - DESeq does this to scale everything to try to compare data using like factors.

-   Looking at different variables to test specific contrasts:

    -   Change reference from "control" to treatment"

    -   Change contrast groups from contrast=c("group","controlG1","treatmentG1") to not include "G1".

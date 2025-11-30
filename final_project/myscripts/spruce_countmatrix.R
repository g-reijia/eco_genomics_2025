# Load libraries
library(tximport)
library(readr)

# Path to sample table
samples <- read.csv("/gpfs1/home/g/j/gjia/projects/eco_genomics_2025/final_project/myresults/samples.csv")

# Make a named vector of quant.sf file paths
files <- file.path(samples$path, "quant.sf")
names(files) <- samples$sample

# Import Salmon quantifications
txi <- tximport(files, type = "salmon", txOut = FALSE)

# Write counts to CSV
write.table(txi$counts, "/gpfs1/home/g/j/gjia/projects/eco_genomics_2025/final_project/mydata/counts_table.txt")
